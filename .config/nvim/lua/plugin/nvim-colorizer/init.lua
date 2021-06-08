return {
  'norcalli/nvim-colorizer.lua',
  event = 'BufRead *',
  config = function()
    require('colorizer').setup({
      '*',
      css = { css = true },
      html = { mode = 'foreground' }
    })
  end
}
