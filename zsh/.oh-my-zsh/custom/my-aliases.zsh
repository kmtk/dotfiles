# cygdirectory shortcut
alias cdc='cd /cygdrive/c/'
alias cdd='cd /cygdrive/d/'

alias less='less -r'
alias rm='rm -i'

# abbreviations
setopt extended_glob
typeset -A abbreviations
abbreviations=(
    "G"    "| grep"
    "X"    "| xargs"
    "T"    "| tail"
    "C"    "| cat"
    "W"    "| wc"
    "A"    "| awk"
    "S"    "| sed "
    "L"    "| $PAGER"
    "FX"   "find _|_ -print0 | xargs -0 "
    "E"    "2>&1 > /dev/null"
    "N"    "> /dev/null"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
    LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
