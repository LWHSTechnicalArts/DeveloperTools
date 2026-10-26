# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
   git
   virtualenv
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# customizations
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
# local user_symbol="$"
# if [[ $(print -P "%#") =~ "#" ]]; then
#     user_symbol = "#"
# fi
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=’red’
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"



# alias python3="/Library/Frameworks/Python.framework/Versions/3.14/bin/python3.14"
# alias pip3="/Library/Frameworks/Python.framework/Versions/3.14/bin/pip3.14"
# alias python='python3'
# alias pip='pip3'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# default terminal background colors
printf '\e]11;#fbfbfb\e\\'
printf '\e]10;#333333\e\\'
printf '\e]12;#ed225d\e\\'

# autocomplete color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a6a6a6"

# folder name colors
printf '\e]4;4;#0b7ca9\e\\'
printf '\e]4;12;#0b7ca9\e\\'
export CLICOLOR=1
export LSCOLORS='exfxcxdxbxegedabagexex'

autoload -Uz compinit ; compinit
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Homebrew lives in /opt/homebrew on Macs with Apple chips and in /usr/local
# on older Macs with Intel chips. ~/.zprofile sets it up for login shells;
# shells that skip ~/.zprofile (such as one started with "exec zsh") set it
# up here, using whichever location actually exists on this Mac.
if [[ -z "$HOMEBREW_PREFIX" ]]; then
  for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brew_path" ]]; then
      eval "$("$brew_path" shellenv)"
      break
    fi
  done
  unset brew_path
fi

# zsh plugins installed by Homebrew.
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Terminal color profile setup
if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
  typeset -A paletteColors
  paletteColors=(
    bg fbfbfb
    fg 333333
    bold 1c1c1c
    link 0b7ca9
    curbg ed225d
    curfg fbfbfb
    selbg d9d9d9
    selfg 1c1c1c
    black 1c1c1c
    red ed225d
    green 47820a
    yellow a06801
    blue 0b7ca9
    magenta d52889
    cyan 0071ad
    white a6a6a6
    br_black 747474
    br_red f10046
    br_green 47820a
    br_yellow a06801
    br_blue 0b7ca9
    br_magenta d52889
    br_cyan 0071ad
    br_white 1c1c1c
  )
  for colorName colorValue in "${(@kv)paletteColors}"; do
    printf '\e]1337;SetColors=%s=%s\a' "$colorName" "$colorValue"
  done
  unset paletteColors colorName colorValue
fi

# Visual Studio Code's "code" command (as in "code ."). Installing Visual
# Studio Code with Homebrew puts "code" on the command path, but a copy
# installed by hand does not, so add the folder inside the app, as Visual
# Studio Code's macOS setup guide describes.
visual_studio_code_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
if ! command -v code > /dev/null && [[ -d "$visual_studio_code_bin" ]]; then
  export PATH="$PATH:$visual_studio_code_bin"
fi
unset visual_studio_code_bin

# Copilot in Visual Studio Code records each chat to this file (see the
# github.copilot.chat.otel settings in vscode/settings.json). The settings
# file cannot hold this path, because Copilot does not expand "~" there.
# Visual Studio Code reads variables like this one from the shell each time
# it starts, so a change here takes effect after quitting and reopening it.
export COPILOT_OTEL_FILE_EXPORTER_PATH="$HOME/Library/Logs/DeveloperTools-copilot/copilot-chats.jsonl"

# Safer, clearer file commands for beginners.
# rm asks before deleting each file, because files removed with rm skip the
# Trash. macOS's rm prints its own question ("remove FILE?") and cannot change
# its wording, so this function prints a reminder of the answers first, then
# runs the real rm ("command rm") with -i to ask about each file.
# -f ("force", as in rm -rf) would skip every question, so this function
# removes it. A folder deleted with -r or -R gets one question for the whole
# folder instead of one for every file inside it.
rm() {
  local -a options targets
  local argument answer
  local is_reading_options=1 has_shown_reminder=0 exit_status=0
  # rm reads options until "--" or the first file name.
  for argument in "$@"; do
    if (( is_reading_options )) && [[ $argument == -- ]]; then
      is_reading_options=0
    elif (( is_reading_options )) && [[ $argument == -?* ]]; then
      argument=${argument//f/}
      [[ $argument == - ]] || options+=($argument)
    else
      is_reading_options=0
      targets+=($argument)
    fi
  done
  # With no file names, let the real rm print how to use it.
  (( $#targets )) || { command rm -i $options; return }
  for argument in $targets; do
    if [[ -d $argument && ! -L $argument && ${(j::)options} == *[rR]* ]]; then
      print -n -u2 "Do you want to delete the folder \"$argument\" and all of its contents? (y/n) "
      read -r answer
      if [[ $answer == [yY]* ]]; then
        command rm $options -- $argument || exit_status=1
      fi
    else
      (( has_shown_reminder )) || print -u2 "(Type y and press Return to delete, or n and Return to keep.)"
      has_shown_reminder=1
      command rm -i $options -- $argument || exit_status=1
    fi
  done
  return $exit_status
}
# ls -F adds a "/" after folder names (and "*" after programs), so folders
# stand out even without color. -G keeps oh-my-zsh's colors.
alias ls='ls -FG'

# Friendlier message for a command that does not exist. zsh runs this function
# instead of printing its usual "command not found" error. Returning 127 keeps
# the failure status, so the prompt still shows its pink ✘ mark.
command_not_found_handler() {
  print -u2 -r -- "\"$1\" is not a command. Check the spelling, or press the Up arrow to fix it."
  return 127
}

# Machine-specific settings live outside this repository, in ~/.zshrc.local.
# The file is optional; on machines without it, this line does nothing.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
