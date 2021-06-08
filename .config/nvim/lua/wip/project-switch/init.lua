-- https://www.reddit.com/r/neovim/comments/nqmo16/how_do_yo_manage_project_switching/

local M = {}

vim.g.project_switch_opts = vim.g.project_switch_opts or {
  projects = {}
}

local function get_enabled_projects()
  local projects = vim.g.project_switch_opts.projects

  local enabled_projects = {}
  for _, project in ipairs(projects) do
    if project.enabled then
      table.insert(enabled_projects, { name = project.name, path = project.rootPath })
    end
  end

  return enabled_projects
end

function M.cd(path)
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    error(string.format('Project %s not found!', path))
  else
    vim.cmd('cd ' .. path)
  end
end

M.floating = {}

function M.floating.get_path_by_line(line)
  -- This must be a table like:
  -- {
  --   ['[1] Foo: ~/Desktop/projects/foo'] = '~/Desktop/projects/foo',
  --   ['[2] Bar: ~/Desktop/projects/bar'] = '~/Desktop/projects/bar'
  -- }
  local line_to_project_path = vim.b.line_to_project_path
  if not line_to_project_path then return end
  return line_to_project_path[line]
end

-- This is meant to be used when we press <CR> (enter) on the floating window
function M.floating.on_cr()
  local line = vim.fn.getline('.')
  local path = M.floating.get_path_by_line(line)
  -- If path is not present in line_to_project_path, that means that the
  -- selected line is not related to a project (e.g. 'Projects: ' as a title at
  -- the top)
  if path then
    local ok, error_msg = pcall(M.cd, path)
    if ok then
      vim.cmd('close!')
    else
      vim.api.nvim_err_writeln(error_msg)
    end
  end
end

function M.switch(method)
  -- Use 'input' method by default
  method = method or 'input'

  local enabled_projects = get_enabled_projects()

  -- 'input' will use neovim's input() function, see `:help input()`
  if method == 'input' then
    local prompt = 'Projects: \n'
    for index, project in ipairs(enabled_projects) do
      prompt = prompt .. string.format('[%s] %s -> %s\n', index, project.name, project.path)
    end

    local project_index = tonumber(vim.fn['input']({ prompt = prompt }))
    if not project_index then return end

    local selected_project = enabled_projects[project_index]
    vim.cmd([[echo "\n"]])
    M.cd(selected_project.path)
  -- 'floating' will open a floating window (requires neovim nightly)
  elseif method == 'floating' then
    local ui = vim.api.nvim_list_uis()[1]

    -- Set width to be 60% of the screen width
    local width = math.floor(ui.width * 0.6)

    -- Set height to be 40% of the screen height
    -- local height = math.floor(ui.height * 0.4)

    -- Set height to be exactly equal to the number of lines
    -- (see vim.api.nvim_buf_set_lines below)
    local height = #enabled_projects + 2

    local win_opts = {
      relative = 'editor',
      width = width,
      height = height,
      border = 'single',
      row = math.floor((ui.height - height)/2),
      col = math.floor((ui.width - width)/2),
      style = 'Minimal',
      focusable = true
    }

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    local lines = {}
    local line_to_project_path = {}
    for index, project in ipairs(enabled_projects) do
      -- Add line containing project info (name and path), e.g.:
      -- [1] Foo: ~/Desktop/projects/foo
      -- [2] Bar: ~/Desktop/projects/bar
      local line = string.format('[%s] %s: %s', index, project.name, project.path)
      table.insert(lines, line)
      line_to_project_path[line] = project.path
      -- Set keymaps related to projects, e.g.:
      -- Pressing 1 will cd to ~/Desktop/projects/foo wich is the path related with project 'Foo'
      -- Pressing 2 will cd to ~/Desktop/projects/bar wich is the path related with project 'Bar'
      local cmd = string.format([[<Cmd>lua require('wip.project-switch').cd("%s")<CR><Cmd>close!<CR>]], project.path)
      vim.api.nvim_buf_set_keymap(buf, 'n', tostring(index), cmd, { silent = true })
    end

    vim.b.line_to_project_path = line_to_project_path
    -- Map <CR> (Enter) to select project in line/under cursor

    vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>',
    [[<Cmd>lua require('wip.project-switch').floating.on_cr()<CR>]],
    { silent = true })

    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', [[<Cmd>close!<CR>]], { silent = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { 'Projects: ', '', unpack(lines) })

    -- Floating windows by default have a different background, I personally don't like it
    vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:NormalNC')
    vim.api.nvim_win_set_option(win, 'cursorline', true)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'readonly', true)

    -- Initial cursor position (line, column)
    vim.fn.cursor(3, 2)
  end
end

-- Commmand without tab complete
-- vim.cmd([[command! -nargs=? ProjectSwitch lua require('wip.project-switch').switch(<f-args>)]])

-- Commmand with tab complete
vim.cmd([[command! -nargs=? -complete=custom,v:lua._G.project_switch_completion ProjectSwitch lua require('wip.project-switch').switch(<f-args>)]])

-- Function used for tab complete
function _G.project_switch_completion()
  return table.concat({ 'input', 'floating' }, '\n')
end

return M
