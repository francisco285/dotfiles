return {
  'rhysd/git-messenger.vim',
  cmd = 'GitMessenger',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>gv', [[<Cmd>GitMessenger<CR>]])
  end,
  config = function()
    local util = require('autoload.util')

    vim.g.git_messenger_no_default_mappings = 1
    vim.g.git_messenger_always_into_popup = 1
    vim.g.git_messenger_preview_mods = 'botright'

    local map_strings = {
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-o>', 'o', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '<C-i>', 'O', {})]]
    }

    local augroup_table = {}
    for _, map in ipairs(map_strings) do
      table.insert(augroup_table, { 'FileType', 'gitmessengerpopup', map })
    end

    util.set_augroup('git_messenger_buf_maps', augroup_table)
  end
}
