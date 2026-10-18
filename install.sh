#!/usr/bin/env bash
# install.sh
# ----------
# This script installs the programs the rest of this repository depends on,
# in the order they depend on each other:
#
#   1. Homebrew, a "package manager" that installs other programs for you.
#      It also installs Apple's Command Line Tools, which include git.
#   2. iTerm2 and Visual Studio Code, installed by Homebrew.
#   3. The zsh plugins zsh-autosuggestions and zsh-syntax-highlighting,
#      installed by Homebrew.
#   4. oh-my-zsh, a framework that organizes zsh themes and plugins.
#   5. Powerlevel10k (the prompt theme) and a second copy of
#      zsh-syntax-highlighting, both downloaded into oh-my-zsh with git.
#   6. The MesloLGS NF font, which has the symbols the prompt draws.
#
# zsh itself needs no installing: it is the default shell on every Mac since
# macOS Catalina.
#
# Every step checks whether its program is already there and skips it if so,
# so running this script twice is safe.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash install.sh
#
# configure.sh explains the basics (comments, variables, functions, "if",
# arrays, and "for" loops). This file explains the new things it uses.


# Stop on any failure, on unset variables, and on failures inside pipelines.
set -euo pipefail


# --- Settings ---------------------------------------------------------------
applications_directory="/Applications"
oh_my_zsh_directory="$HOME/.oh-my-zsh"
# oh-my-zsh looks for extra themes and plugins inside its "custom" folder.
oh_my_zsh_custom_directory="$oh_my_zsh_directory/custom"
fonts_directory="$HOME/Library/Fonts"
# Powerlevel10k's media repository hosts the font files. "%20" is how a web
# address writes a space.
font_base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
font_file_names=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
)


# --- Functions --------------------------------------------------------------

# print_step prints a heading so you can follow the script's progress.
print_step() {
    # "\n" inside echo -e starts a new line, which leaves a blank line above
    # each heading.
    echo -e "\n==> $1"
}

# get_brew_path prints where the brew command is, or nothing if Homebrew is
# not installed. Homebrew lives in /opt/homebrew on Macs with Apple chips and
# in /usr/local on older Macs with Intel chips.
get_brew_path() {
    # "for ... in ..." runs once for each word in the list, putting that word
    # in the variable. Unlike the counting loops in configure.sh, this kind of
    # loop needs no index.
    for brew_candidate in "/opt/homebrew/bin/brew" "/usr/local/bin/brew"; do
        if [ -x "$brew_candidate" ]; then
            echo "$brew_candidate"
            return
        fi
    done
}

# install_application installs one app with Homebrew, unless the app is
# already in the Applications folder (installed by Homebrew or by hand).
#   $1 = Homebrew's name for the app, such as iterm2
#   $2 = the app's file name, such as iTerm.app
install_application() {
    local package_name="$1"
    local application_name="$2"

    # -d  true if the path is a folder. A Mac app is really a folder.
    if [ -d "$applications_directory/$application_name" ]; then
        echo "Already installed: $application_name"
    else
        # "--cask" tells Homebrew this is a full app with a window, not a
        # command-line tool.
        brew install --cask "$package_name"
    fi
}

# install_command_line_package installs one Homebrew package, unless
# Homebrew reports that it is already installed.
#   $1 = Homebrew's name for the package
install_command_line_package() {
    local package_name="$1"

    # "brew list --formula NAME" succeeds only if the package is installed.
    # "&> /dev/null" throws away both its normal output and its error
    # messages, because only success or failure matters here.
    if brew list --formula "$package_name" &> /dev/null; then
        echo "Already installed: $package_name"
    else
        brew install "$package_name"
    fi
}

# clone_repository downloads a git repository into a folder, unless that
# folder already exists.
#   $1 = the repository's web address
#   $2 = the folder to download it into
clone_repository() {
    local repository_url="$1"
    local destination_directory="$2"

    if [ -d "$destination_directory" ]; then
        echo "Already installed: $destination_directory"
    else
        # git clone copies a repository. "--depth=1" downloads only the newest
        # version instead of the whole history, which is faster.
        git clone --depth=1 "$repository_url" "$destination_directory"
    fi
}


# --- 1. Homebrew ------------------------------------------------------------
print_step "Homebrew"

brew_path="$(get_brew_path)"

if [ -n "$brew_path" ]; then
    echo "Already installed: $brew_path"
