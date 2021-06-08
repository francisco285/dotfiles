-- A bunch of functions to be used for the statusline

local M = {}

function M.cwd_head()
  return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

-- Adapted from:
-- https://github.com/nvim-lua/lsp-status.nvim/blob/db04eeacad0d32bd9a56c83ce33a8dbd2b0cb1f9/lua/lsp-status.lua#L1-L16
-- https://github.com/nvim-lua/lsp-status.nvim/blob/db04eeacad0d32bd9a56c83ce33a8dbd2b0cb1f9/lua/lsp-status/statusline.lua
-- Requires 'nvim-lua/lsp-status.nvim'
function M.lsp_status()
  local lsp_signs = {
    error = '', warning = '', info = '', hint = ''
  }

  local config = {
    kind_labels = {},
    current_function = false,
    diagnostics = false,
    indicator_separator = ' ',
    component_separator = ' ',
    indicator_errors = lsp_signs.error,
    indicator_warnings = lsp_signs.warning,
    indicator_info = lsp_signs.info,
    indicator_hint = lsp_signs.hint,
    indicator_ok = '',
    spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
    status_symbol = '',
    select_symbol = nil,
    update_interval = 100
  }
  local messages = require('lsp-status/messaging').messages
  local aliases = { pyls_ms = 'MPLS' }

  if #vim.lsp.buf_get_clients(vim.fn.bufnr()) == 0 then return '' end
  local buf_messages = messages()
  local only_hint = true
  local some_diagnostics = false
  local status_parts = {}
  local msgs = {}

  for _, msg in ipairs(buf_messages) do
    local name = aliases[msg.name] or msg.name
    local client_name = '[' .. name .. ']'
    local contents
    if msg.progress then
      contents = msg.title
      if msg.message then contents = contents .. ' ' .. msg.message end

      if msg.percentage then contents = contents .. string.format(" (%.0f%%))", msg.percentage) end

      if msg.spinner then
        contents = config.spinner_frames[(msg.spinner % #config.spinner_frames) + 1] .. ' ' ..
        contents
      end
    elseif msg.status then
      contents = msg.content
      if msg.uri then
        local filename = vim.uri_to_fname(msg.uri)
        filename = vim.fn.fnamemodify(filename, ':~:.')
        local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
        if #filename > space then filename = vim.fn.pathshorten(filename) end

        contents = '(' .. filename .. ') ' .. contents
      end
    else
      contents = msg.content
    end

    table.insert(msgs, client_name .. ' ' .. contents)
  end

  local base_status = vim.trim(table.concat(status_parts, config.component_separator) .. ' ' ..
  table.concat(msgs, config.component_separator))
  local symbol = config.status_symbol .. ((some_diagnostics and only_hint) and '' or ' ')
  if config.current_function then
    local current_function = vim.b.lsp_current_function
    if current_function and current_function ~= '' then
      symbol = symbol .. '(' .. current_function .. ')' .. config.component_separator
    end
  end

  if base_status ~= '' then return symbol .. base_status .. ' ' end
  if not config.diagnostics then
    if string.len(config.status_symbol) > 0 then
      return symbol
    end
    return ''
  end
  -- if not config.diagnostics then return '' end
  return symbol .. config.indicator_ok
end

function M.trail_whitespace()
  local trailspace_line = vim.fn.search([[\s$]], 'nw')
  return trailspace_line == 0 and '' or '␣ -> ' .. trailspace_line
end

-- Requires 'nvim-lua/lsp-status.nvim'
function M.lsp_current_function()
  local current_function = vim.b.lsp_current_function
  return string.len(current_function or '') > 0 and '  -> ' .. current_function or ''
end

-- https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878#file-evil_lualine-lua-L119-L134
function M.filesize()
  local function format_file_size(file)
    local size = vim.fn.getfsize(file)
    if size <= 0 then return '' end
    local sufixes = {'b', 'k', 'm', 'g'}
    local i = 1
    while size > 1024 do
      size = size / 1024
      i = i + 1
    end
    return string.format('%.1f%s', size, sufixes[i])
  end
  local file = vim.fn.expand('%:p')
  if string.len(file) == 0 then return '' end

  return format_file_size(file)
end

function M.indentation()
  local get_option = vim.api.nvim_buf_get_option
  local indentation_type = get_option(0, 'expandtab') and 'Spaces' or 'Tabs'
  local indentation_width = get_option(0, 'shiftwidth')
  return string.format('%s: %s', indentation_type, indentation_width)
end

function M.fileformat(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    show_icon = false,
    upper = false,
    icons = { unix = '', dos = '', mac = '' }
  })
  local format = vim.api.nvim_buf_get_option(0, 'fileformat')
  local icon = (opts.show_icon and opts.icons[format]) or ''
  format = opts.upper and string.upper(format) or format

  return (icon ~= '' and icon .. ' ' or '') .. format
end

function M.treesitter(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    message = {
      installed = 'TS ', not_installed = 'TS ', not_supported = ''
    }
  })

  local ts_parsers = require('nvim-treesitter.parsers')

  ts_parsers.reset_cache()

  local buf_nr = vim.api.nvim_get_current_buf()
  local buf_ft = vim.api.nvim_buf_get_option(buf_nr, 'filetype')
  local buf_lang = ts_parsers.ft_to_lang(buf_ft)

  local has_ts_support = ts_parsers.list[buf_lang] ~= nil
  local has_ts_parser_installed = ts_parsers.has_parser(buf_lang)

  if has_ts_support and has_ts_parser_installed then
    return opts.message.installed
  elseif has_ts_support and not has_ts_parser_installed then
    return opts.message.not_installed
  else
    return opts.message.not_supported
  end
end

-- https://github.com/glepnir/galaxyline.nvim/blob/505bd8a2912f75b3c9cc439db3bd31ae514230cd/lua/galaxyline/provider_lsp.lua#L2-L16
function M.lsp_client(opts)
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    message = {
      innactive = '',
      active = '%s',
    },
    blacklist = { emmet_ls = true }
  })

  local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return opts.no_clients
  end

  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if opts.blacklist[client.name] == nil then
        return string.format(opts.message.active, client.name)
      end
    end
  end

  return opts.message
end

return M
