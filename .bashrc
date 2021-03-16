source ~/.config/shell/aliasrc

# Switch directory by just typing its name
shopt -s autocd

set -o vi

### KEYTIMEOUT prevents delay when pressing Esc to change vi mode
KEYTIMEOUT=1

# Change cursor according to vi mode
bind 'set show-mode-in-prompt on'
bind 'set vi-cmd-mode-string "\1\e[2 q\2"'
bind 'set vi-ins-mode-string "\1\e[6 q\2"'

# Edit current command in $EDITOR
bind '"^E":edit-command-line'

# Better tab completion
bind 'set show-all-if-ambiguous on'
bind "set menu-complete-display-prefix on"
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'

# Prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 14)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
