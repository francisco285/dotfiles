return {
  'turbio/bracey.vim',
  cmd = 'Bracey',
  run = 'npm install --prefix server',
  setup = function()
    local browser = os.getenv('BROWSER')
    if browser then
      vim.g.bracey_browser_command = browser
    end
    vim.g.bracey_refresh_on_save = 1
  end
}
