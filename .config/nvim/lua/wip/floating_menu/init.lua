-- TODO: Create a function which will provide a floating window to be used as a
-- menu, so something like:
-- require('autoload.util').floating_menu({
--   { line = 'Tabs 2', run = 'setlocal noet sw=2 ts=2 sts=2' },
--   { line = 'Tabs 4', run = 'setlocal noet sw=4 ts=4 sts=4' },
--   { line = 'Spaces 2', run = 'setlocal et sw=2 ts=2 sts=2' },
--   { line = 'Spaces 4', run = 'setlocal et sw=4 ts=4 sts=4' }
-- }, { title = 'Set Indentation', title_alignment = 'center', lines_alignment = 'left' })
-- Could be used to show a menu where if we press <CR> on line {line} will run
-- a command set in {run}, it would look like this in practice:
--------------------------------------------------------------------------------
--                              Set Indentation
-- 'Tabs 2'
-- 'Tabs 4' <- (Line 3)
-- 'Spaces 2'
-- 'Spaces 4'
--------------------------------------------------------------------------------
-- Pressing <CR> on line 3 would run 'setlocal noet sw=4 ts=4 sts=4'

-- This plugin might help:
-- https://github.com/tamago324/tiknot.nvim

local M = {}

function M.on_cr()
  local line = vim.fn.getline('.')
  local line_to_command = vim.b.line_to_command
  -- TODO: Somehow make it so each key is unique, even if there are equal lines on the menu
  -- Probably the easist way would be using the line number to differentiate
  if line_to_command[line] then
    -- This makes it possible to execute commands in a way that makes more
    -- sense, because (for example) running 'set noexpandtab' would be applied
    -- for the current buffer, which is the menu buffer, but in that case, we
    -- would probably intend to apply it to the buffer that appears right after
    -- the menu is gone, hence we have to use an autocmd
    local cmd = string.format('autocmd WinEnter,BufWinEnter,BufEnter * ++once %s', line_to_command[line])
    vim.cmd(cmd)
    vim.cmd('close!')
  end
end

function M.floating_menu(content, opts)
  opts = vim.tbl_deep_extend('force', {
    title = nil,
    title_alignment = 'left',
    lines_alignment = 'left',
    height = 0.4,
    width = 0.6,
    autoclose = false
  }, opts or {})

  local buf = vim.api.nvim_create_buf(false, true)

  local line_to_command = {}
  local lines = (opts.title and { opts.title, '' }) or {}

  for _, info in ipairs(content) do
    table.insert(lines, info.line)
    line_to_command[info.line] = info.run
  end

  vim.api.nvim_buf_set_var(buf, 'line_to_command', line_to_command)

  -- TODO: Maybe remove this, it seems to be a bit too much
  local cmd
  if opts.title then
    cmd = [[<Cmd>call cursor(%s + 2, 1)<CR>]]
  else
    cmd = [[<Cmd>call cursor(%s, 1)<CR>]]
  end
  for i = 1, 9 do
    local map_cmd = string.format(cmd, i)
    vim.api.nvim_buf_set_keymap(buf, 'n', tostring(i), map_cmd, { silent = true })
  end

  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>',
  [[<Cmd>lua require('wip.floating_menu').on_cr()<CR>]],
  { silent = true })

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', [[<Cmd>close!<CR>]], { silent = true })

  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

  -- Floating windows by default have a different background, I personally don't like it
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf, 'readonly', true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  local ui = vim.api.nvim_list_uis()[1]

  if opts.width and opts.height then
    if opts.width == 'exact' then
      local longest_line = ''
      for _, line in ipairs(lines) do
        if #line > #longest_line then
          longest_line = line
        end
      end
      opts.width = #longest_line
      if type(opts.width_padding) == type(0) then
        -- WIP
        -- opts.width = opts.width + opts.width_padding
      end
    elseif type(opts.width) == type(0) then
        -- WIP
      -- opts.width = (opts.width < 1 and opts.width > 0) and math.floor(opts.width * ui.width) or opts.width
    end
    if opts.height == 'exact' then
      opts.height = (opts.title and (#content + 2)) or #content
      vim.g.bar = opts.height
      if type(opts.height_padding) == type(0) then
        opts.height = opts.height + opts.height_padding
      end
    elseif type(opts.height) == type(0) then
      opts.height = (opts.height < 1 and opts.height > 0) and math.floor(opts.height * ui.height) or opts.height
    end
  end

  local win_opts = {
    relative = 'editor',
    width = opts.width,
    height = opts.height,
    border = 'single',
    row = math.floor((ui.height - opts.height)/2),
    col = math.floor((ui.width - opts.width)/2),
    style = 'Minimal',
    focusable = true
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:NormalNC')
  vim.api.nvim_win_set_option(win, 'cursorline', true)

  -- Initial cursor position (line, column)
  if opts.title then
    vim.api.nvim_win_set_cursor(win, { 3, 0 })
  else
    vim.api.nvim_win_set_cursor(win, { 1, 0 })
  end

end

vim.api.nvim_set_keymap('n', '<Leader><Leader>', [[<Cmd>luafile /tmp/fizz.lua<CR>]], {})

return M
