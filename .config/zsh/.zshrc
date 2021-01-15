### Path to your oh-my-zsh installation.
export ZSH="/home/francisco/.oh-my-zsh"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

source $ZSH/oh-my-zsh.sh

### Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

### Load aliases
source ~/.config/shell/aliasrc

### Plugin manager
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

### Colors for the ls command
LS_COLORS=$LS_COLORS:'ow=01;34:'; export LS_COLORS

### True colors for nice coloring in tmux and vim
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

### Set tab title on terminal
# https://github.com/kovidgoyal/kitty/issues/610#issuecomment-395357004
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}
function set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec

### Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__WINCENT[ITALIC_ON]%}--- %d ---%{$__WINCENT[ITALIC_OFF]%}%b%f

### Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

### Hide % on start
unsetopt PROMPT_SP

### Insert completion on first tab
# setopt menu_complete

### Make completion works for aliases too
unsetopt complete_aliases

### Make completion lists more densely packed
setopt LIST_PACKED

### prevent accidental C-d from exiting shell
setopt ignore_eof

### Share command history across shells
setopt share_history

### Show hidden files in tab completion
_comp_options+=(globdots)

### Enable vi-mode
bindkey -v
DEFAULT_VI_MODE=viins
### KEYTIMEOUT gets rid of delay when pressing Esc to change vi mode
KEYTIMEOUT=1
### Esc remap (use C-v+ç to insert the 'ç' character)
bindkey ç vi-cmd-mode
bindkey -M visual 'ç' deactivate-region
### By default, + in vicmd puts the cursor at the beginning of the line
bindkey -M vicmd -r "+"

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Open the in-progress command inside of $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

### Key mappings
# Use Ctrl + vim_keys in tab complete menu:
bindkey -M menuselect '^H' vi-backward-char
bindkey -M menuselect '^K' vi-up-line-or-history
bindkey -M menuselect '^L' vi-forward-char
bindkey -M menuselect '^J' vi-down-line-or-history
# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "" history-incremental-pattern-search-backward
bindkey "" history-incremental-pattern-search-forward
# ctrl+u deletes line content from cursor position until beggining of the line
# Although it seems to be the default behavior, if this is not it can not work after entering vi normal mode once
bindkey "" backward-kill-line
# Open jobs in background easily (end-of-line > backward-kill-line > fg > \n)
bindkey -s '' '^[[4~fg\n'

### adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
### enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection
### fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

### Program-specific settings

### Open directory of a file using fzf
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

### fzf FuzzyFinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### End of program-specific settings

### Theme
source ~/.config/zsh/.zsh-theme
