### Automatically change current working directory to typed directory
setopt autocd

### Hide % on start
unsetopt PROMPT_SP

### Make completion list more densely packed
setopt LIST_PACKED

### prevent accidental C-d from exiting shell
setopt ignore_eof

### Share command history across shells
setopt share_history

### Show hidden files on tab completion
_comp_options+=(globdots)
