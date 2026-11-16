local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'jmacadie/telescope-hierarchy.nvim',
}

-- Calling telescope's setup again is safe: it merges the extension config into the existing setup.
require('telescope').setup {
  extensions = {
    hierarchy = {},
  },
}
require('telescope').load_extension 'hierarchy'

vim.keymap.set('n', '<leader>si', '<cmd>Telescope hierarchy incoming_calls<cr>', { desc = 'LSP: [S]earch [I]ncoming Calls' })
vim.keymap.set('n', '<leader>so', '<cmd>Telescope hierarchy outgoing_calls<cr>', { desc = 'LSP: [S]earch [O]utgoing Calls' })
