return {
  'folke/trouble.nvim',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>d', [[<Cmd>TroubleToggle lsp_document_diagnostics<CR>]])
  end,
  config = function()
    local lsp_signs = O.lsp.signs
    require('trouble').setup({
      fold_open = '',
      fold_closed = '',
      signs = {
        error = lsp_signs.error,
        warning = lsp_signs.warning,
        hint = lsp_signs.hint,
        information = lsp_signs.info,
        other = ''
      },
      use_lsp_diagnostic_signs = false,
      auto_preview = false
    })
  end,
  requires = 'kyazdani42/nvim-web-devicons'
}
