export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_COLOR=blue
SPACESHIP_JOBS_SHOW=true
SPACESHIP_JOBS_COLOR=red

plugins=(git sudo wd colored-man-pages)

source $ZSH/oh-my-zsh.sh
export TERM=xterm-256color
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

(wal -r -t &)

alias vi="nvim"
alias ezl="source $HOME/.zshrc"
alias ez="vi $HOME/.zshrc"
alias myi3="vi $HOME/.config/i3/config"
alias top="htop"
alias mus=cmus
alias rmr="rm -rf"
alias make="make -j"
alias tig="tig --all"
alias x="dtrx"
alias t1="tree -L 1"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias t4="tree -L 4"
alias open="nemo"

source ~/.zsh_custom

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

