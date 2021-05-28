#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias restic='sudo -E restic'
alias todo=todo.sh
alias tdtm=todotxt-machine
alias icat="kitty +kitten icat"

source .b2_variables
source .restic_variables

PS1='\e[0;34m\u\e[m\e[0;32m@\e[m\e[0;31m\h\e[m \e[1;35m\W\e[m \e[1;36m\e[m '

if [ "$TERM" != "linux" ]; then
    source ~/.pureline/pureline ~/.pureline.conf
fi

TERM='xterm-256color'
HISTSIZE=2500
HISTFILESIZE=2500
