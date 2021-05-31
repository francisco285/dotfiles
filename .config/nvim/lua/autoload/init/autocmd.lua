local autocmd = {}

function autocmd.remember_cursor_position()
  local fn = vim.fn
  local ft = vim.bo.filetype
  if fn.line([['"]]) >= 1 and fn.line([['"]]) <= fn.line("$") and string.match(ft, 'commit') == nil then
    vim.cmd([[normal! g`"]])
  end
end

function autocmd.terminal_autoinsert()
  vim.cmd([[startinsert]])
end

function autocmd.buf_auto_delete()
  require('autoload.buffer').set_auto_delete()
end

function autocmd.yank_highlight()
  vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 })
end

function autocmd.set_custom_highlight_groups()
  require('autoload.highlight').set_custom_highlight_groups()
end

function autocmd.auto_fill_location_list()
  vim.lsp.diagnostic.set_loclist({ open_loclist = false })
end

return autocmd
