return {
  'neovim/nvim-lspconfig',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', 'gd', [[<Cmd>lua vim.lsp.buf.definition()<CR>]])
    map('n', 'gD', [[<Cmd>lua vim.lsp.buf.declaration()<CR>]])
    map('n', 'gi', [[<Cmd>lua vim.lsp.buf.implementation()<CR>]])
    map('n', 'gy', [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]])
    map('n', '<Leader>wa', [[<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]])
    map('n', '<Leader>wr', [[<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]])
    map('n', '<Leader>wl', [[<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]])
    map('n', '<Leader>ws', [[<Cmd>lua vim.lsp.buf.workspace_symbol(vim.fn.input('Symbol ❯ '))<CR>]])
    map('n', 'gr', [[<Cmd>lua vim.lsp.buf.references()<CR>]])
    map('n', '<Leader>L', [[<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]])

    map('n', '<Leader>f', [[<Cmd>lua vim.lsp.buf.formatting()<CR>]])
    map('x', '<Leader>f', [[<Cmd>lua vim.lsp.buf.range_formatting()<CR>]])

    map('n', '<Leader>li', [[<Cmd>LspInfo<CR>]])
    map('n', '<Leader>ll', [[<Cmd>LspLog<CR>]])
    map('n', '<Leader>lr', [[<Cmd>LspRestart<CR>]])
    map('n', '<Leader>ls', [[<Cmd>LspStop<CR>]])
    map('n', '<Leader>lS', [[<Cmd>LspStart<CR>]])

    local lspsaga = packer_plugins['lspsaga.nvim']
    if not lspsaga or not lspsaga.loaded then
      -- Also implemented by lspsaga
      map('n', '<Leader>j', [[<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>]])
      map('n', '<Leader>k', [[<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]])
      map('n', 'K', [[<Cmd>lua vim.lsp.buf.hover()<CR>]])
      map('n', '<Leader>a', [[<Cmd>lua vim.lsp.buf.code_action()<CR>]])
      map('x', '<Leader>a', [[<Cmd>vim.lsp.buf.range_code_action()<CR>]])
      map('i', '<C-]>', [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]])
      map('n', '<Leader>r', [[<Cmd>lua vim.lsp.buf.rename()<CR>]])
      map('n', '<Leader>d', [[<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])
    end
  end,
  config = function()
    local util = require('autoload.util')
    local lspconfig = require('lspconfig')

    -- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- NOTE: it looks like there's actually a difference between using
    -- 'lspconfig/configs' and using 'lspconfig.configs' here, it only works when
    -- a / is used
    if not lspconfig.emmet_ls then
      require('lspconfig/configs').emmet_ls = {
        default_config = {
          cmd = { 'emmet-ls', '--stdio' },
          filetypes = { 'html', 'css' },
          root_dir = function()
            return vim.loop.cwd()
          end,
          settings = {}
        }
      }
    end

    -- List of included LSP configs:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    local configs = O.lsp.configs

    local function document_highlight(client, bufnr)
      if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        highlight! link LspReferenceRead Pmenu
        highlight! link LspReferenceText Pmenu
        highlight! link LspReferenceWrite Pmenu

        " TODO: Find a way to adapt this to use require('autoload.util').set_augroup
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
      end
    end

    local lsp_status_ok, lsp_status = pcall(require, 'lsp-status')
    if lsp_status_ok then lsp_status.register_progress() end

    local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')

    local on_attach = function(client, bufnr)
      document_highlight(client, bufnr)

      -- WARN: using `vim.wo` or `vim.opt_local` here leads to: https://github.com/neovim/neovim/issues/14670
      vim.cmd([[setlocal signcolumn=yes]])

      if lsp_status_ok then lsp_status.on_attach(client, bufnr) end
      if lsp_signature_ok then
        lsp_signature.on_attach({
          hint_enable = false,
          use_lspsaga = true
        })
      end

      local function show_diagnostics_on_hover()
        local lspsaga = packer_plugins['lspsaga.nvim']
        local cmd
        if lspsaga then
          if not lspsaga.loaded then require('packer').loader('lspsaga.nvim') end
          cmd = 'Lspsaga show_line_diagnostics'
        else
          cmd = 'lua vim.lsp.diagnostic.show_line_diagnostics()'
        end
        vim.api.nvim_exec(string.format([[
        augroup show_diagnostics_on_hover
          autocmd! * <buffer>
          autocmd CursorHold <buffer> %s
        augroup END
        ]], cmd), false)
      end

      show_diagnostics_on_hover()
    end

    if packer_plugins['nvim-lspinstall'] then
      local function setup_servers()
        local lspinstall = require('lspinstall')

        lspinstall.setup()
        local servers = lspinstall.installed_servers()

        for server, _ in pairs(configs) do
          table.insert(servers, server)
        end

        for _, server in pairs(servers) do
          local server_config = configs[server] or {}

          server_config = vim.tbl_extend('force', server_config, {
            on_attach = on_attach,
            capabilities = vim.tbl_extend('keep', configs[server] or {}, lsp_status.capabilities or {}),
          })

          if lspconfig[server].setup then
            lspconfig[server].setup(server_config)
          else
            vim.api.nvim_err_writeln(string.format([[lspconfig['%s'].setup() failed!]], server))
          end
        end
      end

      setup_servers()

      -- FIXME: This isn't actually working, currently we need to restart Neovim
      -- after installing something with `:LspInstall`.
      -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
      require('lspinstall').post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
      end
    else
      for server, server_config in pairs(configs) do
        server_config.on_attach = server_config.on_attach or on_attach
        server_config.capabilities = server_config.capabilities or capabilities

        lspconfig[server].setup(server_config)
      end
    end

    function _G.reload_lsp()
      vim.lsp.stop_client(vim.lsp.get_active_clients())
      vim.cmd([[edit]])
    end

    function _G.open_lsp_log()
      local path = vim.lsp.get_log_path()
      vim.cmd('edit ' .. path)
    end

    vim.cmd([[command! -nargs=0 LspLog call v:lua.open_lsp_log()]])
    vim.cmd([[command! -nargs=0 LspRestart call v:lua.reload_lsp()]])

    local lsp_signs = O.lsp.signs
    vim.fn.sign_define('LspDiagnosticsSignError', { texthl = 'LspDiagnosticsSignError', text = lsp_signs.error, numhl = 'LspDiagnosticsSignError' })
    vim.fn.sign_define('LspDiagnosticsSignWarning', { texthl = 'LspDiagnosticsSignWarning', text = lsp_signs.warning, numhl = 'LspDiagnosticsSignWarning' })
    vim.fn.sign_define('LspDiagnosticsSignInformation', { texthl = 'LspDiagnosticsSignInformation', text = lsp_signs.info, numhl = 'LspDiagnosticsSignInformation' })
    vim.fn.sign_define('LspDiagnosticsSignHint', { texthl = 'LspDiagnosticsSignHint', text = lsp_signs.hint, numhl = 'LspDiagnosticsSignHint' })

    -- TODO: Make it so only one sign is shown on signcolumn even if there's more than one diagnostic at the line
    -- The default behvaior is to show (for instance) two warning signs if
    -- there are two warnings at the line.

    -- :help vim.lsp.diagnostic.on_publish_diagnostics()
    -- https://github.com/nvim-lua/diagnostic-nvim/issues/73
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, O.lsp.diagnostic.on_publish_diagnostics
    )

    local map_strings = {
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>quit<CR>', {})]]
    }

    local augroup_table = {}
    for _, map in ipairs(map_strings) do
      table.insert(augroup_table, { 'FileType', 'lspinfo', map })
    end

    util.set_augroup('lspinfo_buf_maps', augroup_table)
  end,
  opt = false
}
