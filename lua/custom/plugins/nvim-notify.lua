local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'rcarriga/nvim-notify' }

require('notify').setup()
vim.notify = require 'notify'
