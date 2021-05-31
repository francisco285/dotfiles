return function()
  local lsp_signs = O.lsp.signs
  require('trouble').setup({
    {
      signs = {
        error = lsp_signs.error,
        warning = lsp_signs.warning,
        hint = lsp_signs.hint,
        information = lsp_signs.info,
        other = ""
      },
      use_lsp_diagnostic_signs = false
    }
  })
end
