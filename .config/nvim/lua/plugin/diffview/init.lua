return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>D', [[<Cmd>DiffviewOpen<CR>]])
  end,
  config = function()
    local cb = require('diffview.config').diffview_callback

    require('diffview').setup({
      key_bindings = {
        view = {
          -- Default keybindings
          ['<tab>']     = cb('select_next_entry'),
          ['<s-tab>']   = cb('select_prev_entry'),
          ['<leader>e'] = cb('focus_files'),
          ['<leader>b'] = cb('toggle_files'),

          -- Custom keybindings
          ['<Bslash>e'] = cb('toggle_files'),
          ['<Bslash>f'] = cb('toggle_files'),
          ['<Bslash>r'] = cb('refresh_files'),
          ['<Bslash>c'] = '<Cmd>DiffviewClose<CR>'
        },
        file_panel = {
          -- Default keybindings
          ['j']         = cb('next_entry'),
          ['<Down>']    = cb('next_entry'),
          ['k']         = cb('prev_entry'),
          ['<Up>']      = cb('prev_entry'),
          ['<CR>']      = cb('select_entry'),
          ['o']         = cb('select_entry'),
          ['R']         = cb('refresh_files'),
          ['<Tab>']     = cb('select_next_entry'),
          ['<S-Tab>']   = cb('select_prev_entry'),
          ['<Leader>e'] = cb('focus_files'),
          ['<Leader>b'] = cb('toggle_files'),

          -- Custom keybindings
          ['<Bslash>e'] = cb('toggle_files'),
          ['<Bslash>f'] = cb('toggle_files'),
          ['<Bslash>r'] = cb('refresh_files'),
          ['<Bslash>c'] = '<Cmd>DiffviewClose<CR>'
        }
      }
    })
  end
}
