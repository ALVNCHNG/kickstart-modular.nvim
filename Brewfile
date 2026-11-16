# External tools this Neovim config depends on.
# Install with: brew bundle --file=~/.config/nvim/Brewfile
#
# git, make, unzip, curl and a C compiler come from the Xcode Command Line Tools:
#   xcode-select --install
# Editor tools (LSPs, formatters) are installed by Mason, see `ensure_installed`
# in lua/kickstart/plugins/lspconfig.lua.

brew "neovim"          # >= 0.12, required by vim.pack
brew "git"             # vim.pack clones plugins with git
brew "ripgrep"         # telescope live grep
brew "fd"              # telescope file finder
brew "tree-sitter-cli" # nvim-treesitter compiles parsers with it
brew "fnm"             # Node.js, needed by Mason's npm tools (prettier, prettierd)
brew "openjdk@17"      # Java, needed by sonarlint-language-server

# Optional: icons. Set vim.g.have_nerd_font = true in lua/options.lua after installing.
# cask "font-hack-nerd-font"
