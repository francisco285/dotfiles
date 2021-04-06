local util = require('autoload.util')
local fn = vim.fn

-- TODO: It looks like vim.fn.expand() can be used to get a directory
-- independently of the OS, maybe it's better to use that instead.
local function get_undodir()
  local is_windows = jit.os == "Windows"
  local separator = is_windows and "\\" or [[/]]
  local undodir = table.concat({ os.getenv("HOME"), ".cache", "nvim", "undo" }, separator)

  return undodir
end

local undodir = get_undodir()

local function create_undodir()
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
  end
end

create_undodir()

local options = {
  background = 'dark',
  backup = false,
  belloff = 'all',
  clipboard = 'unnamed,unnamedplus',
  cmdheight = 1,
  cmdwinheight = 10,
  colorcolumn = '80',
  completeopt = 'menuone,noselect',
  confirm = true,
  cursorline = true,
  expandtab = true,
  fillchars = [[vert:│,eob:\ ,foldsep:\ ,foldopen:▼,foldclose:▶]],
  foldmethod = 'marker',
  foldenable = true,
  foldlevelstart = 99,
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  inccommand = 'nosplit',
  joinspaces = false,
  langmenu = 'en_US-UTF-8',
  lazyredraw = false,
  list = true,
  listchars = 'tab:>·,eol:⏎,nbsp:+,trail:␣,extends:→,precedes:←',
  mouse = 'a',
  number = true,
  pumblend = 20,
  pumheight = 15,
  relativenumber = true,
  report = 0,
  ruler = false,
  scrolloff = 8,
  selection = 'exclusive',
  shiftwidth = 2,
  shortmess = 'filmnrwxoOtcF',
  showbreak = '↳',
  showmode = true,
  showtabline = 2,
  sidescrolloff = 5,
  signcolumn = 'yes',
  smartindent = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  textwidth = 80,
  timeout = true,
  timeoutlen = 500,
  undodir = undodir,
  undofile = true,
  updatetime = 100,
  virtualedit = 'block',
  wildcharm = '<Tab>',
  wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,*.DS_Store,**/node_modules/**,**/bower_modules/**',
  wildignorecase = true,
  winblend = 20,
  wrap = false,
  writebackup = false
}

local function set_option(option, value)
  if value == true then
    vim.cmd('set ' .. option)
  elseif value == false then
    vim.cmd('set no' .. option)
  else
    vim.cmd('set ' .. option .. '=' .. value)
  end
end

for option, value in pairs(options) do
  set_option(option, value)
end

util.set_augroup('set_formatoptions', { { 'BufEnter', '*', [[lua vim.bo.formatoptions = 'cqrj']] } })
