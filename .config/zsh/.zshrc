autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
autoload -Uz compinit promptinit && compinit && promptinit

setopt autocd COMPLETE_ALIASES
setopt append_history extended_history hist_expire_dups_first hist_ignore_dups hist_ignore_space share_history

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

wd() { . /home/ashiroli/bin/wd/wd.sh }
function my_precmd() { echo -n -e '\a' }
function my_chpwd() { ls -l --color=auto }

precmd_functions=(${precmd_functions[@]} "my_precmd")
chpwd_functions=(${chpwdcmd_functions[@]} "my_chpwd")

prompt adam3

HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=$ZDOTDIR/.zhistory

export TERM=xterm-256color
export LANG=en_US.UTF-8
export EDITOR='nvim'

source $ZDOTDIR/.zsh_aliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ttyctl -f

