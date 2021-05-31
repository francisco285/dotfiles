return {
  'onsails/lspkind-nvim',
  config = function()
    local kinds = O.lsp.kinds

    require('lspkind').init({
      with_text = kinds.with_text or nil,
      preset = kinds.use_codicons and 'codicons' or nil,
      symbol_map = kinds.override or { }
    })
  end,
  after = 'nvim-lspconfig'
}
