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

PS1='[\u@\h \W]\$ '
TERM='xterm-256color'
