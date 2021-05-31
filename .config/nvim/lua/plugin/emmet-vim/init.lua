-- TODO: Remove this when/if 'https://github.com/aca/emmet-ls' starts working nicely
return {
  'mattn/emmet-vim',
  ft = { 'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact' },
  config = function()
    vim.g.user_emmet_complete_tag = 0
    vim.g.user_emmet_install_global = 0
    vim.g.user_emmet_install_command = 0
    vim.g.user_emmet_mode = 'i'
  end
}
