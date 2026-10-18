#!/usr/bin/env bash
# setup.sh
# --------
# This is the one script to run on a new Mac. It does two things in order:
#
#   1. install.sh installs the programs: Homebrew, iTerm2, Visual Studio
#      Code, oh-my-zsh, Powerlevel10k, the zsh plugins, and the font.
#   2. configure.sh links the configuration files to this repository and
#      installs the Visual Studio Code extensions.
#
# configure.sh runs only if install.sh finishes without an error, because the
# configuration needs the programs to be there.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash setup.sh
#
# configure.sh and install.sh explain the bash in more detail.


# Stop on any failure, on unset variables, and on failures inside pipelines.
set -euo pipefail

# The folder this script is in, so the other two scripts can be found no
# matter which folder you run this from. (configure.sh explains each part.)
repository_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Every command reports an "exit status" when it finishes: 0 means success,
# and any other number means failure. "if COMMAND; then" checks that status
# directly: it takes the "then" branch on 0 and the "else" branch otherwise.
if bash "$repository_directory/install.sh"; then
    bash "$repository_directory/configure.sh"
else
    # ">&2" sends the message to "standard error," the channel for error
    # messages, instead of normal output.
    echo "install.sh did not finish, so configure.sh was not run." >&2
    echo "Read the messages above, fix the problem, and run setup.sh again." >&2
    # "exit 1" ends this script with a failure status, so anything that ran
    # setup.sh can tell it failed too.
    exit 1
fi
