local fn = vim.fn
local terminal = {}

local function echo_error(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format('echo "%s"', vim.fn.escape(message, '"')))
  vim.cmd([[echohl None]])
end

terminal.run_settings = {
  javascript = {
    executable = 'node',
    command = function(file_path) return 'node ' .. file_path end
  },
  python = {
    executable = 'python3',
    command = function(file_path) return 'python3 ' .. file_path end
  },
  cpp = {
    -- TODO: Check how this could be achieved on windows
    executable = jit.os ~= 'Windows' and 'g++',
    command = function(file_path)
      local escape, fnamemodify = fn.shellescape, fn.fnamemodify
      local binary_file = escape(fnamemodify(file_path, ':r'))
      return string.format('echo "Compiling..." && g++ %s -o %s && %s', escape(file_path), binary_file, binary_file)
    end
  }
}

terminal.repl_settings = {
  python = 'python3',
  javascript = 'node',
  sh = 'sh',
  bash = 'bash',
  zsh = 'zsh'
}

-- This way we can use custom terminal commands. For instance, if
-- 'voldikss/vim-floaterm' is installed, we can use 'FloatermNew' to use
-- floaterm window instead of the default terminal window.
local function terminal_run(command, terminal_command)
  terminal_command = terminal_command or 'terminal'
  vim.cmd(terminal_command .. ' ' .. command)
end

function terminal.open_repl(filetype, terminal_command)
  if not filetype or filetype == '' then
    filetype = vim.bo.filetype
  end
  local repl = terminal.repl_settings[filetype]

  if repl then
    terminal_run(repl, terminal_command)
  else
    echo_error('No REPL settings available for the current file.')
  end
end

function terminal.run_file(terminal_command)
  local filetype = vim.bo.filetype
  local run = terminal.run_settings[filetype]

  if run then
    if fn.executable(run.executable) then
      local file_path = fn.expand('%:p')
      local command = run.command(file_path)
      terminal_run(command, terminal_command)
    else
      echo_error(run.executable .. ' is not executable.')
    end
  else
    echo_error('No run settings available the current file.')
  end
end

-- -- Usage example:
-- local map, opts = vim.api.nvim_set_keymap(), {}
-- map('n', '<M-,>r', [[<Cmd>lua require('terminal').run_file('tab split <Bar> terminal')<CR>]], opts)
-- map('n', '<M-,>R', [[<Cmd>lua require('terminal').open_repl('', 'tab split <Bar> terminal')<CR>]], opts)
-- map('n', '<F9>', [[<Cmd>lua require('terminal').run_file('FloatermNew --autoclose=0')<CR>]], opts)
-- map('n', '<F21>', [[<Cmd>lua require('terminal').open_repl('', 'FloatermNew --autoclose=0')<CR>]], opts)

return terminal
