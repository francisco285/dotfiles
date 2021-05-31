local utils = require('wip.floating.utils')

vim.cmd('command! -nargs=* FWToggle lua require("wip.floating").toggle()')
vim.cmd('command! -nargs=* FWShow lua require("wip.floating").show()')
vim.cmd('command! -nargs=* FWHide lua require("wip.floating").hide()')
vim.cmd('command! -nargs=* FWToggleTerminal lua require("wip.floating").toggle_terminal(<f-args>)')

return {
  toggle = utils.toggle,
  show = utils.show,
  hide = utils.hide,
  toggle_terminal = utils.toggle_terminal,
  setup = utils.setup
}
