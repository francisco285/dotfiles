-- NOTE: In order to actually be able to use this plugin, go to
-- https://github.com/settings/tokens > Generate new token > set 'gist' scope
-- > paste the generated token in ~/.gist-vim
-- https://github.com/mattn/vim-gist/issues/230#issuecomment-810064767
return {
  'mattn/vim-gist',
  cmd = 'Gist',
  setup = function()
    vim.g.gist_post_private = 1
  end,
  config = function()
    local gist_file = vim.fn.expand('~/.gist-vim')
    if vim.fn.empty(vim.fn.glob(gist_file)) > 0 then
      vim.cmd([[echohl Error]])
      vim.fn.input({ prompt = gist_file .. ' not found, check out https://github.com/mattn/vim-gist#setup [Press ENTER]' })
      vim.cmd([[echohl None]])
    end
  end,
  requires = 'mattn/webapi-vim'
}