else
    # Homebrew's installer needs an administrator password. "sudo -v" asks
    # for it now, in this window, and remembers it for a few minutes so the
    # installer can use it.
    echo "Homebrew needs your Mac password (the one you log in with)."
    echo "Nothing appears on screen while you type it; that is normal."
    sudo -v

    # NAME=value before a command sets a variable for that one command only.
    # NONINTERACTIVE=1 tells the installer not to stop and ask
    # "Press RETURN to continue".
    # curl downloads the installer script, and /bin/bash runs it:
    #   -f  fail on a server error instead of saving the error page
    #   -s  silent: no progress bar
    #   -S  still show an error message if something goes wrong
    #   -L  follow the address if the server says the file has moved
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    brew_path="$(get_brew_path)"
fi

# "brew shellenv" prints the commands that put Homebrew on the command path.
# eval runs printed commands as if they were typed here, so this script can
# use "brew" right away.
eval "$("$brew_path" shellenv)"

# The installer does not make that change permanent. zsh reads ~/.zprofile
# every time you log in, so the same line goes there.
# The single quotes keep "$(...)" from running now; it is written into the
# file exactly as shown and runs later, when zsh reads the file.
shellenv_line='eval "$('"$brew_path"' shellenv)"'

# grep searches files for text:
#   -q  quiet: print nothing, just succeed or fail
#   -F  treat the text as plain text, not as a pattern
# "!" flips the result, so this means "if the line is NOT in the file".
# "touch" creates the file if it does not exist yet, so grep has a file to
# search.
touch "$HOME/.zprofile"
if ! grep -qF "$shellenv_line" "$HOME/.zprofile"; then
    # ">>" adds text to the end of a file. (">" would replace the whole file.)
    echo "$shellenv_line" >> "$HOME/.zprofile"
    echo "Added Homebrew to ~/.zprofile"
else
    echo "Homebrew is already in ~/.zprofile"
fi


# --- 2. Apps ----------------------------------------------------------------
print_step "iTerm2 and Visual Studio Code"
install_application "iterm2" "iTerm.app"
# This also puts the "code" command in Homebrew's folder, so "code" works in
# the terminal without any setup inside Visual Studio Code.
install_application "visual-studio-code" "Visual Studio Code.app"


# --- 3. zsh plugins from Homebrew -------------------------------------------
print_step "zsh plugins"
# .zshrc loads zsh-autosuggestions from Homebrew's folder, and reads
# zsh-syntax-highlighting's "highlighters" from Homebrew's folder too.
install_command_line_package "zsh-autosuggestions"
install_command_line_package "zsh-syntax-highlighting"


# --- 4. oh-my-zsh -----------------------------------------------------------
print_step "oh-my-zsh"

if [ -d "$oh_my_zsh_directory" ]; then
    echo "Already installed: $oh_my_zsh_directory"
else
    # KEEP_ZSHRC=yes stops the installer from replacing ~/.zshrc, because
    # configure.sh links ~/.zshrc to this repository's copy instead.
    # "--unattended" means: ask no questions, and do not switch into zsh
    # when finished (which would pause this script).
    # The empty "" fills the spot where sh -c expects a script name, so
    # "--unattended" reaches the installer as its first option.
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi


# --- 5. Powerlevel10k and zsh-syntax-highlighting in oh-my-zsh --------------
print_step "Powerlevel10k and oh-my-zsh plugins"
# .zshrc sets ZSH_THEME="powerlevel10k/powerlevel10k", so oh-my-zsh looks for
# the theme in custom/themes/powerlevel10k.
clone_repository "https://github.com/romkatv/powerlevel10k.git" \
    "$oh_my_zsh_custom_directory/themes/powerlevel10k"
# A "\" at the very end of a line continues the command on the next line.

# .zshrc loads zsh-syntax-highlighting itself from oh-my-zsh's custom plugins
# folder, so it needs this copy as well as Homebrew's.
clone_repository "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
    "$oh_my_zsh_custom_directory/plugins/zsh-syntax-highlighting"


# --- 6. MesloLGS NF font ----------------------------------------------------
print_step "MesloLGS NF font"
mkdir -p "$fonts_directory"

font_count="${#font_file_names[@]}"
for (( index = 0; index < font_count; index++ )); do
    font_file_name="${font_file_names[index]}"
    font_path="$fonts_directory/$font_file_name"

    # -f  true if the path is a regular file
    if [ -f "$font_path" ]; then
        echo "Already installed: $font_file_name"
    else
        # ${variable// /%20} replaces every space in the variable with %20,
        # turning the file name into the form a web address needs.
        font_url="$font_base_url/${font_file_name// /%20}"
        # -o saves the download to the given path instead of printing it.
        curl -fsSL -o "$font_path" "$font_url"
        echo "Installed: $font_file_name"
    fi
done


print_step "Installs finished"
