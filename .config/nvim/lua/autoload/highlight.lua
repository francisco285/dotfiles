local M = {}

function M.is_linked(group)
  local output = vim.fn.split(vim.fn.execute('highlight ' .. group), ' ')

  for i, v in ipairs(output) do
    if v == 'links' then
      -- We need to check if next word is 'to' in case there's a highlight
      -- named 'links', because the ouput would be something like:
      -- links          xxx guibg=red
      -- And it would return `true` incorrectly
      if output[i + 1] == 'to' then
        return true
      end
    end
  end

  return false
end

function M.clear_bg(group)
  vim.cmd(string.format('highlight %s ctermbg=NONE guibg=NONE', group))
end

function M.link(group, with_group, bang)
  vim.cmd(string.format('highlight%s link %s %s', bang and '!' or '', group, with_group))
end

function M.set_custom_highlight_groups()
  local clear_bg = {
    'FoldColumn', 'SignColumn', 'LineNr', 'CursorLineNr', 'EndOfBuffer',
    'LspDiagnosticsVirtualTextError', 'LspDiagnosticsVirtualTextHint',
    'LspDiagnosticsVirtualTextInformation', 'LspDiagnosticsVirtualTextWarning'
  }
  local link = {
    { 'Folded', 'Comment' }, { 'VertSplit', 'Comment' },
    { 'ModeMsg', 'CursorLineNr' }, { 'NormalFloat', 'Normal' }
  }

  for _, group in ipairs(clear_bg) do
    -- When the highlight group is linked to other highlight group, trying to
    -- change only a specific key doesn't work well, it will clear all other
    -- keys, which is not the expected behavior.
    if not M.is_linked(group) then
      M.clear_bg(group)
    end
  end

  for _, groups in pairs(link) do
    M.link(groups[1], groups[2], true)
  end

  vim.cmd([[highlight MatchParen gui=reverse]])
end

return M
