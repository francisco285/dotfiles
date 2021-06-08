-- Require the file in order to use the `ProjectSwitch` command
require('wip.project-switch')

-- Arbitrary keymap
vim.api.nvim_set_keymap('n', '<Leader><Leader>', [[<Cmd>ProjectSwitch floating<CR>]], {})

-- Configuration example
vim.g.project_switch_opts = {
  projects = {
    { name = 'Foo', rootPath = '~/Desktop/projects/foo', enabled = true },
    { name = 'Bar', rootPath = '~/Desktop/projects/bar', enabled = false },
    { name = 'Foobar', rootPath = '~/Desktop/projects/foobar', enabled = true }
  }
}
