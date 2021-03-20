local set_map = require('autoload.util').set_map
local map = {}

function map.telescope()
  set_map('n', '<M-;><M-;>', [[<Cmd>Telescope builtin previewer=false theme=get_dropdown<CR>]])
  set_map('n', '<M-;>:', [[<Cmd>Telescope commands theme=get_dropdown<CR>]])
  set_map('n', '<M-;>/', [[<Cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<CR>]])
  set_map('n', '<M-;>gc', [[<Cmd>Telescope git_commits results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>gfc', [[<Cmd>Telescope git_bcommits results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>gb', [[<Cmd>Telescope git_branches previewer=false theme=get_dropdown<CR>]])
  set_map('n', '<M-;>gs', [[<Cmd>Telescope git_status results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>s', [[<Cmd>execute 'Telescope grep_string results_title=false preview_title=false search=' . input('Grep ❯ ')<CR>]])
  set_map('n', '<M-;>S', [[<Cmd>Telescope live_grep results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>b', [[<Cmd>Telescope buffers results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>h', [[<Cmd>Telescope oldfiles results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>H', [[<Cmd>Telescope help_tags results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>q', [[<Cmd>Telescope quickfix results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>l', [[<Cmd>Telescope loclist results_title=false preview_title=false<CR>]])
  set_map('n', '<M-;>f', [[<Cmd>execute 'Telescope find_files results_title=false preview_title=false cwd=' . expand('%:p:h')<CR>]])
  set_map('n', '<M-;>F', [[<Cmd>Telescope file_browser results_title=false preview_title=false<CR>]])
  set_map('c', '<M-s>', [[<C-u><Cmd>Telescope commands<CR><CR>]])
  set_map('c', '<M-h>', [[<C-u><Cmd>Telescope command_history<CR><CR>]])
  set_map('n', { '<M-;>p', '<C-p>' }, [[<Cmd>lua _T.smart_find_file()<CR>]])

  set_map('n', '<M-;>r', [[<Cmd>Telescope lsp_references<CR>]])
  set_map('n', '<M-;>gd', [[<Cmd>Telescope lsp_definitions<CR>]])
  set_map('n', '<M-;>dd', [[<Cmd>Telescope lsp_document_diagnostics<CR>]])
  set_map('n', '<M-;>ds', [[<Cmd>Telescope lsp_document_symbols<CR>]])
  set_map('n', '<M-;>wd', [[<Cmd>Telescope lsp_workspace_diagnostics<CR>]])
  set_map('n', '<M-;>ws', [[<Cmd>Telescope lsp_workspace_symbols<CR>]])
  set_map('n', '<M-;>a', [[<Cmd>Telescope lsp_code_actions<CR>]])
  set_map('x', '<M-;>ra', [[<Cmd>Telescope lsp_range_code_actions<CR>]])
end

function map.vim_prettier()
  set_map('n', '<Bslash>p', [[<Cmd>PrettierAsync<CR>]])
end

function map.undotree()
  set_map('n', '<Leader>u', [[<Cmd>UndotreeToggle<CR>]])
end

function map.vim_floaterm()
  set_map('n', '<F9>', [[<Cmd>lua require('autoload.terminal').run_file('FloatermNew --autoclose=0')<CR>]])
  set_map('n', '<F21>', [[<Cmd>lua require('autoload.terminal').open_repl('', 'FloatermNew --autoclose=0')<CR>]])

  set_map({ 'n', 't' }, { '<M-,><CR>', '<M-CR>' }, [[<cmd>FloatermToggle<CR>]])
  set_map({ 'n', 't' }, '<M-,>c', [[<Cmd>FloatermNew<CR>]])
  set_map({ 'n', 't' }, '<M-,><bs>', [[<Cmd>FloatermKill<CR>]])

  set_map({ 'n', 't' }, '<M-,>p', [[<Cmd>FloatermPrev<CR>]])
  set_map({ 'n', 't' }, '<M-,>P', [[<Cmd>FloatermFirst<CR>]])

  set_map({ 'n', 't' }, '<M-,>n', [[<Cmd>FloatermNext<CR>]])
  set_map({ 'n', 't' }, '<M-,>N', [[<Cmd>FloatermLast<CR>]])
end

function map.vim_dirvish()
  set_map('n', '<Bslash>e', [[<Cmd>Dirvish %:p:h<CR>]])
  set_map('n', '<Bslash>E', [[<Cmd>Dirvish<CR>]])
end

function map.git_messenger()
  set_map('n', '<Bslash>gv', [[<Cmd>GitMessenger<CR>]])
end

function map.gina()
  set_map('n', '<Bslash>gb', [[<Cmd>Gina branch<CR>]])
  set_map('n', '<Bslash>gc', [[<Cmd>Gina commit<CR>]])
  set_map('n', '<Bslash>gd', [[<Cmd>Gina diff<CR>]])
  set_map('n', '<Bslash>gs', [[<Cmd>Gina status<CR>]])
  set_map('n', '<Bslash>gS', [[<Cmd>Gina show<CR>]])
end

function map.vimspector()
  vim.cmd([[
  function! GotoWindow(id)
    call win_gotoid(a:id)
    " Requires 'szw/vim-maximizer'
    MaximizerToggle
  endfunction
  ]])

  set_map('n', '<leader>dd', [[<Cmd>call vimspector#Launch()<CR>]])
  set_map('n', '<leader>dc', [[<Cmd>call GotoWindow(g:vimspector_session_windows.code)<CR>]])
  set_map('n', '<leader>dt', [[<Cmd>call GotoWindow(g:vimspector_session_windows.tagpage)<CR>]])
  set_map('n', '<leader>dv', [[<Cmd>call GotoWindow(g:vimspector_session_windows.variables)<CR>]])
  set_map('n', '<leader>dw', [[<Cmd>call GotoWindow(g:vimspector_session_windows.watches)<CR>]])
  set_map('n', '<leader>ds', [[<Cmd>call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>]])
  set_map('n', '<leader>do', [[<Cmd>call GotoWindow(g:vimspector_session_windows.output)<CR>]])
  set_map('n', '<leader>de', [[<Cmd>call vimspector#Reset()<CR>]])
  set_map('n', '<leader>d<space>', [[<Cmd>call vimspector#Continue()<CR>]])
  set_map('n', '<leader>dtcb', [[<Cmd>call vimspector#CleanLineBreakPoint()<CR>]])

  set_map('n', '<leader>dl', [[<Plug>VimspectorStepInto]])
  set_map('n', '<leader>dj', [[<Plug>VimspectorStepOver]])
  set_map('n', '<leader>dk', [[<Plug>VimspectorStepOut]])
  set_map('n', '<leader>d_', [[<Plug>VimspectorStepRestart]])

  set_map('n', '<leader>drc', [[<Plug>VimspectorrunToCursor]])
  set_map('n', '<leader>dbp', [[<Plug>VimspectorToggleBreakpoint]])
  set_map('n', '<leader>dcbp', [[<Plug>VimspectorToggleConditionalBreakpoint]])
end

function map.tcomment_vim()
  local exec = vim.cmd

  -- Default gc maps
  set_map('n', 'gc', '<Plug>TComment_gc', { silent = true })

  for i = 1, 9 do
    set_map('n', 'gc' .. i, '<Plug>TComment_gc' .. i, { silent = true })
    set_map('n', 'gc' .. i .. 'c', '<Plug>TComment_gc' .. i .. 'c', { silent = true })
  end

  set_map('n', 'gcc', '<Plug>TComment_gcc', { silent = true })
  set_map('n', 'gcb', '<Plug>TComment_gcb', { silent = true })
  set_map('x', 'gcc', '<Plug>TComment_gc', { silent = true })

  -- Force uncomment
  set_map({ 'n', 'x' }, 'gc<', '<Plug>TComment_Uncomment', { silent = true })
  set_map('n', { 'gc<c', 'gc<<' }, '<Plug>TComment_Uncommentc', { silent = true })
  set_map('n', 'gc<b', '<Plug>TComment_Uncommentb', { silent = true })

  -- Force comment
  set_map({ 'n', 'x' }, 'gc>', '<Plug>TComment_Comment', { silent = true })
  set_map('n', { 'gc>c', 'gc>>' }, '<Plug>TComment_Commentc', { silent = true })
  set_map('n', 'gc>b', '<Plug>TComment_Commentb', { silent = true })
end

function map.vim_maximizer()
  set_map({ 'n', 't' }, '<M-f>', [[<Cmd>silent! MaximizerToggle<CR>]])
end

function map.nvim_bufferline()
  set_map('n', { '[b', '<Leader>p', '<Left>' }, [[<Cmd>BufferLineCyclePrev<CR>]])
  set_map('n', { ']b', '<Leader>n', '<Right>' }, [[<Cmd>BufferLineCycleNext<CR>]])

  set_map({ 'n', 'i' }, '<C-PageUp>', [[<Cmd>BufferLineCyclePrev<CR>]])
  set_map({ 'n', 'i' }, '<C-PageDown>', [[<Cmd>BufferLineCycleNext<CR>]])

  set_map('n', '<M-lt>', [[<Cmd>BufferLineMovePrev<CR>]])
  set_map('n', '<M->>', [[<Cmd>BufferLineMoveNext<CR>]])

  set_map('n', '<Leader>1', [[<Cmd>lua require('bufferline').go_to_buffer(1)<CR>]])
  set_map('n', '<Leader>2', [[<Cmd>lua require('bufferline').go_to_buffer(2)<CR>]])
  set_map('n', '<Leader>3', [[<Cmd>lua require('bufferline').go_to_buffer(3)<CR>]])
  set_map('n', '<Leader>4', [[<Cmd>lua require('bufferline').go_to_buffer(4)<CR>]])
  set_map('n', '<Leader>5', [[<Cmd>lua require('bufferline').go_to_buffer(5)<CR>]])
  set_map('n', '<Leader>6', [[<Cmd>lua require('bufferline').go_to_buffer(6)<CR>]])
  set_map('n', '<Leader>7', [[<Cmd>lua require('bufferline').go_to_buffer(7)<CR>]])
  set_map('n', '<Leader>8', [[<Cmd>lua require('bufferline').go_to_buffer(8)<CR>]])
  set_map('n', '<Leader>9', [[<Cmd>lua require('bufferline').go_to_buffer(9)<CR>]])
  set_map('n', '<Leader>0', [[<Cmd>lua require('bufferline').go_to_buffer(10)<CR>]])

  set_map('n', '<Leader>b', [[<Cmd>BufferLinePick<CR>]])
end

function map.nvim_tree()
  set_map('n', '<Bslash>t', [[<Cmd>NvimTreeToggle<CR>]])
  set_map('n', '<Bslash>T', [[<Cmd>NvimTreeToggle<CR>]])
end

function map.sideways()
  set_map('n', '[a', [[<Cmd>SidewaysLeft<CR>]])
  set_map('n', ']a', [[<Cmd>SidewaysRight<CR>]])
end

function map.gitsigns()
  set_map('n', ']c', [[&diff ? ']h' : '<Cmd>lua require("gitsigns").next_hunk()<CR>']], { expr = true })
  set_map('n', '[c', [[&diff ? '[h' : '<Cmd>lua require("gitsigns").prev_hunk()<CR>']], { expr = true })

  set_map('n', '<Bslash>hs', [[<Cmd>lua require('gitsigns').stage_hunk()<CR>]])
  set_map('n', '<Bslash>hu', [[<Cmd>lua require('gitsigns').undo_stage_hunk()<CR>]])
  set_map('n', '<Bslash>hr', [[<Cmd>lua require('gitsigns').reset_hunk()<CR>]])
  set_map('n', '<Bslash>hR', [[<Cmd>lua require('gitsigns').reset_buffer()<CR>]])
  set_map('n', '<Bslash>hp', [[<Cmd>lua require('gitsigns').preview_hunk()<CR>]])
  set_map('n', '<Bslash>hb', [[<Cmd>lua require('gitsigns').blame_line()<CR>]])

  set_map({ 'o', 'x' }, 'ih', [[<Cmd>lua require('gitsigns').text_object()<CR>]])
end


function map.splitjoin()
  set_map('n', 'gsj', [[<Cmd>SplitjoinJoin<CR>]])
  set_map('n', 'gss', [[<Cmd>SplitjoinSplit<CR>]])
end

function map.vista()
  set_map('n', '<Leader>V', [[<Cmd>Vista<CR>]])
end

function map.far()
  set_map({ 'n', 'v' }, '<Leader>s', [[<Cmd>Farf<CR>]])
end

function map.nvim_compe()
  set_map('i', '<C-Space>', [[compe#complete()]], { silent = true, expr = true })
  set_map('i', '<CR>', [[compe#confirm('<CR>')]], { silent = true, expr = true })
  set_map('i', '<C-e>', [[pumvisible() ? compe#close('<C-e>') : "<C-e>"]], { silent = true, expr = true })
  set_map('i', '<C-f>', [[compe#scroll({ 'delta': +4 })]], { silent = true, expr = true })
  set_map('i', '<C-d>', [[compe#scroll({ 'delta': -4 })]], { silent = true, expr = true })

  set_map('i', '<Tab>', [[v:lua.tab_complete()]], { expr = true })
  set_map('i', '<S-Tab>', [[v:lua.s_tab_complete()]], { expr = true })

  set_map('i', '<C-j>', [[v:lua.c_j_complete()]], { expr = true })
  set_map('i', '<C-k>', [[v:lua.c_k_complete()]], { expr = true })
end

function map.nvim_lspconfig()
  set_map('n', 'gd', [[<Cmd>lua vim.lsp.buf.definition()<CR>]])
  set_map('n', 'gD', [[<Cmd>lua vim.lsp.buf.declaration()<CR>]])
  set_map('n', 'gi', [[<Cmd>lua vim.lsp.buf.implementation()<CR>]])
  set_map('n', 'gy', [[<Cmd>lua vim.lsp.buf.type_definition()<CR>]])
  set_map('n', '<Leader>wa', [[<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]])
  set_map('n', '<Leader>wr', [[<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]])
  set_map('n', '<Leader>wl', [[<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]])
  set_map('n', '<Leader>ws', [[<Cmd>lua vim.lsp.buf.workspace_symbol(vim.fn.input('Symbol ❯ '))<CR>]])
  set_map('n', 'gr', [[<Cmd>lua vim.lsp.buf.references()<CR>]])
  set_map('n', '<Leader>L', [[<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]])

  set_map('n', '<Leader>f', [[<Cmd>lua vim.lsp.buf.formatting()<CR>]])
  set_map('x', '<Leader>f', [[<Cmd>lua vim.lsp.buf.range_formatting()<CR>]])

  set_map('n', '<Leader>li', [[<Cmd>LspInfo<CR>]])
  set_map('n', '<Leader>ll', [[<Cmd>LspLog<CR>]])
  set_map('n', '<Leader>lr', [[<Cmd>LspRestart<CR>]])

  --   -- Also implemented by lspsaga
  --   set_map('n', '<Leader>j', [[<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>]])
  --   set_map('n', '<Leader>k', [[<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]])
  --   set_map('n', 'K', [[<Cmd>lua vim.lsp.buf.hover()<CR>]])
  --   set_map('n', '<Leader>a', [[<Cmd>lua vim.lsp.buf.code_action()<CR>]])
  --   set_map('x', '<Leader>a', [[<Cmd>vim.lsp.buf.range_code_action()<CR>]])
  --   set_map('i', '<C-]>', [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]])
  --   set_map('n', '<Leader>r', [[<Cmd>lua vim.lsp.buf.rename()<CR>]])
  --   set_map('n', '<Leader>d', [[<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])
end

function map.lspsaga()
  set_map('n', '<C-f>', [[<Cmd>silent! lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
  set_map('n', '<C-b>', [[<Cmd>silent! lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
  set_map('n', '<Leader>vd', [[<Cmd>Lspsaga preview_definition<CR>]])
  set_map('n', '<Leader>f', [[<Cmd>Lspsaga lsp_finder<CR>]])

  -- Also implemented by nvim-lspconfig
  set_map('n', '<Leader>j', [[<Cmd>Lspsaga diagnostic_jump_next<CR>]])
  set_map('n', '<Leader>k', [[<Cmd>Lspsaga diagnostic_jump_prev<CR>]])
  set_map('n', 'K', [[<Cmd>Lspsaga hover_doc<CR>]])
  set_map('n', '<Leader>a', [[<Cmd>Lspsaga code_action<CR>]])
  set_map('x', '<Leader>a', [[<Cmd>Lspsaga range_code_action<CR>]])
  set_map('i', '<C-]>', [[<Cmd>Lspsaga signature_help<CR>]])
  set_map('n', '<Leader>r', [[<Cmd>Lspsaga rename<CR>]])
  set_map('n', '<Leader>D', [[<Cmd>Lspsaga show_line_diagnostics<CR>]])
end

return map
