local util = require('autoload.util')
local fn = vim.fn

local function bootstrap()
  local cmd = vim.api.nvim_command
  local install_path = fn.expand(fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim')

  if fn.empty(fn.glob(install_path)) > 0 then
    local packer_compiled_path = fn.expand(fn.stdpath('config') .. '/plugin/packer_compiled.vim')
    if fn.empty(fn.glob(packer_compiled_path)) == 0 then
      local prompt = table.concat({
        'Compiled file found in ' .. packer_compiled_path .. '\n',
        'Remove it before bootstrapping [Press ENTER]',
      })

      vim.cmd([[echohl WarningMsg]])
      fn.input({ prompt = prompt })
      vim.cmd([[echohl None]])
      vim.cmd([[quitall!]])
    end
    -- local packer_compiled_path = fn.empty(fn.glob(install_path)) > 0

    cmd('silent !git clone https://github.com/wbthomason/packer.nvim ' .. install_path)

    function _G.post_sync_hook()
      require('packer.display').quit()
      vim.cmd('silent! PackerCompile')

      local prompt = table.concat({
        'Installation Finished. You may be able to use the editor now,',
        'but it is recommended to restart Neovim in order to avoid bugs',
        '[Press ENTER]',
      }, ' ')

      vim.cmd([[echohl WarningMsg]])
      fn.input({ prompt = prompt })
      vim.cmd([[echohl None]])
    end

    util.set_augroup('bootstrap', {
      { 'VimEnter', '*', '++once', [[echo 'Installing plugins...' | silent! PackerSync]] },
      { 'User', 'PackerComplete', '++once', '++nested', [[lua _G.post_sync_hook()]] }
    })
  end

  cmd([[packadd packer.nvim]])
end

bootstrap()

local function setup()
  local style = O.ui.floating.border_chars.style
  local b = O.ui.floating.border_chars.styles[style]
  local border = {
    b.top_left, b.top, b.top_right, b.right, b.bottom_right, b.bottom, b.bottom_left, b.left
  }

  local display = {}

  local display_style = O.ui.packer_display_style

  if display_style == 'tab' then
    -- Make it so packer is open in a new tab
    display.open_cmd = 'tabnew [packer]'
  elseif display_style == 'floating' then
    -- Make it so packer is open in a floating window
    -- NOTE: It'll mess up the layout if some post-install hook opens a window
    display.open_fn = function()
      return require('packer.util').float({ border = border })
    end
  end

  require('packer').init({
    display = display,
    git = {
      clone_timeout = false
    },
    prompt_border = border
  })

  -- For some reason, when using packer in a floating window, packer will set
  -- `winhighlight` to 'EndOfBuffer:' and it will make its background look
  -- weird
  util.set_augroup('packer_background', {
    { 'FileType', 'packer', 'setlocal winhighlight=Normal:NormalNC' }
  })
end

setup()

require('packer').startup(
function(use)
  for _, plugin in pairs(O.enable_plugins) do
    local ok, plugin_table = pcall(require, string.format('plugin.%s', plugin))
    if ok then
      use(plugin_table)
    else
      local error = plugin_table
      local warning_message = string.format("Error while loading plugin %s, use `:echo g:plugin_errors['%s']` to see the error message", plugin, plugin)

      vim.g.plugin_errors = vim.tbl_extend('force', vim.g.plugin_errors or {}, {
        [plugin] = error
      })

      vim.api.nvim_err_writeln(warning_message)
    end
  end
end
)
