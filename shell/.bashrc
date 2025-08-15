# Change prompt
RED="\[\033[1;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[1;32m\]"
BLUE="\[\033[1;34m\]"
MAGENTA="\[\033[1;35m\]"
RESET="\[\033[0m\]"
PS1="${RED}[${YELLOW}\u${GREEN}@${BLUE}\h ${MAGENTA}\w${RED}]${RESET}\$ "

shopt -s histappend              # append new history items to .bash_history

export HSTR_CONFIG=hicolor
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)

# Use neovim for vim if present.
[ -x "$(command -v nvim)" ] && alias vim="nvim" vimdiff="nvim -d"

# Aliases
alias hh=hstr 

if [[ "$(uname)" == "Darwin" ]] && command -v gls >/dev/null 2>&1; then
	# gls requires coreutils
	alias ls='gls --group-directories-first --color=auto'
else
	alias ls='ls --group-directories-first --color=auto'
fi

# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
    READLINE_POINT=${#READLINE_LINE}
}
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n
