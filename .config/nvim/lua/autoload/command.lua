local command = {}
local util = require('autoload.util')

-- https://github.com/junegunn/dotfiles/blob/18e886d73eac4866724cfcb00ef168dffd5be0d4/vimrc#L861-L882
function command.todo()
  local v, fn = vim.v, vim.fn

  local entries = {}
  local cmds = {
    'git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
    'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null'
  }

  for _, cmd in ipairs(cmds) do
    local lines = fn.split(fn.system(cmd), [[\n]])

    if v.shell_error == 0 then
      for _, line in ipairs(lines) do
        local matchlist = fn.matchlist(line, [[^\([^:]*\):\([^:]*\):\(.*\)]])
        local fname, lno, text = matchlist[2], matchlist[3], matchlist[4]

        table.insert(entries, { filename = fname, lnum = lno, text = text })
      end

      break
    end
  end

  if fn.empty(entries) == 0 then
    fn.setqflist(entries)
    vim.cmd([[copen]])
  end
end

function command.set_indentation(...)
  util.set_indentation(...)
end

return command
