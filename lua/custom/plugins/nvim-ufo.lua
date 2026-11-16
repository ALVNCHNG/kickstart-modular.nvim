local function gh(repo) return 'https://github.com/' .. repo end

-- Disabled. Remove this line to enable nvim-ufo.
do
  return
end

vim.pack.add {
  gh 'kevinhwang91/promise-async',
  gh 'kevinhwang91/nvim-ufo',
}

require('ufo').setup {
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {
    defaults = { 'imports', 'comment' },
  },
  provider_selector = function(_, filetype, _)
    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = '',
    }

    ---@param bufnr number
    ---@return Promise
    local function customizeSelector(bufnr)
      local function handleFallbackException(err, providerName)
        if type(err) == 'string' and err:match 'UfoFallbackException' then
          return require('ufo').getFolds(bufnr, providerName)
        else
          return require('promise').reject(err)
        end
      end

      return require('ufo')
        .getFolds(bufnr, 'lsp')
        :catch(function(err) return handleFallbackException(err, 'treesitter') end)
        :catch(function(err) return handleFallbackException(err, 'indent') end)
    end

    return ftMap[filetype] or customizeSelector
  end,
}
