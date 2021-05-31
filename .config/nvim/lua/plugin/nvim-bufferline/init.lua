return {
  'akinsho/nvim-bufferline.lua',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', { '<M-p>', '[b', '<Leader>p', '<Left>' }, [[<Cmd>BufferLineCyclePrev<CR>]])
    map('n', { '<M-n>', ']b', '<Leader>n', '<Right>' }, [[<Cmd>BufferLineCycleNext<CR>]])

    map({ 'n', 'i' }, '<C-PageUp>', [[<Cmd>BufferLineCyclePrev<CR>]])
    map({ 'n', 'i' }, '<C-PageDown>', [[<Cmd>BufferLineCycleNext<CR>]])

    map('n', '<M-lt>', [[<Cmd>BufferLineMovePrev<CR>]])
    map('n', '<M->>', [[<Cmd>BufferLineMoveNext<CR>]])

    map('n', '<Leader>1', [[<Cmd>lua require('bufferline').go_to_buffer(1)<CR>]])
    map('n', '<Leader>2', [[<Cmd>lua require('bufferline').go_to_buffer(2)<CR>]])
    map('n', '<Leader>3', [[<Cmd>lua require('bufferline').go_to_buffer(3)<CR>]])
    map('n', '<Leader>4', [[<Cmd>lua require('bufferline').go_to_buffer(4)<CR>]])
    map('n', '<Leader>5', [[<Cmd>lua require('bufferline').go_to_buffer(5)<CR>]])
    map('n', '<Leader>6', [[<Cmd>lua require('bufferline').go_to_buffer(6)<CR>]])
    map('n', '<Leader>7', [[<Cmd>lua require('bufferline').go_to_buffer(7)<CR>]])
    map('n', '<Leader>8', [[<Cmd>lua require('bufferline').go_to_buffer(8)<CR>]])
    map('n', '<Leader>9', [[<Cmd>lua require('bufferline').go_to_buffer(9)<CR>]])
    map('n', '<Leader>0', [[<Cmd>lua require('bufferline').go_to_buffer(10)<CR>]])

    map('n', '<Leader>b', [[<Cmd>BufferLinePick<CR>]])
  end,
  config = function()
    require('bufferline').setup({
      options = {
        view = 'multiwindow',
        numbers = 'ordinal',
        number_style = '',
        mappings = false,
        buffer_close_icon= '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = 'nvim_lsp',
        show_buffer_close_icons = true,
        always_show_bufferline = true
      }
    })
  end,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
