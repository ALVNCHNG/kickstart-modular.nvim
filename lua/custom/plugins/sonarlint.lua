local function gh(repo) return 'https://github.com/' .. repo end

-- Needs Java (Brewfile) and the server from Mason, which installs it on first start.
if vim.fn.executable 'java' == 0 or vim.fn.executable 'sonarlint-language-server' == 0 then return end

vim.pack.add {
  gh 'neovim/nvim-lspconfig',
  { src = 'https://gitlab.com/schrieveslaach/sonarlint.nvim', name = 'sonarlint' },
}

-- sonarlint.nvim starts on a FileType autocmd for each filetype in `filetypes`.
-- JavaScript should only get it when the file is Flow-typed, so instead of listing
-- javascript there we list this placeholder and fire it ourselves for Flow files.
local FLOW_PLACEHOLDER = 'flow-javascript'

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
    'typescript',
    'typescriptreact',
    FLOW_PLACEHOLDER,
  },
}

-- Flow requires the @flow pragma in a comment at the top of the file.
local function has_flow_pragma(bufnr)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 20, false)) do
    if line:match '^%s*//.*@flow' or line:match '^%s*/?%*.*@flow' then return true end
  end
  return false
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-sonarlint-flow', { clear = true }),
  pattern = { 'javascript', 'javascriptreact' },
  callback = function(e)
    if not has_flow_pragma(e.buf) then return end
    vim.api.nvim_buf_call(e.buf, function() vim.api.nvim_exec_autocmds('FileType', { pattern = FLOW_PLACEHOLDER, modeline = false }) end)
  end,
})
