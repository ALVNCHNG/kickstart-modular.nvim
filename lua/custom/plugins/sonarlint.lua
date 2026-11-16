local function gh(repo) return 'https://github.com/' .. repo end

-- Needs Java (Brewfile) and the server from Mason, which installs it on first start.
if vim.fn.executable 'java' == 0 or vim.fn.executable 'sonarlint-language-server' == 0 then return end

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  { src = 'https://gitlab.com/schrieveslaach/sonarlint.nvim', name = 'sonarlint' },
}

require('sonarlint').setup {
  server = {
    cmd = {
      'sonarlint-language-server',
      -- Ensure that sonarlint-language-server uses stdio channel
      '-stdio',
      '-analyzers',
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
}
