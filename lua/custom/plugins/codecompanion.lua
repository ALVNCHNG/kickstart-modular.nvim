return {
  {
    'olimorris/codecompanion.nvim',
    version = '^19.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'cairijun/codecompanion-agentskills.nvim',
    },
    config = function()
      require('codecompanion').setup {
        interactions = {
          chat = {
            adapter = 'openrouter',
          },
        },
        extensions = {
          agentskills = {
            opts = {
              paths = {
                { '~/.config/agents/skills', recursive = true }, -- Recursive search
              },
            },
          },
        },
        adapters = {
          http = {
            openrouter = function()
              return require('codecompanion.adapters').extend('openai_compatible', {
                env = {
                  url = vim.env.ANTHROPIC_BASE_URL,
                  api_key = vim.env.OPENROUTER_API_KEY,
                  chat_url = '/v1/chat/completions',
                },
                schema = {
                  model = {
                    default = 'openai/gpt-4o-mini',
                    choices = {
                      ['x-ai/grok-code-fast-1'] = {},
                      ['qwen/qwen3-coder-30b-a3b-instruct'] = {},
                      ['anthropic/claude-3.7-sonnet'] = {},
                      ['anthropic/claude-3.5-sonnet'] = {},
                      ['openai/gpt-4o-mini'] = {},
                      ['deepseek/deepseek-v4-flash'] = {},
                      -- Add more models as needed (check OpenRouter docs for IDs)
                    },
                  },
                },
              })
            end,
          },
        },
      }
    end,
  },
}
