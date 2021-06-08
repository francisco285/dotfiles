return {
  'rmagatti/goto-preview',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', 'gpd', [[<Cmd>lua require('goto-preview').goto_preview_definition()<CR>]])
    map('n', 'gpi', [[<Cmd>lua require('goto-preview').goto_preview_implementation()<CR>]])
    map('n', 'gP', [[<Cmd>lua require('goto-preview').close_all_win()<CR>]])
  end,
  config = function()
    require('goto-preview').setup({
      -- width = 120; -- Width of the floating window
      -- height = 15; -- Height of the floating window
      default_mappings = false; -- Bind default mappings
      -- debug = false; -- Print debug information
    --   opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
    --   lsp_configs = { -- Lsp result configs
    --   lua = {
    --     get_config = function(data)
    --       return data.targetUri,{ data.targetRange.start.line + 1, data.targetRange.start.character }
    --     end
    --   };
    --   typescript = {
    --     get_config = function(data)
    --       return data.uri, { data.range.start.line + 1, data.range.start.character }
    --     end
    --   }
    -- }
  })
  end
}
