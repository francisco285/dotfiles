-- Alternative: 'tiagovla/tokyodark.nvim'
return {
  'folke/tokyonight.nvim',
  config = function()
    vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_italic_keywords = false
    vim.g.tokyonight_colors = { bg = '#0F111A' }
    vim.g.tokyonight_dark_sidebar = false
    vim.g.tokyonight_dark_float = false
    -- if O.colorscheme == 'tokyonight' then
    --   vim.cmd([[colorscheme tokyonight]])
    -- end
  end
}
