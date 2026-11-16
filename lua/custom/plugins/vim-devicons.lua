local function gh(repo) return 'https://github.com/' .. repo end

if not vim.g.have_nerd_font then return end

vim.pack.add { gh 'ryanoasis/vim-devicons' }
