return {
  'nvim-telescope/telescope.nvim',
  setup = function()
    local util = require('autoload.util')

    function _G.telescope_project_files()
      if util.get_git_root(vim.fn.getcwd()) == '' then
        vim.cmd([[Telescope find_files results_title=false preview_title=false]])
      else
        vim.cmd([[Telescope git_files results_title=false preview_title=false]])
      end
    end

    local map = require('autoload.util').set_map
    map('n', '<M-;><M-;>', [[<Cmd>Telescope builtin previewer=false theme=get_dropdown<CR>]])
    map('n', '<M-;>:', [[<Cmd>Telescope commands theme=get_dropdown<CR>]])
    map('n', '<M-;>"', [[<Cmd>Telescope registers theme=get_dropdown<CR>]])
    map('n', '<M-;>/', [[<Cmd>Telescope current_buffer_fuzzy_find results_title=false preview_title=false<CR>]])
    map('n', '<M-;>o', [[<Cmd>Telescope vim_options theme=get_dropdown<CR>]])
    map('n', '<M-;>c', [[<Cmd>Telescope colorscheme theme=get_dropdown<CR>]])
    map('n', '<M-;>m', [[<Cmd>Telescope marks results_title=false preview_title=false<CR>]])
    map('n', '<M-;>gc', [[<Cmd>Telescope git_commits results_title=false preview_title=false<CR>]])
    map('n', '<M-;>gfc', [[<Cmd>Telescope git_bcommits results_title=false preview_title=false<CR>]])
    map('n', '<M-;>gb', [[<Cmd>Telescope git_branches previewer=false theme=get_dropdown<CR>]])
    map('n', '<M-;>gs', [[<Cmd>Telescope git_status results_title=false preview_title=false<CR>]])
    map('n', '<M-;>s', [[<Cmd>execute 'Telescope grep_string results_title=false preview_title=false search=' . input('Grep ❯ ')<CR>]])
    map('n', '<M-;>S', [[<Cmd>Telescope live_grep results_title=false preview_title=false<CR>]])
    map('n', '<M-;>b', [[<Cmd>Telescope buffers results_title=false preview_title=false<CR>]])
    map('n', '<M-;>h', [[<Cmd>Telescope oldfiles results_title=false preview_title=false<CR>]])
    map('n', '<M-;>H', [[<Cmd>Telescope help_tags results_title=false preview_title=false<CR>]])
    map('n', '<M-;>q', [[<Cmd>Telescope quickfix results_title=false preview_title=false<CR>]])
    map('n', '<M-;>l', [[<Cmd>Telescope loclist results_title=false preview_title=false<CR>]])
    map('n', '<M-;>f', [[<Cmd>execute 'Telescope find_files results_title=false preview_title=false cwd=' . expand('%:p:h')<CR>]])
    map('n', '<M-;>F', [[<Cmd>Telescope file_browser results_title=false preview_title=false<CR>]])
    map('c', '<M-s>', [[<C-u><Cmd>Telescope commands<CR><CR>]])
    map('c', '<M-H>', [[<C-u><Cmd>Telescope command_history<CR><CR>]])
    map('n', { '<M-;>p', '<C-p>' }, [[<Cmd>lua _G.telescope_project_files()<CR>]])

    map('n', '<M-;>r', [[<Cmd>Telescope lsp_references<CR>]])
    map('n', '<M-;>gd', [[<Cmd>Telescope lsp_definitions<CR>]])
    map('n', '<M-;>dd', [[<Cmd>Telescope lsp_document_diagnostics<CR>]])
    map('n', '<M-;>ds', [[<Cmd>Telescope lsp_document_symbols<CR>]])
    map('n', '<M-;>wd', [[<Cmd>Telescope lsp_workspace_diagnostics<CR>]])
    map('n', '<M-;>ws', [[<Cmd>Telescope lsp_workspace_symbols<CR>]])
    map('n', '<M-;>a', [[<Cmd>Telescope lsp_code_actions<CR>]])
    map('x', '<M-;>ra', [[<Cmd>Telescope lsp_range_code_actions<CR>]])

    map('n', '<M-;>T', '<Cmd>lua _G.telescope_sonictemplate()<CR>', {})
  end,
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')
    local pickers = require('telescope.pickers')

    local trouble, open_with_trouble

    if packer_plugins['trouble.nvim'] then
      trouble = require('trouble.providers.telescope')
      open_with_trouble = trouble.open_with_trouble
    end

    local function load_extension(plugin_name, extension_name)
      local plugin = packer_plugins[plugin_name]
      if plugin then
        if not plugin.loaded then
          require('packer').loader(plugin_name)
        end
        telescope.load_extension(extension_name)
      end
    end

    load_extension('telescope-asynctasks.nvim', 'asynctasks')
    load_extension('telescope-fzy-native.nvim', 'fzy_native')

    local set_augroup = require('autoload.util').set_augroup

    set_augroup('Telescope', {
      { 'User', 'TelescopePreviewerLoaded', 'lua vim.wo.wrap, vim.wo.number = true, true' }
    })

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        prompt_prefix = '🔍 ',
        selection_caret = '❯ ',
        prompt_position = 'top',
        -- winblend = 20,
        preview_cutoff = 0,
        width = 0.8,
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        borderchars = (function()
          local style = O.ui.floating.border_chars.style
          local b = O.ui.floating.border_chars.styles[style]
          return {
            b.top, b.right, b.bottom, b.left, b.top_left, b.top_right, b.bottom_right, b.bottom_left
          }
        end)(),
        scroll_strategy = 'cycle',
        color_devicons = true,
        file_sorter = sorters.get_fzy_sorter,
        layout_defaults = {
          horizontal = {
            preview_width = 0.6,
            width_padding = 0.08,
          },
          vertical = {
            preview_height = 0.4,
            width_padding = 0.08,
          }
        },
        mappings = {
          i = {
            ['<M-j>'] = actions.move_selection_next,
            ['<M-k>'] = actions.move_selection_previous,
            ['<C-x>'] = false,
            ['<M-s>'] = actions.select_horizontal,
            ['<M-v>'] = actions.select_vertical,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.smart_send_to_qflist + actions.open_qflist,

            ['<C-t>'] = open_with_trouble
          },
          n = {
            ['<M-j>'] = actions.move_selection_next,
            ['<M-k>'] = actions.move_selection_previous,
            ['<C-x>'] = false,
            ['<M-s>'] = actions.select_horizontal,
            ['<M-v>'] = actions.select_vertical,
            ['q'] = actions.close,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['<M-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,

            ['<C-t>'] = open_with_trouble
          }
        }
      },
      extensions = {
        fzy_native = (function()
          if telescope.extensions['fzy_native'] then
            local opts = {
              override_generic_sorter = true,
              override_file_sorter = true
            }
            return opts
          end
        end)()
      }
    })

    function _G.telescope_sonictemplate(opts)
      opts = opts or {}

      local templates = vim.fn['sonictemplate#complete']('', '', 0)

      if vim.tbl_isempty(templates) then
        local filename = vim.fn.fnamemodify(vim.fn.bufname(), ':t')
        vim.api.nvim_err_writeln('No template avaiable for ' .. filename)
        return
      end

      pickers.new(opts, {
        prompt_title = 'Templates',
        finder = finders.new_table({
          results = templates
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
          local start_template = function()
            local selection = actions.get_selected_entry(prompt_bufnr)
            actions.close(prompt_bufnr)

            local template_name = templates[selection.index]

            vim.cmd('Template ' .. template_name)
          end

          map('i', '<CR>', start_template)
          map('n', '<CR>', start_template)

          return true
        end
      }):find()
    end
  end,
  requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }
}
