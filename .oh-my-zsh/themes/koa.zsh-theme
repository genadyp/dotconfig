# VCS
KOA_VCS_PROMPT_PREFIX1=" %{$reset_color%}("
KOA_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
KOA_VCS_PROMPT_SUFFIX="%{$reset_color%})"
KOA_VCS_PROMPT_DIRTY=" %{$fg[red]%}✗"
KOA_VCS_PROMPT_CLEAN=" %{$fg[green]%}✓"

function get_distro() {
  distro=$(grep "PRETTY_NAME" /etc/os-release | awk -F'=' '{print $2}' | tr -d '"')
  echo "${distro}"
}

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${KOA_VCS_PROMPT_PREFIX1}git${KOA_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$KOA_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$KOA_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$KOA_VCS_PROMPT_CLEAN"

local prompt_jobs="%(1j.%{$fg[yellow]%}%j%{$reset_color%}%{$fg[red]%}ᶻ%{$reset_color%} .)"

PROMPT="${prompt_jobs}%{$fg[cyan]%}%3c%{$reset_color%}${git_info} %# "

RPROMPT="%{$fg[yellow]%}%T %{$fg[blue]%}$(get_distro)%{$reset_color%}"

