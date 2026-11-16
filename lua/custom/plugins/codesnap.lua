local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'mistricky/codesnap.nvim', version = 'v2.1.1' } }
