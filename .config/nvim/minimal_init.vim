" vim: expandtab:shiftwidth=2:tabstop=2:softtabstop=2
" Minimal init.vim

set noundofile
set nowritebackup
set noswapfile
set nowritebackup
set clipboard=unnamed,unnamedplus
set wildignorecase
set ignorecase
set hidden

lua << EOF
local install_path = vim.fn.expand(vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim')

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd([[packadd packer.nvim]])

require('packer').startup(
function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  -- Plugins go here
end
)
EOF
