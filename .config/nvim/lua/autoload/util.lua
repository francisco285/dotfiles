local M = {}

function M.echo_error_message(message)
  vim.cmd([[echohl ErrorMsg]])
  vim.cmd(string.format('echo "%s"', vim.fn.escape(message, '"')))
  vim.cmd([[echohl None]])
end

-- https://github.com/ChristianChiarulli/nvcode/blob/12c2b7dbad5dcd3b25d6e3cde62bd55eb7fb8df3/lua/nv-utils/init.lua#L3-L23
function M.set_augroup(group_name, definition)
  vim.cmd('augroup ' .. group_name)
  vim.cmd('autocmd!')

  for _, def in pairs(definition) do
    -- local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
    local command = 'autocmd ' .. table.concat(def, ' ')
    vim.cmd(command)
  end

  vim.cmd('augroup END')
end

-- https://github.com/ChristianChiarulli/nvcode/blob/12c2b7dbad5dcd3b25d6e3cde62bd55eb7fb8df3/lua/nv-utils/init.lua#L3-L23
function M.set_augroups(definitions)
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
      M.set_augroup(group_name, definition)
    end
end

function M.set_map(modes, lhs, rhs, opts)
  opts = opts or {}

  if type(modes) == 'string' then modes = { modes } end
  if type(lhs)  == 'string' then lhs  = { lhs } end

  for _, mode in ipairs(modes) do
    for _, key in ipairs(lhs) do
      vim.api.nvim_set_keymap(mode, key, rhs, opts)
    end
  end
end

function M.set_buf_map(bufnr, modes, lhs, rhs, opts)
  opts = opts or {}

  if type(modes) == 'string' then modes = { modes } end
  if type(lhs)  == 'string' then lhs  = { lhs } end

  for _, mode in ipairs(modes) do
    for _, key in ipairs(lhs) do
      vim.api.nvim_set_keymap(bufnr, mode, key, rhs, opts)
    end
  end
end

-- https://github.com/wbthomason/packer.nvim/blob/6a169bec7d15d24c1d680fb75aa24a2921829442/lua/packer/util.lua#L34-L48
if jit then
  M.is_windows = jit.os == 'Windows'
else
  M.is_windows = vim.fn.has('win32')
end

function M.get_git_root(relative_to)
  relative_to = relative_to or vim.fn.expand('%:p:h')

  -- https://vi.stackexchange.com/questions/20605/find-project-root-relative-to-the-active-buffer
  local root_dir = vim.fn.finddir(vim.fn.expand('.git/..', relative_to .. ';'))

  return root_dir
end

function M.set_indentation(expandtab, width)
  expandtab, width = expandtab, tonumber(width)

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

-- https://github.com/wbthomason/packer.nvim/blob/master/lua/packer/display.lua#L116-L164
--- Utility function to prompt a user with a question in a floating window
function M.prompt_user(opts)
  local headline = opts.headline
  local body = opts.body
  local default_answer = opts.default_answer or true
  local prompt = opts.prompt or ((default_answer == true) and '[Y/n]' or '[y/N]')
  local callback = opts.callback

 local buf = vim.api.nvim_create_buf(false, true)
  local longest_line = 0
  for _, line in ipairs(body) do
    local line_length = string.len(line)
    if line_length > longest_line then longest_line = line_length end
  end

  local width = math.min(longest_line + 2, math.floor(0.9 * vim.o.columns))
  local height = #body + 3
  local x = (vim.o.columns - width) / 2.0
  local y = (vim.o.lines - height) / 2.0

  local bar = {}
  for _, line in ipairs(body) do
    local pad_width = math.max(math.floor((width - string.len(line)) / 2.0), 0)
    table.insert(bar, string.rep(' ', pad_width ) .. line .. string.rep(' ', pad_width))
  end

  local pad_width = math.max(math.floor((width - string.len(headline)) / 2.0), 0)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true,
  vim.list_extend({ string.rep(' ', pad_width) .. headline .. string.rep(' ', pad_width), '' }, bar))

  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = x,
    row = y,
    focusable = false,
    style = 'minimal',
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
  }

  local win = vim.api.nvim_open_win(buf, false, win_opts)
  local check = vim.loop.new_prepare()
  local prompted = false
  vim.loop.prepare_start(check, vim.schedule_wrap(function()
    if not vim.api.nvim_win_is_valid(win) then return end
    vim.loop.prepare_stop(check)
    if not prompted then
      prompted = true
      local ans
      local input = string.lower(vim.fn.input({ prompt = prompt }))

      if default_answer == true then
        ans = input ~= 'n'
      else
        ans = input == 'y'
      end

      vim.api.nvim_win_close(win, true)
      callback(ans)
    end
  end))
end

---@param table table
--Print table contents in the form of: key -> type -> value
function M.print_table_contents(table)
  for key, value in pairs(table) do
    print(string.format('%s -> %s -> %s', key, type(value), value))
  end
end

---@param table table
function M.is_vim_dictionary(table)
  return vim.fn.type(table) == 4
end

return M
