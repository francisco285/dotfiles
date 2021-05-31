-- Alternative: 'f-person/git-blame.nvim'
return {
  'APZelos/blamer.nvim',
  config = function()
    vim.g.blamer_enabled = 1
    vim.g.blamer_show_in_insert_modes = 0
    vim.g.blamer_delay = 500
    vim.g.blamer_prefix = ' '
    vim.g.blamer_relative_time = 1
  end
}
