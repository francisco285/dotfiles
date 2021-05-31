### PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts"

### Rust
export PATH="$PATH:$HOME/.cargo/bin"

### Default programs
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export READER="zathura"

### Directories
export ZDOTDIR="$HOME/.config/zsh"
export BOOKS="$HOME/Books"
export WALLPAPERS="$HOME/Wallpapers"
export SCREENSHOTS="$HOME/Pictures/Screenshots"
export XDG_CONFIG_HOME="$HOME/.config/"

### Location settings
export LANG="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
# export LC_MONETARY="en_US.UTF-8"
# export LC_PAPER="en_US.UTF-8"
# export LC_NAME="en_US.UTF-8"
# export LC_ADDRESS="en_US.UTF-8"
# export LC_TELEPHONE="en_US.UTF-8"
# export LC_MEASUREMENT="en_US.UTF-8"
# export LC_IDENTIFICATION="en_US.UTF-8"

### Program settings
export BAT_THEME="base16"
export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
# https://github.com/junegunn/fzf/issues/337#issuecomment-702478187
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git"'
