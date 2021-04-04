lua << EOF
vim.api.nvim_buf_set_keymap(0, 'n', '<C-o>', 'o', {})
vim.api.nvim_buf_set_keymap(0, 'n', '<C-i>', 'O', {})
EOF
