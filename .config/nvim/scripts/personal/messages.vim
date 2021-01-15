if exists('g:loaded_personal_messages')
  finish
endif
let g:loaded_personal_messages = 1

function! s:echoEmptyMsg(timer)
  if mode() !=# 'c'
    echo ''
  endif
endfunction

function! SetTimer(time)
  if exists('g:lastTimer')
    call timer_stop(g:lastTimer)
  endif
  let g:lastTimer = timer_start(a:time, funcref('s:echoEmptyMsg'), {'repeat': 1})
endfunction

autocmd CmdlineLeave * call SetTimer(4000)
