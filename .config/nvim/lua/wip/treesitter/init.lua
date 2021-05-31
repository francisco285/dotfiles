local M = {}

local ts_utils = require'nvim-treesitter.ts_utils'

-- https://www.reddit.com/r/neovim/comments/nnru7r/how_do_i_get_the_name_of_the_current_function_i/
function _G.get_current_function_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local expr = current_node

  -- while expr do
  --   if expr:type() == 'function_definition' then
  --     break
  --   end
  --   expr = expr:parent()
  -- end

  if not expr then
    return ""
  end

  return (expr:type() or 'N/A') .. ' --> ' .. ((ts_utils.get_node_text(expr:child(1)))[1] or 'N/A')
end

return M
