#!/usr/bin/env bash
# ^ The first line is called a "shebang." It tells the computer which program
#   should run this file. "/usr/bin/env bash" means "find bash and use it."
#
# refresh-copilot.sh
# ------------------
# This script makes the copilot folder (Copilot's class instructions and the
# worksheets) match the newest version on GitHub, and leaves every other file
# alone. A full "git pull" would stop if any other file had local changes,
# such as vscode/settings.json after a change in Visual Studio Code's Settings
# screen.
#
# You don't need to run it yourself. configure.sh sets up a "launch agent,"
# which tells macOS to run this script every 15 minutes in the background.
#
# How to run it by hand (from inside the DeveloperTools folder):
#
#     bash scripts/refresh-copilot.sh
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
# get_repository_directory prints the full path of the repository: the
# folder one level above the scripts folder this file is in.
get_repository_directory() {
    (cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
}

# folder_matches checks whether the copilot folder on disk matches a version
# of the repository. Like any command, a function "succeeds" or "fails", so
# an "if" can test it.
#   $1 = a version, such as HEAD (the version this copy is on) or origin/main
#        (the newest version downloaded from GitHub)
# git diff --quiet prints nothing; it succeeds when there are no differences.
folder_matches() {
    git diff --quiet "$1" -- copilot
}


# --- Settings ---------------------------------------------------------------
repository_directory="$(get_repository_directory)"
remote_version="origin/main"

# The launch agent starts this script from the home folder, so move into the
# repository first. Every git command below works on the folder it runs in.
cd "$repository_directory"


# --- Main work --------------------------------------------------------------
# Leave the folder alone if someone is working on it. A copy has local work
# when it has commits that are not on GitHub yet, or when the copilot folder
# matches neither this copy's own version nor the last version downloaded.
# git merge-base --is-ancestor A B succeeds when B already includes A.
# "!" turns success into failure and failure into success.
if ! git merge-base --is-ancestor HEAD "$remote_version"; then
    echo "Skipped: this copy has commits that are not on GitHub yet."
    exit 0
fi
if ! folder_matches HEAD && ! folder_matches "$remote_version"; then
    echo "Skipped: the copilot folder has local changes."
    exit 0
fi

# git fetch downloads the newest version from GitHub without changing any
# files here. -q keeps it quiet.
git fetch -q origin

# Nothing to do if the folder already matches the newest version.
if folder_matches "$remote_version"; then
    exit 0
fi

# git checkout VERSION -- FOLDER copies FOLDER from VERSION onto the disk.
# --no-overlay also deletes files that are gone from that version, such as a
# worksheet that was removed.
git checkout -q --no-overlay "$remote_version" -- copilot
echo "$(date): updated the copilot folder from GitHub."
