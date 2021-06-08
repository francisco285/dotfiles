return {
  'hoob3rt/lualine.nvim',
  config = function()
    local statusline = O.statusline
    local theme = statusline.colorscheme
    local style = statusline.styles[statusline.style]
    local section_separators = { style.section_separators.left, style.section_separators.right }
    local component_separators = { style.component_separators.left, style.component_separators.right }

    local sl_functions = require('autoload.statusline')

    local lsp_signs = O.lsp.signs

    require('lualine').setup({
      options = {
        theme = theme,
        section_separators = section_separators,
        component_separators = component_separators,
        icons_enabled = true
      },
      sections = {
        lualine_a = {
          { require('autoload.statusline').cwd_head }
        },
        lualine_b = {
          { 'branch', icon = '' },
          {
            'diff',
            color_added = '#00FF00',
            color_modified = '#FFA500',
            color_removed = '#FF0000',
            symbols = {
              added = ' ', modified = '柳', removed = ' '
            }
          }
        },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = { error = lsp_signs.error .. ' ', warn = lsp_signs.warning .. ' ', info = lsp_signs.info .. ' ', hint = lsp_signs.hint .. ' ' },
            color_error = '#F00000',
            color_warn = '#FFA500',
            color_info = '#ADD8E6'
          },
          require('autoload.statusline').lsp_current_function
        },
        lualine_x = {
          { 'o:encoding', upper = true },
          function()
            -- Default fileformat component doesn't allow one to show both icon and text
            return require('autoload.statusline').fileformat({ show_icon = true, upper = true })
          end,
          'filetype',
          require('autoload.statusline').indentation,
          function()
            return require('autoload.statusline').treesitter({
              message = {
                installed = '🌳 TS ',
                not_installed = '🌳 TS 💡',
                not_supported = '🌳 TS '
              }
            })
          end
        },
        lualine_y = {
          sl_functions.lsp_client
        },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = { },
        lualine_c = { },
        lualine_x = { },
        lualine_y = { },
        lualine_z = { 'location' }
      },
      extensions = { 'fugitive', 'nvim-tree', 'quickfix' }
    })
  end,
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
