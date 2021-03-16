source $HOME/.config/zsh/include/options.zsh
source $HOME/.config/shell/aliasrc
source $HOME/.config/zsh/include/theme.zsh
source $HOME/.config/zsh/include/vi-text-objects.zsh
source $HOME/.config/zsh/include/keybindings.zsh
source $HOME/.config/zsh/include/plugins.zsh
source $HOME/.config/zsh/include/abbreviations.zsh

# Tab completion similar to oh-my-zsh's
# https://stackoverflow.com/a/24237590
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

### Change default editor for remote sessions
[[ -n $SSH_CONNECTION ]] && export EDITOR='vim'

### True colors for nice coloring in tmux and vim
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color

# https://github.com/wincent/wincent/blob/master/aspects/dotfiles/files/.zshrc

### Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$'\e[3m'%}--- %d ---%{$'\e[23m'%}%b%f

### adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
### enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection
### fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

### fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.local/zsh_history
