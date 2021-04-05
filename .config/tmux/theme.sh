set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusline colors
set-option -g status-style 'fg=#202020,bg=default'

# window title colors
set-window-option -g window-status-style 'fg=#909090,bg=default'
# #I = Index, #W = WindowName
set-window-option -g window-status-format ' #I:#W'

# active window title colors
set-window-option -g window-status-current-style 'fg=#7199EE,bg=default'
# #I = Index, #W = WindowName, #F = WindowFlags
set-window-option -g window-status-current-format ' #[bold] #I:#W#F'

# message text
set-option -g message-style 'bg=default,fg=#75B5AA'

# pane number display
set-option -g display-panes-active-colour '#75B5AA'
set-option -g display-panes-colour '#151515'

# clock
set-window-option -g clock-mode-colour '#909090'

# #S = SessionName
set -g status-left '#[default,bg=default,fg=#e91e63]#S'

set -g @prefix_highlight_fg 'black'
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold'
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=#AC4142'

# status right: Prefix + Username + Host name
# 'Prefix' requires 'tmux-plugins/tmux-prefix-highlight'
set -g status-right '#{prefix_highlight} #[fg=#e91e63,bg=default]#(whoami)@#[fg=#e91e63,bg=default]#h'

### COLOR OPTIONS

# Transparent
set-option -g window-style 'bg=default'
set-option -g window-active-style 'bg=default'
set-option -g pane-border-style 'fg=colour235 bg=default'
set-option -g pane-active-border-style fg=colour240

## OCEANIC MATERIAL
# set-option -g window-style 'bg=#0F111A'
# set-option -g status-style 'bg=#0F111A'
# set-option -g pane-border-style 'fg=colour235 bg=#0F111A'
# set-option -g pane-active-border-style 'fg=colour240 bg=#0F111A'

## GRUVBOX
# set-option -g window-style 'bg=#1d2021'
# set-option -g status-style 'bg=#1d2021'
# set-option -g pane-border-style 'fg=#1d2021'
# set-option -g pane-active-border-style 'fg=#1d2021'
