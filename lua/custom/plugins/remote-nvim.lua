local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-lua/plenary.nvim', -- For standard functions
  gh 'MunifTanjim/nui.nvim', -- To build the plugin UI
  gh 'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
  { src = gh 'amitds1997/remote-nvim.nvim', version = vim.version.range '*' }, -- Pin to GitHub releases
}

require('remote-nvim').setup {
  offline_mode = {
    enabled = true,
    no_github = false,
  },
}
