local functions = {}

functions.lspsaga = {
  hover_doc = function()
    if vim.bo.filetype == 'vim' then
      vim.cmd(':help ' .. vim.fn.expand('<cword>'))
    else
      vim.cmd([[Lspsaga hover_doc]])
    end
  end
}

functions.gitsigns = {
  set_colors = function()
    vim.api.nvim_exec([[
      highlight GitSignsAdd          guifg=#00FF00 guibg=None ctermfg=Green  ctermbg=None
      highlight GitSignsChange       guifg=#FF7700 guibg=None ctermfg=Yellow ctermbg=None
      highlight GitSignsChangeDelete guifg=#0000FF guibg=None ctermfg=Blue   ctermbg=None
      highlight GitSignsDelete       guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
      highlight GitSignsTopDelete    guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
    ]], false)
  end
}

return functions
