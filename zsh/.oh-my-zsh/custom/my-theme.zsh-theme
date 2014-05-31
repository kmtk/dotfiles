# my-theme

# monokai like color pallet
local ml_red="%{$FG[197]%}"
local ml_orange="%{$FG[208]%}"
local ml_green="%{$FG[155]%}"
local ml_yellow="%{$FG[228]%}"
local ml_cyan="%{$FG[80]%}"
local ml_violet="%{$FG[135]%}"
local ml_gray="%{$FG[243]%}"
local ml_reset="%{$FG[255]%}"

# Prompt
local USER_NAME="${ml_orange}%n${ml_reset}"
local HOST_NAME="${ml_yellow}%m${ml_reset}"
local CURRENT_DIRECTORY="${ml_green}%~${ml_reset}"
local RETURN_STATUS="%(?,,${ml_red}[%?]${ml_reset} )"
local PROMPT_CHARACTER="%B%(?,${ml_reset},${ml_red})%(!,#,$)%b"
local GIT_PROMPT_INFO='$(git_prompt_info)'

PROMPT="${USER_NAME}@${HOST_NAME}: ${CURRENT_DIRECTORY} ${GIT_PROMPT_INFO}
${RETURN_STATUS}${PROMPT_CHARACTER} "
# SPROMPT="%B%{${fg[magenta]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "

# Git status
ZSH_THEME_GIT_PROMPT_PREFIX=" ${ml_reset}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${ml_reset})"
ZSH_THEME_GIT_PROMPT_DIRTY="${ml_red} !"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="${ml_blue} +"
ZSH_THEME_GIT_PROMPT_MODIFIED="${ml_orange} *"
# ZSH_THEME_GIT_PROMPT_DELETED="${ml_red} ?"
# ZSH_THEME_GIT_PROMPT_RENAMED="${ml_red} ?"
# ZSH_THEME_GIT_PROMPT_UNMERGED="${ml_red} ?"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${ml_violet} ?"

# LS colors
eval `dircolors ${ZSH_CUSTOM}/dircolors.monokai`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
