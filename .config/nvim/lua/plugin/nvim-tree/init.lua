-- Alternative: 'ms-jpq/chadtree'
-- (BROKEN: https://github.com/kyazdani42/nvim-tree.lua/issues/280#issuecomment-823430866)
-- SOLUTION: Don't lazy load it
return {
  'kyazdani42/nvim-tree.lua',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>e', [[<Cmd>NvimTreeToggle<CR>]])
    map('n', '<Bslash>E', [[<Cmd>NvimTreeToggle<CR>]])
  end,
  config = function()
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_quit_on_open = 1
    vim.g.nvim_tree_lsp_diagnostics = 1

    local nvim_tree = require('nvim-tree.config')

    local tree_cb = nvim_tree.nvim_tree_callback
    vim.g.nvim_tree_bindings = {
      ['<CR>']           = tree_cb('edit'),
      ['l']              = tree_cb('edit'),
      ['o']              = tree_cb('edit'),
      ['<2-LeftMouse>']  = tree_cb('edit'),
      ['<2-RightMouse>'] = tree_cb('cd'),
      ['<C-]>']          = tree_cb('cd'),
      ['v']              = tree_cb('vsplit'),
      ['s']              = tree_cb('split'),
      ['<C-t>']          = tree_cb('tabnew'),
      ['h']              = tree_cb('close_node'),
      ['<BS>']           = tree_cb('close_node'),
      ['<S-CR>']         = tree_cb('close_node'),
      ['<Tab>']          = tree_cb('preview'),
      ['I']              = tree_cb('toggle_ignored'),
      ['H']              = tree_cb('toggle_dotfiles'),
      ['R']              = tree_cb('refresh'),
      ['a']              = tree_cb('create'),
      ['d']              = tree_cb('remove'),
      ['r']              = tree_cb('rename'),
      ['<C-r>']          = tree_cb('full_rename'),
      ['x']              = tree_cb('cut'),
      ['c']              = tree_cb('copy'),
      ['p']              = tree_cb('paste'),
      ['[c']             = tree_cb('prev_git_item'),
      [']c']             = tree_cb('next_git_item'),
      ['-']              = tree_cb('dir_up'),
      ['q']              = tree_cb('close')
    }

    local lsp_signs = O.lsp.signs

    vim.g.nvim_tree_icons = {
      default = '',
      symlink = '',
      git = {
        unstaged = 'M',
        staged = '',
        unmerged = 'U',
        renamed = 'R',
        untracked = '?',
        deleted = 'D',
        ignored = 'I'
      },
      folder = {
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
        symlink_open = ''
      },
      lsp = {
        hint = lsp_signs.hint,
        info = lsp_signs.info,
        warning = lsp_signs.warning,
        error = lsp_signs.error
      }
    }
  end,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
