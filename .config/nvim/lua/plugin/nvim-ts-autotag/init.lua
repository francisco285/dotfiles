return {
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup()
  end,
  ft = {
    'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue'
  },
  requires = 'nvim-treesitter/nvim-treesitter'
}
