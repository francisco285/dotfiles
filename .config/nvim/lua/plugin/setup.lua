local setup = {}

function setup.telescope()
  local util = require('autoload.util')

  _T = {}
  function _T.smart_find_file()
    if util.get_git_root(vim.fn.getcwd()) == '' then
      vim.cmd([[Telescope find_files results_title=false preview_title=false]])
    else
      vim.cmd([[Telescope git_files results_title=false preview_title=false]])
    end
  end
end

function setup.tcomment_vim()
  vim.g.tcomment_maps = 0
end

function setup.vim_maximizer()
  vim.g.maximizer_restore_on_winleave = 1
end

function setup.splitjoin()
  vim.g.splitjoin_join_mapping = ''
  vim.g.splitjoin_split_mapping = ''
end

function setup.nvim_compe()
  local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-n>'
    elseif check_back_space() then
      return t '<Tab>'
    else
      return vim.fn['compe#complete']()
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-p>'
    else
      return t '<S-Tab>'
    end
  end

  _G.c_j_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-n>'
    else
      return vim.fn['compe#complete']()
    end
  end

  _G.c_k_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-p>'
    else
      return t '<C-k>'
    end
  end
end

function setup.nvim_lspconfig()
  -- Using same icons as Visual Studio Code
  -- 1 - 'Codicon' font must be installed:
  -- https://github.com/microsoft/vscode-codicons/blob/master/dist/codicon.ttf
  -- 2 - 'Codicon' font must be configured as the default for non-ascii
  -- characters, to do it on kitty, add this line to your kitty.conf: 
  -- symbol_map U+EA60-U+EBBC codicon

  -- Reference: https://github.com/onsails/lspkind-nvim/issues/6

  -- Aditional reference (Visual Studio Code icons source):
  -- https://code.visualstudio.com/api/references/icons-in-labels
  require('vim.lsp.protocol').CompletionItemKind = {
    '  Text';          -- = 1
    '  Function';      -- = 2;
    '  Method';        -- = 3;
    '  Constructor';   -- = 4;
    '  Field';         -- = 5;
    '  Variable';      -- = 6;
    '  Class';         -- = 7;
    '  Interface';     -- = 8;
    '  Module';        -- = 9;
    '  Property';      -- = 10;
    '  Unit';          -- = 11;
    '  Value';         -- = 12;
    '  Enum';          -- = 13;
    '  Keyword';       -- = 14;
    '  Snippet';       -- = 15;
    '  Color';         -- = 16;
    '  File';          -- = 17;
    '  Reference';     -- = 18;
    '  Folder';        -- = 19;
    '  EnumMember';    -- = 20;
    '  Constant';      -- = 21;
    '  Struct';        -- = 22;
    '  Event';         -- = 23;
    '  Operator';      -- = 24;
    '  TypeParameter'; -- = 25;
  }
end

function setup.NrrwRgn()
  vim.g.nrrw_rgn_nomap_nr = 1
  vim.g.nrrw_rgn_nomap_Nr = 1
end

function setup.bracey()
  vim.g.bracey_browser_command = 'brave-browser'
end

return setup
