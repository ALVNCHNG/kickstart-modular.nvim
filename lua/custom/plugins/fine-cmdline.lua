local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'MunifTanjim/nui.nvim',
  gh 'VonHeikemen/fine-cmdline.nvim',
}

vim.keymap.set('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
