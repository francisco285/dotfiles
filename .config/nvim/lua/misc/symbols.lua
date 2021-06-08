-- Alternative symbols
-- This is only meant to be used as a convenient way to get other symbols, not
-- to be used directly (e.g. by using require('symbols'))
local symbols = {
  lsp = {
    diagnostics = {
      error = { '', '', '', '', '✗', '✘', '' }, warning = { '', '' }, info = { '', '', '' }, hint = { '', '', '💡', '', '🔧', '🛠️' }
    },
    completion_kinds = {
      -- Using same icons as Visual Studio Code
      -- 1 - 'Codicon' font must be installed:
      -- https://github.com/microsoft/vscode-codicons/blob/master/dist/codicon.ttf
      -- 2 - 'Codicon' font must be configured as the default for non-ascii
      -- characters, to do it on kitty, add this line to your kitty.conf:
      -- symbol_map U+EA60-U+EBBC codicon
      -- 3 - Use `require('vim.lsp.protocol').CompletionItemKind = kinds` with
      -- `kinds` being this table

      -- Reference: https://github.com/onsails/lspkind-nvim/issues/6

      -- Aditional reference (Visual Studio Code icons source):
      -- https://code.visualstudio.com/api/references/icons-in-labels
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
    },
  },
  vcs = { '', '', '⎇', 'ᚠ', '', '' },
  diff = {
    added = { '+', '', '' },
    modified = { '~', '', '柳' },
    removed = { '-', '', '' }
  },
  statusline = {
    no_separators = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    thin = {
      section_separators = { left = '│', right = '│' },
      component_separators = { left = '│', right = '│' }
    },
    round = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    powerline = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    slant_up = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    },
    slant_down = {
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' }
    }
  },
  os = {
    dos = '',
    unix = '',
    mac = ''
  },
  misc = {
    unnamed = { '⚡', '⊝', '✦', '', '┣', '┫', '', 'ஃ' },
    percentage = '',
    vertical_bar = '▍',
    letter_l = { 'ℒ',  'ℓ' },
    fold = '',
    quotes = { '' },
    dash = { '━', '' },
    telescope = '🔭',
    search = { '🔎', '🔍' },
    page = { '☲', '☰', '' },
    plus = '✚',
    plus_minus = '±',
    dot = { '●', '•' },
    square = '■',
    ok = { '', '✔', '✓', '﫠' },
    arrow_up = { '⇡', '↑' },
    arrow_right = { '➜', '➦', '❯', '➤', '', '', '▶' },
    arrow_left = '❮',
    arrow_down = { '⇣' , '↓', '', '', '▼' },
    ghost = '',
    settings = { '', '⚙', '⚙️' },
    skull = '💀',
    rocket = '🚀',
    not_exists = 'Ɇ',
    elipses = '…',
    clock = '',
    tools = '🛠',
    package = '📦',
    question_mark = '',
    flame = '',
    vim = '',
    paste = '',
    locker = { '', '', '🔒' },
    treesitter = { '🌳', '🌈' },
    folder = '',
    unsaved = { '', '', '', '' },
    line_number = '',
    column_number = '',
    connected = '',
    disconnected = ''
  }
}

return symbols
