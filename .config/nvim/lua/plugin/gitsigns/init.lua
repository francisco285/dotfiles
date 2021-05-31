return {
  'lewis6991/gitsigns.nvim',
  event = 'BufRead *',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', ']c', [[&diff ? ']h' : '<Cmd>lua require("gitsigns").next_hunk()<CR>']], { expr = true })
    map('n', '[c', [[&diff ? '[h' : '<Cmd>lua require("gitsigns").prev_hunk()<CR>']], { expr = true })

    map('n', '<Bslash>hs', [[<Cmd>lua require('gitsigns').stage_hunk()<CR>]])
    map('n', '<Bslash>hu', [[<Cmd>lua require('gitsigns').undo_stage_hunk()<CR>]])
    map('n', '<Bslash>hr', [[<Cmd>lua require('gitsigns').reset_hunk()<CR>]])
    map('n', '<Bslash>hR', [[<Cmd>lua require('gitsigns').reset_buffer()<CR>]])
    map('n', '<Bslash>hp', [[<Cmd>lua require('gitsigns').preview_hunk()<CR>]])
    map('n', '<Bslash>hb', [[<Cmd>lua require('gitsigns').blame_line()<CR>]])

    map({ 'o', 'x' }, 'ih', [[<Cmd>lua require('gitsigns').text_object()<CR>]])
  end,
  config = function()
    function _G.gitsigns_set_colors()
      vim.api.nvim_exec([[
        highlight! GitSignsAdd          guifg=#00FF00 guibg=None ctermfg=Green  ctermbg=None
        highlight! GitSignsChange       guifg=#FF7700 guibg=None ctermfg=Yellow ctermbg=None
        highlight! GitSignsChangeDelete guifg=#0000FF guibg=None ctermfg=Blue   ctermbg=None
        highlight! GitSignsDelete       guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
        highlight! GitSignsTopDelete    guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
      ]], false)
    end

    _G.gitsigns_set_colors()

    local set_augroup = require('autoload.util').set_augroup
    set_augroup('GitSignsColors', {
      { 'ColorScheme', '*', [[lua _G.gitsigns_set_colors()]] }
    })

    require('gitsigns').setup({
      signs = {
        add          = { hl = 'GitSignsAdd'   , text = '▍' },
        change       = { hl = 'GitSignsChange', text = '▍' },
        changedelete = { hl = 'GitSignsChangeDelete', text = '▍' },
        delete       = { hl = 'GitSignsDelete', text = '▍' },
        topdelete    = { hl = 'GitSignsTopDelete', text = '▍' },
      }
    })
  end,
  requires = 'nvim-lua/plenary.nvim'
}
