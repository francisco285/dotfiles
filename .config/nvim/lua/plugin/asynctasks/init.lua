-- https://code.visualstudio.com/docs/editor/tasks
return {
  'skywind3000/asynctasks.vim',
  cmd = { 'AsyncTask', 'AsyncTaskEdit', 'AsyncTaskList', 'AsyncTaskMacro', 'AsyncTaskProfile' },
  map = function()
    local set_map = require('autoload.util').set_map
    set_map({ 'n', 'i' }, '<F6>', '<Cmd>AsyncTask file-build<CR>' )
    set_map({ 'n', 'i' }, '<F7>', '<Cmd>AsyncTask file-run<CR>' )
    set_map({ 'n', 'i' }, '<F19>', '<Cmd>AsyncTask file-build-and-run<CR>' )
  end,
  setup = function()
    if packer_plugins['vim-floaterm'] then
      vim.api.nvim_exec([[
      function! AsyncrunFloaterm(opts) abort
      execute 'FloatermNew --autoclose=0 ' . a:opts.cmd
      endfunction

        let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
        let g:asyncrun_runner.floaterm = function('AsyncrunFloaterm')
          let g:asynctasks_term_pos = 'floaterm'
          ]], false)
        else
          vim.g.asynctasks_term_pos = 'tab'
        end

        vim.g.asynctasks_term_reuse = 1
        vim.g.asynctasks_term_hidden = 1
        vim.g.asynctasks_term_listed = 0
        vim.g.asynctasks_confirm = 0
      end
    }
