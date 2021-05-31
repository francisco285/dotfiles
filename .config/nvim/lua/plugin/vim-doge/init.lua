return {
  'kkoomen/vim-doge',
  ft = {
    'c', 'coffee', 'cpp', 'java', 'groovy', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'kotlin', 'lua', 'php', 'python', 'r',
    'ruby', 'rust', 'scala', 'sh'
  },
  setup = function()
    vim.g.doge_mapping = '<M-d>'
    vim.g.doge_mapping_comment_jump_forward = '<M-j>'
    vim.g.doge_mapping_comment_jump_backward = '<M-k>'
    vim.g.doge_comment_jump_modes = { 'n', 'i', 's' }
  end,
  run = ':call doge#install()'
}
