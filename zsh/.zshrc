autoload -Uz compinit && compinit

alias prod_pr='git checkout qa && git pull && git checkout master && git pull && git log --oneline master..qa | grep -o "Merge pull request #[0-9]*" | awk "{print \$4}" | tail -r | awk "{print \"- \" \$0}"'

export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "MichaelAquilina/zsh-autoswitch-virtualenv"

zplug load

eval "$(starship init zsh)"
