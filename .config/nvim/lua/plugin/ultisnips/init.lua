-- Alternative: 'hrsh7th/vim-vsnip'
return {
  'SirVer/ultisnips',
  setup = function()
    vim.g.UltiSnipsExpandTrigger = '<M-,>'
    vim.g.UltiSnipsJumpForwardTrigger = '<M-j>'
    vim.g.UltiSnipsJumpBackwardTrigger = '<M-k>'
  end,
  requires = 'honza/vim-snippets'
}
