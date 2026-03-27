# vim:ft=bash
# If not running interactievly, don't do anything
[[ $- != *i* ]] && return

# Global variables
# Bash prompt
PROMPT_COMMAND='
GIT=$(
BRANCH=$(git branch --show-current 2>/dev/null)
if [[ -n "$BRANCH" ]]; then
  echo ":$BRANCH"
fi)'
PS1='\[\033[1;32m\]\u@\H\[\e[2;37m\]:\[\e[0;34m\]\W\[\e[2;37m\]${GIT}\$\[\e[0m\] '
PS2='\[\033\e[1;31m\]>\[\e[0m\] '
PS4='\[\033\e[1;31m\][DEBUG]\[\e[0m\] '
# Disable duplicated items in command history
HISTCONTROL="ignoreboth"
# Set history size
HISTSIZE=1000
HISTFILESIZE=2000

# Options
# Enable vi mode
set -o vi
# Enable autocd
shopt -s autocd
# Correct minor errors in the spelling of a directory
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable bash command completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Functions
# Use lf to switch directories
lfcd() {
  TMP="$(mktemp -uq)"
  trap 'rm -f $TMP >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
  lf -last-dir-path="$TMP" "$@"
  if [[ -f "$TMP" ]]; then
    DIR="$(cat "$TMP")"
    [[ -d "$DIR" ]] && [[ "$DIR" != "$(pwd)" ]] && cd "$DIR" || true
  fi
}
# Run help for the written command
run-help() {
  if help "$READLINE_LINE" &>/dev/null; then
    help "$READLINE_LINE" 2>/dev/null | less --RAW-CONTROL-CHARS
  else
    man "$READLINE_LINE"
  fi
}

# Binds
# Execute lfcd function
bind '"\C-o": "\C-ulfcd\n"'
# Execute run-help function
bind -m vi-insert -x '"\eh": "run-help"'
# Go to end of the line
bind -m vi-insert '"\C-e": end-of-line'
# Go to beginnging of the line
bind -m vi-insert '"\C-a": beginning-of-line'
# Append sudo to a command
bind -m vi-insert '"\er": "\C-asudo \C-e"'
# Append 'bash -c ""' to a command
bind -m vi-insert '"\ec": "\C-abash -c \"\C-e\"\e[#1D"'
# Bind clear screen for all modes
bind '"\C-l": clear-screen'

# Aliases
alias sudo="sudo "
alias cleanlogs="sudo rm -rfv /var/log/journal/*"
alias ..="cd .."
alias sui="sudo -i"
alias sus="sudo -s"
alias cpr="rsync --archive --human-readable --progress"
alias bat="bat --pager never"
alias ls="ls -hN --color=auto --group-directories-first"
alias less="less --RAW-CONTROL-CHARS"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff --color=auto"
alias spectrum='
for C in {0..255}; do
  tput setab $C
  echo -n "$C "
done
tput sgr0
echo
'
