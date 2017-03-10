export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="koa"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git sudo wd colored-man-pages)

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vi="nvim"
alias loadzsh="source $HOME/.zshrc"
alias myzsh="vi $HOME/.zshrc"
alias myi3="vi $HOME/.config/i3/config"
alias top="htop"
alias rmr="rm -rf"
alias make="make -j"
alias tig="tig --all"
alias x="dtrx"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
