-- Alternative: 'numToStr/FTerm.nvim'
-- Alternative: 'kassio/neoterm'
return {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermToggle', 'FloatermNew' },
  setup = function()
    local map = require('autoload.util').set_map
    map({ 'n', 't' }, { '<M-,><CR>', '<M-CR>' }, [[<Cmd>FloatermToggle<CR>]])
    map({ 'n', 't' }, '<M-,>c', [[<Cmd>FloatermNew<CR>]])
    map({ 'n', 't' }, '<M-,><BS>', [[<Cmd>FloatermKill<CR>]])

    map({ 'n', 't' }, '<M-,>p', [[<Cmd>FloatermPrev<CR>]])
    map({ 'n', 't' }, '<M-,>P', [[<Cmd>FloatermFirst<CR>]])

    map({ 'n', 't' }, '<M-,>n', [[<Cmd>FloatermNext<CR>]])
    map({ 'n', 't' }, '<M-,>N', [[<Cmd>FloatermLast<CR>]])
  end,
  config = function()
    vim.g.floaterm_autoclose = 2
    vim.g.floaterm_title = 'Terminal $1/$2'
    vim.g.floaterm_borderchars = (function()
      local style = O.ui.floating.border_chars.style
      local b = O.ui.floating.border_chars.styles[style]

      return table.concat({
        b.top, b.right, b.bottom, b.left, b.top_left, b.top_right, b.bottom_right, b.bottom_left
      })
    end)()
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_opener = 'tabe'

    vim.cmd([[highlight! link FloatermBorder TSFunction]])

    local set_augroup = require('autoload.util').set_augroup
    set_augroup('vim_floaterm', {
      { 'Colorscheme', '*', 'lua vim.cmd([[highlight! link FloatermBorder TSFunction]])' }
    })
  end
}
