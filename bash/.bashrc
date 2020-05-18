#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias restic='sudo -E restic'
alias todo=todo.sh
alias tdtm=todotxt-machine

source .b2_variables
source .restic_variables

PS1='\e[0;34m\u\e[m\e[0;32m@\e[m\e[0;31m\h\e[m \e[1;35m\W\e[m \e[1;36m\e[m '
TERM='xterm-256color'
