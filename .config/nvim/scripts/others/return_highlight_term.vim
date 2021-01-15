" https://vi.stackexchange.com/questions/12293/read-values-from-a-highlight-group

if exists('g:return_highlight_term')
  finish
endif
let g:return_highlight_term = 1

function! ReturnHighlightTerm(group, term)
  " Store output of group to variable
  let output = execute('hi ' . a:group)

  " Find the term we're looking for
  return matchstr(output, a:term.'=\zs\S*')
endfunction
