return {
  'skywind3000/asyncrun.vim',
  cmd = { 'AsyncRun', 'AsyncStop' },
  config = function()
    require('autoload.util').set_augroup('AsynRunAutoOpen', {
      { 'User', 'AsyncRunStart', 'lua vim.fn["asyncrun#quickfix_toggle"](0)' }
    })
  end
}
