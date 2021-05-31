local highlight = {}

function highlight.set_custom_highlight_groups()
  vim.cmd([[highlight MatchParen gui=reverse]])
  vim.cmd([[highlight FoldColumn ctermbg=None guibg=None]])
  vim.cmd([[highlight SignColumn ctermbg=None guibg=None]])
  vim.cmd([[highlight LineNr ctermbg=None guibg=None]])
  vim.cmd([[highlight CursorLineNr ctermbg=None guibg=None]])
  vim.cmd([[highlight EndOfBuffer ctermbg=None guibg=None]])
  vim.cmd([[highlight! link Folded Comment]])
  vim.cmd([[highlight! link VertSplit Comment]])
  vim.cmd([[highlight! link ModeMsg CursorLineNr]])
  vim.cmd([[highlight! link ModeMsg CursorLineNr]])

  vim.cmd([[highlight! LspDiagnosticsVirtualTextError ctermbg=None guibg=None]])
  vim.cmd([[highlight! LspDiagnosticsVirtualTextHint ctermbg=None guibg=None]])
  vim.cmd([[highlight! LspDiagnosticsVirtualTextInformation ctermbg=None guibg=None]])
  vim.cmd([[highlight! LspDiagnosticsVirtualTextWarning ctermbg=None guibg=None]])
end

return highlight
