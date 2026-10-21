#!/usr/bin/env bash
# setup.sh
# --------
# This is the one script to run on a new Mac. It does three things in order:
#
#   1. install.sh installs the programs: Homebrew, Visual Studio
#      Code, oh-my-zsh, Powerlevel10k, the zsh plugins, and the font.
#   2. configure-copilot.sh links Copilot's class instructions to this
#      repository and sets up their automatic updates.
#   3. configure.sh links the configuration files to this repository and
#      installs the Visual Studio Code extensions.
#
# The two configure scripts run only if install.sh finishes without an error,
# because the configuration needs the programs to be there.
# configure-copilot.sh runs before configure.sh, so a problem with the
# extensions can never stop Copilot's instructions from being set up.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash scripts/setup.sh
#
# configure.sh and install.sh explain the bash in more detail.


# Stop on any failure, on unset variables, and on failures inside pipelines.
set -euo pipefail

# The scripts folder this file is in, so the other scripts can be found
# no matter which folder you run this from. (configure.sh explains each part.)
scripts_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Every command reports an "exit status" when it finishes: 0 means success,
# and any other number means failure. "if COMMAND; then" checks that status
# directly: it takes the "then" branch on 0 and the "else" branch otherwise.
if bash "$scripts_directory/install.sh"; then
    bash "$scripts_directory/configure-copilot.sh"
    bash "$scripts_directory/configure.sh"
else
    # ">&2" sends the message to "standard error," the channel for error
    # messages, instead of normal output.
    echo "install.sh did not finish, so the configure scripts were not run." >&2
    echo "Read the messages above, fix the problem, and run setup.sh again." >&2
    # "exit 1" ends this script with a failure status, so anything that ran
    # setup.sh can tell it failed too.
    exit 1
fi
