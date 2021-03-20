local util = {}

function util.echo_error_message(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format('echo "%s"', vim.fn.escape(message, '"')))
  vim.cmd([[echohl None]])
end

function util.set_map(mode, lhs, rhs, opts)
  local mode = mode
  local opts = opts or {}
  local lhs = lhs
  local rhs = rhs

  if type(mode) == 'string' then mode = { mode } end
  if type(lhs)  == 'string' then lhs  = { lhs } end

  for _, m in ipairs(mode) do
    for _, key in ipairs(lhs) do
      vim.api.nvim_set_keymap(m, key, rhs, opts)
    end
  end
end

-- https://github.com/wbthomason/packer.nvim/blob/6a169bec7d15d24c1d680fb75aa24a2921829442/lua/packer/util.lua#L34-L48
if jit then
  util.is_windows = jit.os == 'Windows'
else
  -- TODO: Handle this in a way that it does not rely on a vim function
  util.is_windows = vim.fn.has('win32')
end

-- https://github.com/wbthomason/packer.nvim/blob/6a169bec7d15d24c1d680fb75aa24a2921829442/lua/packer/util.lua#L34-L48
function util.get_separator()
  local separator = util.is_windows and '\\' or '/'
  return separator
end

-- https://github.com/wbthomason/packer.nvim/blob/6a169bec7d15d24c1d680fb75aa24a2921829442/lua/packer/util.lua#L34-L48
function util.join_paths(...)
  local separator = util.get_separator()

  return table.concat({...}, separator)
end

function util.get_git_root(relative_to)
  local relative_to = relative_to or vim.fn.expand('%:p:h')
  local sep = util.get_separator()

  -- https://vi.stackexchange.com/questions/20605/find-project-root-relative-to-the-active-buffer
  local root_dir = vim.fn.finddir('.git' .. sep .. '..', relative_to .. ';')

  return root_dir
end

function util.set_indentation(expandtab, width)
  local expandtab, width = expandtab, tonumber(width)

  if expandtab == 'true' or expandtab == '1' then
    expandtab = true
  elseif expandtab == 'false' or expandtab == '0' then
    expandtab = false
  end

  vim.bo.expandtab   = expandtab
  vim.bo.shiftwidth  = width
  vim.bo.tabstop     = width
  vim.bo.softtabstop = width
  return
end

return util
