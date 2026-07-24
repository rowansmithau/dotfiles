export ZSH_DISABLE_COMPFIX=true

alias k="kubectl"
alias tf=terraform
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfaa="terraform apply --auto-approve"
alias tfd="terraform destroy"
alias tfdd="terraform destroy --auto-approve"
alias tfv="terraform validate"
alias tfr="terraform refresh"
alias tff="terraform fmt -recursive"
alias history="history 1"

autoload -Uz compinit
compinit -C -d ~/.zcompdump    # skip security check
if [[ ~/.zcompdump -nt ~/.zcompdump.zwc ]]; then
  zrecompile -q ~/.zcompdump
fi

# Accept the next word from zsh-autosuggestion with ctrl+f
bindkey '^F' forward-word

# ============ BEGIN coder COMPLETION ============
_coder_completions() {
	local -a args completions
	args=("${words[@]:1:$#words}")
	completions=(${(f)"$(COMPLETION_MODE=1 "coder" "${args[@]}")"})
	compadd -a completions
}
compdef _coder_completions coder
# ============ END coder COMPLETION ==============



HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
unsetopt nomatch

bindkey '\eb' backward-word
bindkey '\ef' forward-word

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --- Oh-My-Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
#COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
plugins=(git gh zsh-autosuggestions zsh-syntax-highlighting)

zstyle ':omz:update' mode disabled
source $ZSH/oh-my-zsh.sh
