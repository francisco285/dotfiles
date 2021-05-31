vim.cmd([[command! -nargs=* Indentation lua require('autoload.init.command').set_indentation(<f-args>)]])
