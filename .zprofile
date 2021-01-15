export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.scripts"

# Default programs:
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave-browser"
export READER="zathura"

# Location and language settings:
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

# Other program settings:
export BAT_THEME="base16"
# export FZF_DEFAULT_OPTS='--layout=reverse --height 40% --preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export NNN_FIFO="/tmp/nnn.fifo"

# zsh directory
export ZDOTDIR="$HOME/.config/zsh"
# Wallpapers directory
export WALLPAPERS="$HOME/Desktop/Wallpapers-ChrisAtMachine"

# Commands commonly used in scripts
export LOCK="betterlockscreen -l dim"

# export OPENER="mimeopen"

export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.mov=🎥:\
*.mpg=🎥:\
*.wmv=🎥:\
*.m4b=🎥:\
*.flv=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"
