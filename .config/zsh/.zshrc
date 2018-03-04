autoload -Uz compinit promptinit && compinit && promptinit
autoload -U colors && colors

HISTFILE=~/.config/histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE

setopt autocd extendedglob notify correct_all
setopt hist_expire_dups_first share_history hist_ignore_all_dups append_history
setopt COMPLETE_ALIASES
unsetopt beep

bindkey -e

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

function my_precmd() { echo -n -e '\a' }
function my_chpwd() { ls -lh --color=auto }

precmd_functions=(${precmd_functions[@]} "my_precmd")
chpwd_functions=(${chpwd_functions[@]} "my_chpwd")

prompt adam2

export TERM=xterm-256color
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vi='nvim'
alias cd='cd'
alias ez="nvim $HOME/.zshrc"
alias ezl="source $HOME/.zshrc"
alias top="htop"
alias rmr="rm -rf"
alias tig="tig --all"
alias x="dtrx"
alias t1="tree -L 1"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias t4="tree -L 4"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

source ~/.zsh_custom

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ttyctl -f

