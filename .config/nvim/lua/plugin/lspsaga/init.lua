return {
  'glepnir/lspsaga.nvim',
  cmd = 'Lspsaga',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<C-f>', [[<Cmd>silent! lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
    map('n', '<C-b>', [[<Cmd>silent! lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
    map('n', '<Leader>vd', [[<Cmd>Lspsaga preview_definition<CR>]])
    map('n', '<Leader>f', [[<Cmd>Lspsaga lsp_finder<CR>]])

    function _G.lspsaga_hover_doc()
      if vim.bo.filetype == 'vim' then
        vim.cmd(':help ' .. vim.fn.expand('<cword>'))
      else
        vim.cmd([[Lspsaga hover_doc]])
      end
    end

    -- Also implemented by nvim-lspconfig
    map('n', '<Leader>j', [[<Cmd>Lspsaga diagnostic_jump_next<CR>]])
    map('n', '<Leader>k', [[<Cmd>Lspsaga diagnostic_jump_prev<CR>]])
    map('n', 'K', [[<Cmd>lua _G.lspsaga_hover_doc()<CR>]])
    map('n', '<Leader>a', [[<Cmd>Lspsaga code_action<CR>]])
    map('x', '<Leader>a', [[<Cmd>Lspsaga range_code_action<CR>]])
    map('i', '<C-]>', [[<Cmd>Lspsaga signature_help<CR>]])
    map('n', '<Leader>r', [[<Cmd>Lspsaga rename<CR>]])
    map('n', '<Leader>D', [[<Cmd>Lspsaga show_line_diagnostics<CR>]])
  end,
  after = 'nvim-lspconfig',
  requires = 'neovim/nvim-lspconfig'
}
