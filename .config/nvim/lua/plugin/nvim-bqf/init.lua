return {
  'kevinhwang91/nvim-bqf',
  config = function()
    require('bqf').setup({
      auto_enable = true,
      preview = {
        auto_preview = false,
        border_chars = (function()
          local style = O.ui.floating.border_chars.style
          local b = O.ui.floating.border_chars.styles[style]
          return {
            b.left, b.right, b.top, b.bottom,
            b.top_left, b.top_right, b.bottom_left, b.bottom_right,
            b.right
          }
        end)()
      }
    })
  end,
  ft = 'qf'
}
