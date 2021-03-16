# This script was copied from:
# https://github.com/softmoth/zsh-vim-mode/blob/507b346cc9de81b7f3d5d7e8a4f1426d398d406e/zsh-vim-mode.plugin.zsh

# The objective is to avoid unecessary features, it seems easier to copy just
# what I want to use instead of loading the whole plugin and trying to disable
# everything I don't need.

# This script adds extra text objects in vi-mode alongside with some of
# "github.com/tpope/vim-surround" keybindings.

typeset -A -H vim_mode_special_keys

function vim-mode-define-special-key () {
    local name="$1" tiname="$2"
    local -a seqs
    # Note that (V) uses the "^[" notation for <Esc>, and "^X" for <Ctrl-x>
    [[ -n $tiname && -n $terminfo[$tiname] ]] && seqs+=${(V)terminfo[$tiname]}
    for seq in ${@[3,-1]}; do
        seqs+=$seq
    done
    vim_mode_special_keys[$name]=${${(uOqqq)seqs}}
}

# + vim-mode-bindkey {{{1
function vim-mode-bindkey () {
    local -a maps
    local command

    while (( $# )); do
        [[ $1 = '--' ]] && break
        maps+=$1
        shift
    done
    shift

    command=$1
    shift

    # A key combo can be made of more than one key press, so a binding for
    # <Home> <End> will map to '^[[1~^[[4~', for example. XXX Except this
    # doesn't seem to work. ZLE just wants a single special key for viins
    # & vicmd (multiples work in emacs). Oh, well, this accumulator
    # doesn't hurt and may come in handy. Just only call vim-mode-bindkey
    # with one special key.

    function vim-mode-accum-combo () {
        typeset -g -a combos
        local combo="$1"; shift
        if (( $#@ )); then
            local cur="$1"; shift
            if (( ${+vim_mode_special_keys[$cur]} )); then
                for seq in ${(z)vim_mode_special_keys[$cur]}; do
                    vim-mode-accum-combo "$combo${(Q)seq}" "$@"
                done
            else
                vim-mode-accum-combo "$combo$cur" "$@"
            fi
        else
            combos+="$combo"
        fi
    }

    local -a combos
    vim-mode-accum-combo '' "$@"
    for c in ${combos}; do
        for m in ${maps}; do
            bindkey -M $m "$c" $command
        done
    done
}

autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        vim-mode-bindkey $m -- select-bracketed $c
    done
done
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        vim-mode-bindkey $m -- select-quoted $c
    done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N change-surround surround
zle -N add-surround surround
vim-mode-bindkey vicmd  -- change-surround cs
vim-mode-bindkey vicmd  -- delete-surround ds
vim-mode-bindkey vicmd  -- add-surround    ys
