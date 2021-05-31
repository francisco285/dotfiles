local util = require('autoload.util')

---@param option string
---@param value any
---return nil
local function set_option(option, value)
  if value == true then
    vim.cmd('set ' .. option)
  elseif value == false then
    vim.cmd('set no' .. option)
  else
    vim.cmd(string.format('set %s=%s', option, value))
  end
end

for option, value in pairs(O.vim_options) do
  set_option(option, value)
end

---@param option string
--return string
local function get_option_scope(option)
  local scope = vim.api.nvim_get_option_info(option).scope

  if scope == 'win' then
    return 'wo'
  elseif scope == 'buf' then
    return 'bo'
  elseif scope == 'global' then
    return 'o'
  end
end

---@param option string
---@param restore boolean
---return nil
function _G.update_local_option(option, restore)
  if vim.b[option] == nil then return end

  local value
  local scope = get_option_scope(option)

  if not restore then
    value = vim.b[option]['local_value']
    vim.b[option]['global_value'] = vim[scope][option]
  else
    value = vim.b[option]['global_value']
  end

  if value == true then
    vim.cmd('set ' .. option)
  elseif value == false then
    vim.cmd('set no' .. option)
  else
    vim.cmd(string.format('set %s=%s', option, value))
  end
end

---@param option string
---@param value any
---return nil
function _G.set_local_option(option, value)
  local scope = get_option_scope(option)

  if scope == 'o' then
    if vim.b[option] == nil then
      vim.b[option] = {
        local_value = value,
        global_value = vim[scope][option]
      }
    end

    _G.update_local_option(option, false)

    util.set_augroup(option .. '_local_value', {
      { 'WinEnter,BufWinEnter,BufEnter', '<buffer>', string.format('lua _G.update_local_option("%s", false)', option) },
      { 'WinLeave,BufWinLeave,BufLeave', '<buffer>', string.format('lua _G.update_local_option("%s", true)', option) }
    })
  else
    if value == true then
      vim.cmd('setlocal ' .. option)
    elseif value == false then
      vim.cmd('setlocal no' .. option)
    else
      vim.cmd(string.format('setlocal %s=%s', option, value))
    end
  end
end

local function define_filetype_options(filetype_options)
  local autocmd_table = {}
  for option, definitions in pairs(filetype_options) do
    for _, definition in ipairs(definitions) do
      local command
      local value = definition.value
      if type(value) == type('') then
        command = string.format([[lua _G.set_local_option("%s", "%s")]], option, value)
      else
        command = string.format([[lua _G.set_local_option("%s", %s)]], option, value)
      end
      table.insert(autocmd_table, { 'Filetype', table.concat(definition.filetypes, ','), command })
    end
  end
  util.set_augroup('filetype_options', autocmd_table)
end

define_filetype_options(O.filetype_options)

util.set_augroups({
  set_formatoptions = {
    { 'BufEnter', '*', [[lua vim.bo.formatoptions = 'cqrj']] }
  },
  -- https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/97f2a3c7e9ab769686a5f29109bd1a297c7461e1/plugin/number_toggle.vim#L5-L9
  numbertoggle = {
    { 'BufEnter,FocusGained,InsertLeave,WinEnter', '*', 'if &nu && mode() != "i" | set rnu   | endif' },
    { 'BufLeave,FocusLost,InsertEnter,WinLeave',   '*', 'if &nu                  | set nornu | endif' }
  }
})
