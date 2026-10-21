#!/usr/bin/env bash
# ^ The first line is called a "shebang." It tells the computer which program
#   should run this file. "/usr/bin/env bash" means "find bash and use it."
#
# configure-copilot.sh
# --------------------
# This script sets up Copilot's class instructions, apart from the rest of the
# configuration, so it never waits on the Visual Studio Code extensions. It
# does two things:
#
#   1. It links ~/.copilot/copilot-instructions.md to the copy in this
#      repository, so Copilot reads the class instructions in every project.
#   2. It sets up a "launch agent," a small settings file that tells macOS to
#      run scripts/refresh-copilot.sh every 15 minutes. That script keeps the
#      copilot folder up to date with GitHub.
#
# setup.sh runs this script. You can also run it by itself, and it is safe to
# run again.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash scripts/configure-copilot.sh
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

# write_agent_file writes the launch agent's settings to a file.
#   $1 = the file to write
# In this here document END is not in quotes, so bash fills in the $variables.
write_agent_file() {
    cat > "$1" <<END
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$agent_label</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$repository_directory/scripts/refresh-copilot.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <array>
        <dict><key>Minute</key><integer>0</integer></dict>
        <dict><key>Minute</key><integer>15</integer></dict>
        <dict><key>Minute</key><integer>30</integer></dict>
        <dict><key>Minute</key><integer>45</integer></dict>
    </array>
    <key>StandardOutPath</key>
    <string>$HOME/Library/Logs/DeveloperTools-refresh-copilot.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/Library/Logs/DeveloperTools-refresh-copilot.log</string>
</dict>
</plist>
END
}


# --- Settings ---------------------------------------------------------------
repository_directory="$(get_repository_directory)"

# ~/.copilot also holds Copilot's own data, so only the one instructions file
# is linked, never the whole folder.
instructions_source="$repository_directory/copilot/copilot-instructions.md"
instructions_target="$HOME/.copilot/copilot-instructions.md"

agent_label="org.lwhs.developertools.refresh-copilot"
agent_path="$HOME/Library/LaunchAgents/$agent_label.plist"
# id -u prints your user number. "gui/NUMBER" names your login session, which
# is where launch agents run.
agent_domain="gui/$(id -u)"


# --- Link the class instructions --------------------------------------------
# A symlink is a signpost file: when Copilot opens it, the computer follows
# the signpost to the real file in this repository.
#   -L  true if the path is a symlink
#   -e  true if something exists at the path
# readlink prints where a symlink points.
if [ -L "$instructions_target" ] && [ "$(readlink "$instructions_target")" = "$instructions_source" ]; then
    echo "Already linked: $instructions_target"
else
    # If anything else is in the way, move it into a dated backup folder
    # first, so nothing gets lost.
    if [ -e "$instructions_target" ] || [ -L "$instructions_target" ]; then
        backup_directory="$HOME/DeveloperTools-backups/$(date +%Y-%m-%d_%H-%M-%S)"
        mkdir -p "$backup_directory"
        mv "$instructions_target" "$backup_directory/"
        echo "Backed up:      $instructions_target -> $backup_directory/"
    fi
    # mkdir -p creates ~/.copilot if Copilot has not made it yet.
    mkdir -p "$(dirname "$instructions_target")"
    # ln -s SOURCE TARGET creates the symlink at TARGET pointing to SOURCE.
    ln -s "$instructions_source" "$instructions_target"
    echo "Linked:         $instructions_target -> $instructions_source"
fi


# --- Set up the launch agent ------------------------------------------------
# If the Mac is asleep at one of the agent's times, macOS runs it when the
# Mac wakes up (see "man launchd.plist").
#
# Write the settings to a scratch file first, so the script can tell whether
# anything changed.
new_agent_path="$(mktemp)"
write_agent_file "$new_agent_path"

# cmp -s succeeds when two files are exactly the same. launchctl print
# succeeds when macOS has the agent loaded. If both are true, skip.
if cmp -s "$new_agent_path" "$agent_path" && launchctl print "$agent_domain/$agent_label" > /dev/null 2>&1; then
    echo "Already set up: $agent_path"
    rm "$new_agent_path"
else
    mkdir -p "$(dirname "$agent_path")"
    mv "$new_agent_path" "$agent_path"
    # bootout unloads an older copy of the agent; it fails when none is
    # loaded, so "|| true" lets the script continue. bootstrap loads the new one.
    launchctl bootout "$agent_domain/$agent_label" 2> /dev/null || true
    launchctl bootstrap "$agent_domain" "$agent_path"
    echo "Set up:         $agent_path"
fi
