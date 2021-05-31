return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  config = function()
    require('packer').loader('telescope.nvim')
    require('octo').setup()
  end,
  requires = 'nvim-telescope/telescope.nvim'
}
