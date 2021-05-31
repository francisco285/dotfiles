local default_global = require('init.default_global')
local custom_global = require('init.global')

-- Table with global variables
O = vim.tbl_deep_extend('force', default_global, custom_global)

local util = require('autoload.util')
local map = util.set_map

for _, plugin in pairs(O.disable_builtin_plugins) do
  vim.g['loaded_' .. plugin] = 1
end

-- NOTE: Run `:checkhealth provider` to be sure everything this is working as expected
-- Avoid search if possible
if vim.fn.executable('/usr/bin/python') then
  vim.g.python_host_prog = '/usr/bin/python'
end
if vim.fn.executable('/usr/bin/python3') then
  vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Support embedded lua, python and ruby
vim.g.vimsyn_embed = 'lPr'

-- Leader key
if O.mapleader then
  vim.g.mapleader = O.mapleader
  -- Disable default behavior of the leader key
  map({ 'n', 'x', 'o' }, O.mapleader, '', {})
end

local git_root = util.get_git_root()
if git_root == '' then
  vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
else
  vim.cmd('cd ' .. git_root)
end

require('init.abbrev')
require('init.autocmd')
require('init.command')
require('init.map')
require('init.option')

require('plugin')

local colorscheme = vim.fn.split(vim.fn.execute('colorscheme'), [[\n]])[1]

if colorscheme == 'default' and O.colorscheme ~= 'default' then
  vim.cmd('silent! colorscheme ' .. O.colorscheme)
end
