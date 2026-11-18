# Setting up this config on a new machine

Works on macOS and Linux. Needs Neovim 0.12 or newer.

## 1. System build tools

macOS:

```sh
xcode-select --install
```

Linux (Debian/Ubuntu; use your distro's equivalents elsewhere):

```sh
sudo apt install build-essential curl git unzip
# Clipboard: pick the one for your session
sudo apt install xclip          # X11
sudo apt install wl-clipboard   # Wayland
```

## 2. Homebrew and the Brewfile

Install [Homebrew](https://brew.sh) (it also runs on Linux), then:

```sh
git clone https://github.com/ALVNCHNG/kickstart-modular.nvim.git ~/.config/nvim
brew bundle --file=~/.config/nvim/Brewfile
```

Homebrew doesn't put `openjdk@17` on your PATH, and sonarlint needs `java`:

```sh
# macOS
sudo ln -sfn "$(brew --prefix openjdk@17)/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk-17.jdk
# Linux: use the distro's Java instead
sudo apt install openjdk-17-jre-headless
```

## 3. Node.js

```sh
fnm install --lts
```

If `node` isn't found afterwards, add `eval "$(fnm env --use-on-cd)"` to your shell profile.

## 4. Machine-specific settings

```sh
cp ~/.config/nvim/lua/local.example.lua ~/.config/nvim/lua/local.lua
```

Edit `lua/local.lua` for this machine. It is git-ignored. Turn on `vim.g.have_nerd_font` if the terminal uses a Nerd Font. On macOS, turn on the `SDKROOT` line if `:checkhealth custom` says the C compiler can't find the system headers.

## 5. Environment variables

codecompanion reads these. Add them to your shell profile:

```sh
export OPENROUTER_API_KEY=...
export ANTHROPIC_BASE_URL=...
```

## 6. First launch

```sh
nvim
```

Accept the plugin install prompt. Plugins install at the revisions in `nvim-pack-lock.json`, and Mason installs the language servers and formatters in the background. Restart once it's done, then run:

```vim
:checkhealth custom
:checkhealth kickstart
```

sonarlint and typescript-tools stay off until Java, Node and Mason's `sonarlint-language-server` are available, so a half-set-up machine starts without errors.

If the first launch showed `Build failed for LuaSnip` or `telescope-fzf-native.nvim`, fix the compiler (see `:checkhealth custom`), then reinstall them so they rebuild:

```sh
nvim --clean "+lua vim.pack.del({ 'LuaSnip', 'telescope-fzf-native.nvim' })" +qa
nvim
```

## Not in this repo

Bring these over yourself:

- `OPENROUTER_API_KEY` and `ANTHROPIC_BASE_URL` (keep them in a password manager)
- `~/.config/agents/skills`, which codecompanion's agentskills extension reads
- Your terminal's font setting, if you use a Nerd Font
- Shell profile lines: the `export`s above and `fnm env`

Undo history, command history and codecompanion chats stay on the old machine.

## Keeping machines in sync

Plugin revisions live in `nvim-pack-lock.json`, which is committed.

- **Update** on one machine: `:PackUpdate`, review the changes, `:write` to apply, test, then commit `nvim-pack-lock.json` and push.
- **Sync** the other machines: `git pull`, then `:PackSync` and `:write` to apply. This moves every plugin to the lockfile's revision.
- **Roll back** a bad update: `git checkout` the previous `nvim-pack-lock.json`, then `:PackSync`.

## Pulling from upstream kickstart

```sh
git fetch upstream
git merge upstream/master
```

Keep personal changes in `lua/custom/`, `lua/local.lua`, the end of `lua/options.lua` and this file, so merges rarely conflict.
