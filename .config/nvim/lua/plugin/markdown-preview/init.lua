-- Alternative: 'instant-markdown/vim-instant-markdown'
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' },
  run = ':call mkdp#util#install()'
}
