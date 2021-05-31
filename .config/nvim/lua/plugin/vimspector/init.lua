-- Alternative: 'mfussenegger/nvim-dap'
return {
  'puremourning/vimspector',
  fn = 'vimspector#Launch',
  setup = function()
    vim.api.nvim_exec([[
    function! GotoWindow(id)
      call win_gotoid(a:id)
      " Requires 'szw/vim-maximizer'
      MaximizerToggle
    endfunction
    ]], false)

    local map = require('autoload.util').set_map
    map('n', '<leader>dd', [[<Cmd>call vimspector#Launch()<CR>]])
    map('n', '<leader>dc', [[<Cmd>call GotoWindow(g:vimspector_session_windows.code)<CR>]])
    map('n', '<leader>dt', [[<Cmd>call GotoWindow(g:vimspector_session_windows.tagpage)<CR>]])
    map('n', '<leader>dv', [[<Cmd>call GotoWindow(g:vimspector_session_windows.variables)<CR>]])
    map('n', '<leader>dw', [[<Cmd>call GotoWindow(g:vimspector_session_windows.watches)<CR>]])
    map('n', '<leader>ds', [[<Cmd>call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>]])
    map('n', '<leader>do', [[<Cmd>call GotoWindow(g:vimspector_session_windows.output)<CR>]])
    map('n', '<leader>de', [[<Cmd>call vimspector#Reset()<CR>]])
    map('n', '<leader>d<space>', [[<Cmd>call vimspector#Continue()<CR>]])
    map('n', '<leader>dtcb', [[<Cmd>call vimspector#CleanLineBreakPoint()<CR>]])

    map('n', '<leader>dl', [[<Plug>VimspectorStepInto]])
    map('n', '<leader>dj', [[<Plug>VimspectorStepOver]])
    map('n', '<leader>dk', [[<Plug>VimspectorStepOut]])
    map('n', '<leader>d_', [[<Plug>VimspectorStepRestart]])

    map('n', '<leader>drc', [[<Plug>VimspectorrunToCursor]])
    map('n', '<leader>dbp', [[<Plug>VimspectorToggleBreakpoint]])
    map('n', '<leader>dcbp', [[<Plug>VimspectorToggleConditionalBreakpoint]])
  end
}
