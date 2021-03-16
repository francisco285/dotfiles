# Remove trail whitespace on RPROMPT
# https://superuser.com/a/726509
ZLE_RPROMPT_INDENT=0

autoload -U add-zsh-hook

# Show execution time
typeset -F SECONDS

# reference: https://github.com/wincent/wincent

if [ '$TERM' = 'linux' ]; then
  ZSH_THEME_GIT_ICON='Y'
  ZSH_THEME_PROMPT_CHAR='%(?.%F{255}> %f.%F{red}> %f)'
else
  ZSH_THEME_GIT_ICON="\uE0A0"
  ZSH_THEME_PROMPT_CHAR='%(?.%F{255}❯ %f.%F{red}❯ %f)'
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%F{027}< %f%F{255}${ZSH_THEME_GIT_ICON} "
ZSH_THEME_GIT_PROMPT_SUFFIX='%F{027} >%f'

ZSH_THEME_CWD_TAIL='%F{cyan}%c%f'

ZSH_THEME_EXECUTION_TIME=''

ZSH_THEME_CWD='%F{cyan}%~%f'
RPROMPT="${ZSH_THEME_CWD}"

# Show execution time
function -record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -report-start-time() {
  emulate -L zsh
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
    if [ "$ELAPSED" = '' ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0' ]; then
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi

    if [[ ${DELTA} -lt 3 ]]
    then
      export ZSH_THEME_EXECUTION_TIME=''
    else
      ELAPSED="${ELAPSED}${SECS}"
      export ZSH_THEME_EXECUTION_TIME="%F{255}${ELAPSED}%f"
    fi

    unset ZSH_START_TIME
  fi
}
add-zsh-hook precmd -report-start-time

function -reset-prompt() {
    if [[ "$ZSH_THEME_CWD_TAIL" != '' ]]; then
      local ZSH_THEME_CWD_TAIL="$ZSH_THEME_CWD_TAIL "
    fi

    if [[ "$(git status --porcelain 2> /dev/null)" != "" ]]; then
      local dirty="%F{yellow}!%f"
    else
      local dirty=""
    fi

    # https://gist.github.com/msabramo/2355834
    local ref=$(git symbolic-ref --short HEAD 2> /dev/null)

    if [[ "$ref" != "" ]]; then
      local ZSH_THEME_GIT_INFO="$(echo ${ZSH_THEME_GIT_PROMPT_PREFIX})${ref#refs/heads/}${dirty}${ZSH_THEME_GIT_PROMPT_SUFFIX} "
    fi

    if [[ "$ZSH_THEME_EXECUTION_TIME" != "" ]]; then
      local ZSH_THEME_EXECUTION_TIME="$ZSH_THEME_EXECUTION_TIME "
    fi

    local PROMPT_LINE1="${ZSH_THEME_CWD_TAIL}${ZSH_THEME_GIT_INFO}${ZSH_THEME_EXECUTION_TIME}"
    local PROMPT_LINE2="${ZSH_THEME_PROMPT_CHAR}"

    export PROMPT="${PROMPT_LINE1}
${PROMPT_LINE2}"
}
add-zsh-hook precmd -reset-prompt
