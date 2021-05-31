# VI mode
bindkey -v
DEFAULT_VI_MODE=viins

# Disable timeout for keypresses
KEYTIMEOUT=1

# Control + p and control + n goes back and forth in command history
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

bindkey '^K' history-beginning-search-backward-end
bindkey '^J' history-beginning-search-forward-end

# Basic tab complettion
zstyle ':completion:*' menu select
zmodload zsh/complist

# Make Shift + Tab go back in completion
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Use Ctrl + vim_keys in tab complete menu
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but allow patterns (eg. a*b) to be used.
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# ctrl+u deletes line content from cursor position until beggining of the line
bindkey '^U' backward-kill-line

# Use ctrl+backspace to kill word as ctrl+w is used in vi
bindkey '^H' vi-backward-kill-word
# If we don't want it to be like vi:
# bindkey '^H' backward-kill-word

# Open programs running in background (only seems to work when running in tmux
# though)
# control + z
# bindkey -s '^Z' '^[[4~^Ufg^M'
bindkey -s '^Z' '^Ufg^M'
# Alt + m
bindkey -s '^[m' '^Ufg^M'

# Open the in-progress command inside of $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# Open directory of a file using fzf
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"^M'
