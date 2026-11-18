local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }

require('catppuccin').setup {
  flavour = 'macchiato',
  styles = {
    comments = {}, -- Disable italics in comments, as kickstart's tokyonight did
  },
}
vim.cmd.colorscheme 'catppuccin-macchiato'
