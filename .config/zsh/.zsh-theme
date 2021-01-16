# ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[blue][ %{$fg[red]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[blue]< %{$fg[red]%}\ue725 "
ZSH_THEME_GIT_PROMPT_SUFFIX="$fg_bold[blue] >%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}!"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}? $fg_bold[blue]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg_bold[blue]"

# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

__current_directory='${reset_color%}%{$fg_bold[green]%}%{$fg[cyan]%}%c'
__git_section='$(git_prompt_info)$(git_prompt_status)'
__status_char=''
__exec_time=''
__prompt_char='$FG[105]%(!.#.❯ )%{$reset_color%}'

PROMPT_LINE1="$__current_directory$__git_section"

PROMPT_LINE2="$__prompt_char"

PROMPT="$PROMPT_LINE1
$PROMPT_LINE2"

RPROMPT_BASE='%{$fg_bold[green]%}%{$fg[cyan]%}%~'
RPROMPT="$RPROMPT_BASE"

# Show execution time
typeset -F SECONDS
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
    ELAPSED="${ELAPSED}${SECS}"

    export __exec_time="$fg_bold[white]$FG[105]${ELAPSED}%{$reset_color%}%f"

    unset ZSH_START_TIME
  fi
}
add-zsh-hook precmd -report-start-time

# now you can add it to your prompt like this:
# function which configures the prompet...
function BashPrompt() {
    local last_status=$?
    # local reset=$(ResetColor)

    # local failure="✘"
    # local success="✔"
    # local success=""

    if [[ "$last_status" != "0" ]]; then
        # export RPROMPT="$fg_bold[red]$failure%{$reset_color%}"
        # export __status_char="$fg_bold[red]$failure%{$reset_color%}"
        export __prompt_char='%{$reset_color%}$FG[001]%(!.#.❯ )%{$reset_color%}'
    else
        # export RPROMPT="$fg_bold[green]$success%{$reset_color%}"
        # export __status_char="$fg_bold[green]$success%{$reset_color%}"
        # export __status_char=""
        export __prompt_char='$FG[105]%(!.#.❯ )%{$reset_color%}'
    fi
}
add-zsh-hook precmd BashPrompt

function -reset-prompt() {
    [[ "$__current_directory" != "" ]] && local __current_directory="$__current_directory "
    # It has to check for git_prompt_info instead of $__git_section because
    # sometimes __git_section has '$(git_prompt_info)$(git_prompt_status)' as content
    # but it doesn't display anything if the current directory is not a git repository
    [[ "$(git_prompt_info)"   != "" ]] && local __git_section="$__git_section "
    [[ "$__exec_time"         != "" ]] && local __exec_time="$__exec_time "
    [[ "$__status_char"       != "" ]] && local __status_char="$__status_char "

    export PROMPT_LINE1="$__current_directory$__git_section$__exec_time$__status_char"
    export PROMPT_LINE2="$__prompt_char"

    export PROMPT="$PROMPT_LINE1
$PROMPT_LINE2"
}
add-zsh-hook precmd -reset-prompt
