return {
  'glacambre/firenvim',
  cond = function()
    if vim.fn.exists('g:started_by_firenvim') ~= 0 then return true end
    return false
  end,
  run = function()
    vim.fn['firenvim#install'](1)
  end,
  config = function()
    vim.g.firenvim_config = {
      localSettings = {
        ['.*'] = {
          cmdline = 'neovim',
          content = 'text',
          selector = 'textarea',
          takeover = 'never'
        }
      }
    }
  end
}
