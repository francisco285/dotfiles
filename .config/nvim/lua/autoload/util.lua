local util = {}

function util.echo_error_message(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format('echo "%s"', vim.fn.escape(message, '"')))
  vim.cmd([[echohl None]])
end

-- https://github.com/ChristianChiarulli/nvcode/blob/12c2b7dbad5dcd3b25d6e3cde62bd55eb7fb8df3/lua/nv-utils/init.lua#L3-L23
function util.set_augroup(group_name, definition)
  vim.cmd('augroup ' .. group_name)
  vim.cmd('autocmd!')

  for _, def in pairs(definition) do
    local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
    vim.cmd(command)
  end

  vim.cmd('augroup END')
end

-- https://github.com/ChristianChiarulli/nvcode/blob/12c2b7dbad5dcd3b25d6e3cde62bd55eb7fb8df3/lua/nv-utils/init.lua#L3-L23
function util.set_augroups(definitions)
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
      util.set_augroup(group_name, definition)
    end
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

  -- TODO: Maybe change it to something like:
  -- if expandtab == 'true' or tonumber(expandtab) == 1 then
  -- So it acts as expected when we pass a number as argument for expandtab
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
