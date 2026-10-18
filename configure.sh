#!/usr/bin/env bash
# ^ The first line is called a "shebang." It tells the computer which program
#   should run this file. "/usr/bin/env bash" means "find bash and use it."
#
# configure.sh
# ------------
# This script links your configuration files to the copies stored in this
# repository, so the repository becomes the one place where those files live.
# If a file is already in the way, the script moves it into a dated backup
# folder first, so nothing gets lost. Then it installs the Visual Studio Code
# extensions listed in vscode/extensions.txt.
#
# setup.sh runs this script after install.sh. You can also run it by itself
# when the programs are already installed.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash configure.sh
#
# Every line that starts with "#" is a comment. Bash skips comments; they are
# only there for people reading the file.


# --- Safety settings --------------------------------------------------------
# "set" changes how bash behaves while this script runs:
#   -e  stop the script as soon as any command fails
#   -u  stop if the script uses a variable that was never given a value
#   -o pipefail  count a failure anywhere in a pipeline (a | b | c) as a failure
set -euo pipefail


# --- Functions --------------------------------------------------------------
# A function is a named group of commands that you can run again and again.
# You define it once with "name() { ... }" and then run it by typing its name.
# Inside a function, "$1" is the first thing passed to it, "$2" the second,
# and so on.

# get_repository_directory prints the full path of the folder this script is
# in. Bash functions "return" text by printing it with echo; whoever calls the
# function captures that text with $( ... ).
get_repository_directory() {
    # ${BASH_SOURCE[0]} is the path of this script file.
    # dirname strips the file name and leaves the folder.
    # cd into that folder, then pwd ("print working directory") prints its
    # full path. The parentheses run this in a sub-shell, so the cd does not
    # affect the rest of the script.
    (cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
}

# link_configuration_file makes one symbolic link ("symlink").
# A symlink is a signpost file: when a program opens it, the computer follows
# the signpost to the real file somewhere else.
#   $1 = the real file inside this repository (where the signpost points)
#   $2 = the place programs expect to find the file (where the signpost goes)
link_configuration_file() {
    # "local" keeps these variables inside this function only.
    local source_path="$1"
    local target_path="$2"

    # "if [ ... ]; then ... fi" runs the commands only when the test is true.
    #   -L  true if the path is a symlink
    #   -e  true if something exists at the path
    # readlink prints where a symlink points. If the link already points at
    # our file, there is nothing to do, so "return" leaves the function early.
    if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
        echo "Already linked: $target_path"
        return
    fi

    # If anything else is in the way (a real file, a folder, or a link that
    # points somewhere else), move it into the backup folder.
    # "||" means "or": the test passes if either side is true. A broken link
    # fails -e but passes -L, so checking both catches every case.
    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        # mkdir -p creates the folder, plus any missing parent folders, and
        # does nothing if the folder already exists.
        mkdir -p "$backup_directory"
        # basename keeps only the last part of a path: the file or folder name.
        # "local" means backup_path exists only while this function runs and
        # disappears when it finishes, just like source_path and target_path.
        # Without "local", a bash variable created inside a function stays
        # around for the rest of the script. backup_count, a few lines below,
        # leaves out "local" on purpose, because the end of the script needs
        # to read it.
        local backup_path="$backup_directory/$(basename "$target_path")"
        mv "$target_path" "$backup_path"
        echo "Backed up:      $target_path -> $backup_path"
        # $(( ... )) does arithmetic. This adds 1 to the running count of
        # backed-up files, which the end of the script reports.
        backup_count=$(( backup_count + 1 ))
    fi

    # On a new machine, the folder that should hold the link may not exist
    # yet (for example, ~/.vscode/extensions before Visual Studio Code is
    # first opened).
    mkdir -p "$(dirname "$target_path")"

    # ln -s SOURCE TARGET creates the symlink at TARGET pointing to SOURCE.
    ln -s "$source_path" "$target_path"
    echo "Linked:         $target_path -> $source_path"
}

# get_code_command prints the path of Visual Studio Code's command-line tool,
# "code", or prints nothing if Visual Studio Code is not installed.
get_code_command() {
    # A fresh install does not put "code" on the command path, but the tool is
    # always inside the app at this location.
    local application_code_path="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

    # "command -v code" prints where the code command is if it is on the
    # command path, and fails if it is not. "> /dev/null" throws that printed
    # text away, because this test only cares whether the command succeeded.
    if command -v code > /dev/null; then
        command -v code
    # "elif" means "else if": bash tries this test only when the one above
    # was false.
    #   -x  true if the file exists and can be run as a program
    elif [ -x "$application_code_path" ]; then
        echo "$application_code_path"
    fi
}


# --- Settings ---------------------------------------------------------------
# A variable stores a value. You assign it with NAME=value (no spaces around
# "=") and read it back with "$NAME". Wrapping it in double quotes keeps paths
# with spaces, like "Application Support", in one piece.

# $( ... ) runs a command and puts its printed output here.
repository_directory="$(get_repository_directory)"

# $HOME is your home folder, for example /Users/yourname.
# date +%Y-%m-%d_%H-%M-%S prints the current date and time, such as
# 2026-10-17_20-30-00, so every run gets its own backup folder.
backup_directory="$HOME/DeveloperTools-backups/$(date +%Y-%m-%d_%H-%M-%S)"

# backup_count starts at 0 and goes up by 1 each time a file is backed up.
backup_count=0

# An array is a variable that holds a list. Write it with parentheses and
# read one item with "${array_name[number]}". Counting starts at 0, so the
# first item is number 0.
#
# These two arrays are lined up: item 0 in source_paths belongs with item 0
# in target_paths, item 1 with item 1, and so on.
source_paths=(
    "$repository_directory/.zshrc"
    "$repository_directory/p5js-editor-light.p10k.zsh"
    "$repository_directory/vscode/settings.json"
    "$repository_directory/vscode/p5js-editor-light"
)
target_paths=(
    "$HOME/.zshrc"
    "$HOME/.p10k.zsh"
    "$HOME/Library/Application Support/Code/User/settings.json"
    "$HOME/.vscode/extensions/p5js-editor-light"
)

# The list of Visual Studio Code extensions to install, one per line.
extensions_file="$repository_directory/vscode/extensions.txt"


# --- Main work --------------------------------------------------------------
echo "Linking configuration files from $repository_directory"

# "${#source_paths[@]}" is the number of items in the array (here, 4).
file_count="${#source_paths[@]}"

# This "for" loop counts index from 0 up to, but not including, file_count.
#   index = 0           start at 0
#   index < file_count  keep going while this is true
#   index++             add 1 after each pass
# Each pass links one source file to its matching target.
for (( index = 0; index < file_count; index++ )); do
    link_configuration_file "${source_paths[index]}" "${target_paths[index]}"
done

# Report where the backups went, but only if the script made any.
#   -gt  means "greater than" when comparing numbers inside [ ... ]
if [ "$backup_count" -gt 0 ]; then
    echo "Backed up $backup_count file(s) to $backup_directory"
fi


# --- Visual Studio Code extensions ------------------------------------------
echo "Installing Visual Studio Code extensions listed in $extensions_file"

# Read the file one line at a time into the extension_ids array.
# "while" repeats as long as its test succeeds. "read -r line" reads one line
# into the variable "line" and fails when no lines are left, which ends the
# loop. The "< file" after "done" feeds the file into the loop.
#   -r  keeps read from treating backslashes as special
# read also trims spaces from both ends of the line, so a line of only spaces
# counts as blank.
# "|| [ -n "$line" ]" keeps the last line even when the file does not end
# with a newline character. -n is true if the text is not empty.
extension_ids=()
while read -r line || [ -n "$line" ]; do
    # Skip blank lines and comment lines.
    #   -z  true if the text is empty
    # [[ ... ]] is bash's more powerful test. "==" with a pattern on the right
    # checks whether the text matches it; "#"* means "starts with #".
    # "continue" jumps straight to the next pass of the loop.
    if [ -z "$line" ] || [[ "$line" == "#"* ]]; then
        continue
    fi
    # "+=" adds an item to the end of an array.
    extension_ids+=("$line")
done < "$extensions_file"

code_command="$(get_code_command)"

if [ -z "$code_command" ]; then
    echo "Skipped extensions: Visual Studio Code is not installed in /Applications."
else
    extension_count="${#extension_ids[@]}"
    for (( index = 0; index < extension_count; index++ )); do
        # --install-extension downloads and installs one extension. If it is
        # already installed, code says so and moves on. If an install fails
        # (for example, with no internet), "set -e" stops the script here.
        "$code_command" --install-extension "${extension_ids[index]}"
    done
fi

echo "Done. Open a new terminal window and restart Visual Studio Code to see the changes."
