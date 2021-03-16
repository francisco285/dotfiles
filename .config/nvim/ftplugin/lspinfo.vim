lua << EOF
vim.fn.nvim_buf_set_keymap(0, 'n', 'q', [[<Cmd>quit<CR>]], {})
EOF
