
#zmodload zsh/zprof

export ZSH_DISABLE_COMPFIX=true
export CODER_NO_VERSION_WARNING=1
export VAULT_ADDR=https://vault.orilla.cc
export AWS_PROFILE=coder-aws-sandbox
export AWS_PAGER=""

alias pms="~/proxmox-longhorn-power-v2.5.sh shutdown root@beetle.rsmith.id.au --yes --timeout 1200 --volume-timeout 1900 --set-replenishment-wait 1800 --context l1 --context k1"
alias pmr="~/proxmox-longhorn-power-v2.5.sh resume --context l1 --context k1"
alias wol="wakeonlan d8:5e:d3:5b:b8:1e"
alias k="kubectl"
alias psqlc="psql service=coder"
alias psqld="psql service=dev"
alias psqle="psql service=enc"
alias psqlesr="psql service=esr"
alias psqlrc="psql service=rc"
alias psqla="psql service=admin"

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
alias jwt="pbpaste | jwt decode -"
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# --- Completion ---
zstyle ':completion:*' rehash true
fpath=(/Users/rowan/.docker/completions $fpath)
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

# source <(kubectl completion zsh)
# source <(helm completion zsh)

# kubectl (lazy)
_kubectl_lazy() {
  unfunction _kubectl_lazy 2>/dev/null
  source <(kubectl completion zsh)
  _kubectl "$@"
}
compdef _kubectl_lazy kubectl

# helm (lazy)
_helm_lazy() {
  unfunction _helm_lazy 2>/dev/null
  source <(helm completion zsh)
  _helm "$@"
}
compdef _helm_lazy helm

# --- History ---
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt inc_append_history
unsetopt nomatch

# --- Word navigation (works everywhere with Alt+b/f) ---
bindkey '\eb' backward-word
bindkey '\ef' forward-word

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
unalias grep
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}"
PROMPT_EOL_MARK=''

# --- Paths ---
export PATH="/opt/homebrew/opt/curl/bin:/Users/rowan/go:/Users/rowan/go/bin:/Users/rowan/bin:/opt/homebrew/opt/libpq/bin:$(brew --prefix bash)/bin:$(brew --prefix gnu-getopt)/bin:$(brew --prefix make)/libexec/gnubin:/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

tix() {
    if [[ ! "$1" =~ ^[0-9]{4}$ ]]; then
        echo "Usage: tix <5-digit_ticket_number>"
        return 1
    fi

    dir_path=~/Downloads/tickets/"$1"

    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
    fi

    cd "$dir_path" || return 1
}

# shikari quick commands
sc() {
  (
    cd "$HOME/Downloads/shikari/scenarios/empty" && 
    shikari create -n coder -s 1
  )
}

sd() {
  (
    cd "$HOME/Downloads/shikari/scenarios/empty" && 
    shikari destroy -n coder -f
  )
}

ss() {
  shikari shell coder-srv-01
}

if [[ "$OSTYPE" == darwin* && -f ~/.coder-contexts.zsh ]]; then
  source ~/.coder-contexts.zsh
fi

#zprof

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
alias g="$GOPATH/bin/g"

#source /Users/rowan/.config/broot/launcher/bash/br


export PATH="$HOME/.local/bin:$PATH"
