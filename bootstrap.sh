#!/usr/bin/env bash
# bootstrap.sh
# ------------
# This is the very first script a new Mac runs. It gets this repository onto
# the Mac and then hands off to setup.sh. You run it by pasting one line into
# Terminal (the README shows it):
#
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/LWHSTechnicalArts/DeveloperTools/main/bootstrap.sh)"
#
# That line works before the repository is on your Mac: curl downloads this
# file from GitHub, and "$( ... )" hands its text to bash to run.
#
# The script does three things:
#   1. Installs Apple's Command Line Tools, which include git, if they are
#      missing.
#   2. Downloads this repository into ~/DeveloperTools with git, or updates
#      it if it is already there.
#   3. Runs setup.sh, which installs the programs and links the settings.
#
# configure.sh explains the basics (comments, variables, functions, "if",
# arrays, and "for" loops). This file explains the new things it uses.


# Stop on any failure, on unset variables, and on failures inside pipelines.
set -euo pipefail


# --- Settings ---------------------------------------------------------------
repository_url="https://github.com/LWHSTechnicalArts/DeveloperTools.git"
repository_directory="$HOME/DeveloperTools"


# --- Functions --------------------------------------------------------------

# print_step prints a heading so you can follow the script's progress.
print_step() {
    echo -e "\n==> $1"
}

# get_command_line_tools_label asks Apple's software update service for the
# name of the newest Command Line Tools package, and prints that name.
# It prints nothing if the service does not offer one.
get_command_line_tools_label() {
    # A "pipeline" connects commands with "|": each command's output becomes
    # the next command's input. Step by step:
    #   softwareupdate -l   lists the updates Apple offers this Mac
    #   grep -B 1 ...       keeps lines mentioning Command Line Tools, plus
    #                       the 1 line Before each, where the name appears
    #   awk ...             keeps the text after "*" on lines starting with "*"
    #   sed ...             removes the "Label: " prefix and leading spaces
    #   sort -V | tail -n 1 sorts by version number and keeps the last (newest)
    # This is the same method Homebrew's installer uses.
    # "|| true" makes the function succeed even when nothing matches, because
    # "set -e" and "pipefail" would otherwise stop the script.
    softwareupdate -l 2> /dev/null \
        | grep -B 1 -E "Command Line Tools" \
        | awk -F "*" '/^ *\*/ {print $2}' \
        | sed -e "s/^ *Label: //" -e "s/^ *//" \
        | sort -V \
        | tail -n 1 \
        || true
}


# --- 1. Command Line Tools --------------------------------------------------
print_step "Apple Command Line Tools (for git)"

# "xcode-select -p" prints where Apple's developer tools are installed, and
# fails if they are not. A brand-new Mac has a "git" command that only offers
# to install the tools, so checking xcode-select is the reliable test.
if xcode-select -p &> /dev/null; then
    echo "Already installed: $(xcode-select -p)"
else
    echo "Installing Apple's Command Line Tools. This can take 10 minutes or more."
    echo "Type your Mac password when asked. Nothing appears on screen while you type."

    # softwareupdate only lists the Command Line Tools while this empty
    # "placeholder" file exists. "sudo" runs a command as an administrator.
    command_line_tools_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    sudo touch "$command_line_tools_placeholder"

    command_line_tools_label="$(get_command_line_tools_label)"

    if [ -n "$command_line_tools_label" ]; then
        echo "Installing $command_line_tools_label"
        # -i installs the named package, with no window to click through.
        sudo softwareupdate -i "$command_line_tools_label"
    fi

    # rm -f deletes a file. -f means "do not complain if it is already gone."
    sudo rm -f "$command_line_tools_placeholder"

    # If the quiet method did not work, fall back to Apple's install window.
    if ! xcode-select -p &> /dev/null; then
        xcode-select --install
        echo "A window opened asking to install the Command Line Tools."
        echo "Click Install, then Agree, and wait for it to finish."
        # read waits for you to press Return. "-p" shows a message first.
        read -r -p "When the installation has finished, press Return here to continue. "
    fi

    # Stop with a clear message if the tools are still missing.
    if ! xcode-select -p &> /dev/null; then
        echo "The Command Line Tools are still not installed. Ask your teacher for help." >&2
        exit 1
    fi
fi


# --- 2. This repository -----------------------------------------------------
print_step "Downloading DeveloperTools to $repository_directory"

# -d "$repository_directory/.git" is true if the folder is a git repository:
# git keeps its records in a hidden folder named .git.
if [ -d "$repository_directory/.git" ]; then
    echo "Already downloaded. Updating it to the newest version."
    # "git -C FOLDER" runs git as if you had cd'd into FOLDER.
    # "pull --ff-only" downloads new changes, but only if that cannot clash
    # with changes made on this Mac. If it would, the script keeps going with
    # the copy already here instead of stopping.
    if ! git -C "$repository_directory" pull --ff-only; then
        echo "Could not update; continuing with the copy already on this Mac."
    fi
elif [ -e "$repository_directory" ]; then
    # -e is true if anything at all exists at the path.
    echo "$repository_directory already exists but is not a copy of this repository." >&2
    echo "Rename or move it, then run this command again." >&2
    exit 1
else
    git clone "$repository_url" "$repository_directory"
fi


# --- 3. Hand off to setup.sh ------------------------------------------------
print_step "Running setup.sh"

# "exec" replaces this script with setup.sh instead of running it alongside,
# so setup.sh's success or failure becomes this script's result.
exec bash "$repository_directory/setup.sh"
