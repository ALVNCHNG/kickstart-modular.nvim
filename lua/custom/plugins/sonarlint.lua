return {
  {
    'schrieveslaach/sonarlint',
    ft = { 'javascript', 'typescript', 'html' },
    dependencies = { 'neovim/nvim-lspconfig' },
    url = 'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    opts = {
      server = {
        cmd = {
          'sonarlint-language-server',
          -- Ensure that sonarlint-language-server uses stdio channel
          '-stdio',
          '-analyzers',
          -- paths to the analyzers you need, using those for python and java in this example
          vim.fn.stdpath 'data' .. '/mason/share/sonarlint-analyzers/sonarjs.jar',
          vim.fn.stdpath 'data' .. '/mason/share/sonarlint-analyzers/sonarhtml.jar',
        },
      },
      filetypes = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
      },
    },
    enabled = true,
  },
}
