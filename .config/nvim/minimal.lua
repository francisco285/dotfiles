-- Minimal configuration in lua

-- Make sure no files will be created
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd([[set nobackup]])
vim.cmd([[set noswapfile]])
vim.cmd([[set noundofile]])
vim.cmd([[set nowritebackup]])

-- Packer bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Load packer
vim.cmd([[packadd packer.nvim]])

-- Plugins to be loaded
require('packer').startup(
function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  -- Plugins go here
end
)
