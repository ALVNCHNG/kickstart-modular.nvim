local function gh(repo) return 'https://github.com/' .. repo end

if vim.fn.filereadable(vim.fn.getcwd() .. '/tsconfig.json') ~= 1 or vim.fn.executable 'node' == 0 then return end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'pmizio/typescript-tools.nvim',
}

require('typescript-tools').setup {
  settings = {
    tsserver_plugins = {
      '@styled/typescript-styled-plugin',
    },
  },
}
