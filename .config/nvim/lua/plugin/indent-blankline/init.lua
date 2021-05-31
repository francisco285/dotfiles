return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    vim.g.indent_blankline_buftype_exclude = { 'terminal', 'quickfix', 'prompt' }
    vim.g.indent_blankline_filetype_exclude = {
      'help',
      'startify',
      'dashboard',
      'packer',
      'neogitstatus',
      'diff',
      'gitmessengerpopup',
      'lspinfo',
      'qf',
      'text',
      ''
    }
    vim.g.indent_blankline_char = '│'
    vim.g.indent_blankline_use_treesitter = false
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_show_current_context = true
  end,
  branch = 'lua'
}
