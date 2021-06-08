lua << EOF
local max_height = math.ceil(vim.o.lines / 4)
local amount_of_qf_entries = vim.fn.len(vim.fn.getqflist())

if amount_of_qf_entries < max_height then
  vim.api.nvim_win_set_height(0, amount_of_qf_entries)
else
  vim.api.nvim_win_set_height(0, max_height)
end

local map = vim.api.nvim_buf_set_keymap

map(0, 'n', 'q', '<Cmd>quit<CR>', {})
EOF
