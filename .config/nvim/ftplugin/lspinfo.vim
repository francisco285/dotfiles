lua << EOF
vim.api.nvim_buf_set_keymap(0, 'n', 'q', [[<Cmd>quit<CR>]], {})
EOF
