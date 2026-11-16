-- Machine-specific settings. Copy this file to lua/local.lua, which git ignores.
-- Runs at the end of lua/options.lua, before any plugin loads.

-- vim.g.have_nerd_font = true

-- macOS only: point clang at the SDK when native plugin builds fail with "'stdio.h' file not found"
-- vim.env.SDKROOT = vim.trim(vim.fn.system { 'xcrun', '--show-sdk-path' })
