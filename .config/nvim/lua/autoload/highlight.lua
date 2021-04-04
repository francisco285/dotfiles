local highlight = {}

function highlight.set_custom_highlight_groups()
  vim.cmd([[highlight Normal guibg=#0F111A]])
  vim.cmd([[highlight FoldColumn ctermbg=None guibg=None]])
  vim.cmd([[highlight SignColumn ctermbg=None guibg=None]])
  vim.cmd([[highlight LineNr ctermbg=None guibg=None]])
  vim.cmd([[highlight CursorLineNr ctermbg=None guibg=None]])
  vim.cmd([[highlight! link VertSplit Comment]])
  vim.cmd([[highlight! link ModeMsg CursorLineNr]])
  vim.cmd([[highlight! link ModeMsg CursorLineNr]])
end

return highlight
