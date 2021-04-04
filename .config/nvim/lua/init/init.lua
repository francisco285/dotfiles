local util = require('autoload.util')
local map = util.set_map

-- Disable builtin plugins
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
-- vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1

-- Avoid search if possible
if vim.fn.filereadable('/usr/bin/python') then
  vim.g.python_host_prog = '/usr/bin/python'
end
if vim.fn.filereadable('/usr/bin/python3') then
  vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Support embedded lua, python and ruby
vim.g.vimsyn_embed = 'lPr'

-- Leader key
vim.g.mapleader = ' '

-- Disable normal behavior of the leader key
map({ 'n', 'x', 'o' }, ' ', '', { noremap = true })

local git_root = util.get_git_root()
if git_root == '' then
  vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
else
  vim.cmd('cd ' .. git_root)
end

vim.cmd([[inoreabbrev :shrug: ¯\_(ツ)_/¯]])

require('init.autocmd')
require('init.command')
require('init.map')
require('init.option')

require('plugin')
