autoload -Uz compinit
compinit

HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
unsetopt nomatch

bindkey '\eb' backward-word
bindkey '\ef' forward-word

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
