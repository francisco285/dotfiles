return {
  'hrsh7th/nvim-compe',
  event = 'InsertEnter *',
  setup = function()
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

    local map = require('autoload.util').set_map
    map('i', '<C-Space>', [[compe#complete()]], { silent = true, expr = true })
    map('i', '<CR>', [[compe#confirm('<CR>')]], { silent = true, expr = true })

    map('i', '<C-e>', [[pumvisible() ? compe#close('<C-e>') : "<C-e>"]], { silent = true, expr = true })
    map('i', '<C-f>', [[compe#scroll({ 'delta': +4 })]], { silent = true, expr = true })
    map('i', '<C-d>', [[compe#scroll({ 'delta': -4 })]], { silent = true, expr = true })

    map('i', '<Tab>', [[v:lua.tab_complete()]], { expr = true })
    map('i', '<S-Tab>', [[v:lua.s_tab_complete()]], { expr = true })

    map('i', '<C-j>', [[v:lua.c_j_complete()]], { expr = true })
    map('i', '<C-k>', [[v:lua.c_k_complete()]], { expr = true })
  end,
  config = function()
    require('compe').setup({
      enabled = true,
      debug = false,
      min_length = 1,
      preselect = 'disable',
      allow_prefix_unmatch = false,
      max_abbr_width = 50,
      max_kind_width = 50,
      max_menu_width = 50,
      source = {
        -- Common: ~
        -- path = { kind = '' },
        path   = true,  -- Path completion.
        buffer = true,  -- Buffer completion.
        tags   = true,  -- Tag completion.
        spell  = true,  -- Spell file completion.
        calc   = true,  -- Lua math expressions.
        omni   = false, -- Omni completion. (Warning: It has a lot of side-effect.)
        emoji  = true,  -- Emoji completion.

        -- Neovim-specific: ~
        nvim_lsp = true, -- Neovim's builtin LSP completion.
        nvim_lua = true, -- Neovim's Lua "stdlib" completion.

        -- External plugins: ~
        -- Completion for external plugins.
        -- Make sure you have the corresponding plugin installed.
        vim_lsp         = false, -- vim-lsp completion.
        vim_lsc         = false, -- vim-lsc completion.
        vsnip           = false,  -- vim-vsnip completion.
        ultisnips       = true, -- UltiSnips completion.
        snippets_nvim   = false, -- snippets.nvim completion.
        nvim_treesitter = true   -- nvim-treesitter completion.
      }
    })
  end
}
