return {
  'tomtom/tcomment_vim',
  event = 'BufRead *',
  setup = function()
    vim.g.tcomment_maps = 0

    local map = require('autoload.util').set_map
    -- Default gc maps
    map('n', 'gc', '<Plug>TComment_gc', { silent = true })

    for i = 1, 9 do
      map('n', 'gc' .. i, '<Plug>TComment_gc' .. i, { silent = true })
      map('n', 'gc' .. i .. 'c', '<Plug>TComment_gc' .. i .. 'c', { silent = true })
    end

    map('n', 'gcc', '<Plug>TComment_gcc', { silent = true })
    map('n', 'gcb', '<Plug>TComment_gcb', { silent = true })
    map('x', 'gcc', '<Plug>TComment_gc', { silent = true })

    -- Force uncomment
    map({ 'n', 'x' }, 'gc<', '<Plug>TComment_Uncomment', { silent = true })
    map('n', { 'gc<c', 'gc<<' }, '<Plug>TComment_Uncommentc', { silent = true })
    map('n', 'gc<b', '<Plug>TComment_Uncommentb', { silent = true })

    -- Force comment
    map({ 'n', 'x' }, 'gc>', '<Plug>TComment_Comment', { silent = true })
    map('n', { 'gc>c', 'gc>>' }, '<Plug>TComment_Commentc', { silent = true })
    map('n', 'gc>b', '<Plug>TComment_Commentb', { silent = true })
  end
}

