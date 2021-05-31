return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    if O.treesitter.enable_fold then
      vim.cmd([[set foldmethod=expr]])
      vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
    end
    require('nvim-treesitter.configs').setup(O.treesitter.setup)
  end
}
