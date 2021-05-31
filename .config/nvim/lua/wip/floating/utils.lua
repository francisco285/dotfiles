-- Creates a floating window with a scratch, unlisted buffer
-- TODO: Toggle window
-- TODO: Find a way to automatically display some text (in a pretty way)

-- References:
-- https://www.reddit.com/r/neovim/comments/nkm1h7/how_to_float_window/
-- https://github.com/marcushwz/nvim-workbench
-- https://www.statox.fr/posts/2021/03/breaking_habits_floating_window/

local M = {}

function M.setup(opts)
  local default_opts = {
    initialized = false,
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│'},
    width = 0.6,
    height = 0.5
  }

  FloatWizard = vim.tbl_deep_extend('force', opts or {}, default_opts)
end

function M.show_error(message)
  vim.api.nvim_err_writeln(message)
end

function M.config()
  local ui = vim.api.nvim_list_uis()[1]

  local width = FloatWizard.width
  local height = FloatWizard.height

  if width <= 1 and height <= 1 then
    width = math.floor(ui.width * width)
    height = math.floor(ui.height * height)
  else
    width = width
    height = height
  end

  return {
    relative = 'editor',
    width = width,
    height = height,
    border = FloatWizard.border or 'single',
    row = math.floor((ui.height - height)/2),
    col = math.floor((ui.width - width)/2),
    style = 'Minimal',
    focusable = true
  }
end

function M.set_options()
  vim.cmd([[setlocal bufhidden=hide]])
  vim.cmd([[setlocal nobuflisted]])
  vim.cmd([[setlocal filetype=MyFloatingWindow]])
  vim.cmd([[setlocal signcolumn=no]])
  vim.cmd([[setlocal winblend=10]])
  vim.cmd([[setlocal winhighlight=Normal:NormalNC]])
end

function M.set_keymaps()
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', [[<Cmd>close!<CR>]], { })
end

function M.create()
  local buffer = vim.api.nvim_create_buf(false, true)
  local win_id = vim.api.nvim_open_win(buffer, true, M.config())

  M.set_options()
  M.set_keymaps()

  return win_id, buffer
end

function M.initialize()
  FloatWizard.win_id, FloatWizard.bufnr = M.create()
  FloatWizard.initialized = true
end

function M.hide()
  vim.cmd([[hide]])
end

function M.show()
  FloatWizard.win_id = vim.api.nvim_open_win(FloatWizard.bufnr, true, M.config())
end

function M.toggle()
  if not FloatWizard.initialized then
    M.initialize()
  else
    if vim.fn.win_getid() == FloatWizard.win_id then
      M.hide()
    else
      M.show()
    end
  end
end

function M.toggle_terminal(command)
  M.toggle()
  vim.cmd('terminal ' .. (command or ''))
end

return M
