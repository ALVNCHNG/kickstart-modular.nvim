return {

  {
    'pmizio/typescript-tools.nvim',
    enabled = vim.fn.filereadable(vim.fn.getcwd() .. '/tsconfig.json') == 1,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
        },
      },
    },
  },
}
