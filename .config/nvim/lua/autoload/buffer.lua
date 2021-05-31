local util = require('autoload.util')
local buffer = {}

function buffer.is_empty()
  -- https://github.com/xolox/vim-misc/blob/3e6b8fb6f03f13434543ce1f5d24f6a5d3f34f0b/autoload/xolox/misc/buffer.vim#L23-L27
  return (not vim.bo.modified) and vim.fn.expand('%') == '' and vim.fn.line('$') <= 1 and vim.fn.getline(1) == ''
end

function buffer.is_directory()
  local fn = vim.fn
  local separator = vim.fn.has('win32') == 1 and '\\' or '/'
  return fn.match(fn.expand('%:p'), separator .. '$') ~= -1 or fn.isdirectory(fn.expand('%:p')) == -1
end

-- https://github.com/airblade/dotvim/blob/edad9fe8793b7c9266039b4cf85272a9b10cd9cb/vimrc#L323-L331
function buffer.delete_hidden()
  local fn = vim.fn
  local visible = {}
  local buffer_numbers = fn.range(1, fn.bufnr('$'))
  local filtered = {}
  for _, i in ipairs(fn.range(1, fn.tabpagenr('$'))) do
    for _, item in ipairs(fn.tabpagebuflist(i)) do
      table.insert(visible, item)
    end
  end
  for _, number in ipairs(buffer_numbers) do
    if fn.bufloaded(number) == 1 and fn.index(visible, number) == -1 then
      table.insert(filtered, number)
    end
  end
  local save_confirm = vim.o.confirm
  vim.o.confirm = false
  for _, buffer in ipairs(filtered) do
    vim.cmd('silent! bd ' .. buffer)
  end
  vim.o.confirm = save_confirm
end

function buffer.set_auto_delete()
  if (buffer.is_empty() or buffer.is_directory()) and vim.bo.buftype == '' then
    vim.cmd([[setlocal bufhidden=delete]])
  end
end

return buffer
