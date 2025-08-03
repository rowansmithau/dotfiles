autoload -Uz compinit
compinit

HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
unsetopt nomatch

bindkey '\eb' backward-word
bindkey '\ef' forward-word
