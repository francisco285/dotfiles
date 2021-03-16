vim.cmd([[command! -nargs=0 Todo lua require('autoload.command').todo()]])
vim.cmd([[command! -nargs=* Indentation lua require('autoload.command').set_indentation(<f-args>)]])
