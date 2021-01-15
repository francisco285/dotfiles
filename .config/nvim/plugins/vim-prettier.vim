" workaround to get autoformat on saving to work:
autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" Enable auto formatting of files that have "@format" or "@prettier" tag
let g:prettier#autoformat = 1

" Allow auto format for files without "@format" or "@prettier" tag
let g:prettier#autoformat_require_pragma = 0

" Toggle the g:prettier#autoformat setting based on whether a config file can be found in the current directory or any parent directory. Note that this will override the g:prettier#autoformat setting!
let g:prettier#autoformat_config_present = 1

" The command :Prettier by default is synchronous but can also be forced async
let g:prettier#exec_cmd_async = 1

" By default parsing errors will open the quickfix but can also be disabled
let g:prettier#quickfix_enabled = 0
