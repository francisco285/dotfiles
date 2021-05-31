-- Alternative: 'liuchengxu/vim-which-key'
-- Alternative: (Show registers) 'tversteeg/registers.nvim'
return {
  'folke/which-key.nvim',
  config = function()
    require('which-key').setup({
      plugins = {
        spelling = {
          enabled = true
        }
      }
    })
  end
}
