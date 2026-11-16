-- Checks for what lua/custom needs on this machine. Run with `:checkhealth custom`.

local function check_executables()
  local tools = {
    { 'fd', 'telescope file finder' },
    { 'tree-sitter', 'nvim-treesitter parser builds' },
    { 'node', 'Mason npm tools, typescript-tools' },
    { 'sonarlint-language-server', 'sonarlint (installed by Mason)' },
  }
  for _, tool in ipairs(tools) do
    local exe, used_by = tool[1], tool[2]
    if vim.fn.executable(exe) == 1 then
      vim.health.ok(string.format("Found '%s'", exe))
    else
      vim.health.warn(string.format("Missing '%s', needed by %s", exe, used_by), 'Run `brew bundle --file=~/.config/nvim/Brewfile`')
    end
  end
end

-- macOS ships a /usr/bin/java stub that exists without a JDK, so run it.
local function check_java()
  if vim.fn.executable 'java' == 1 and vim.system({ 'java', '-version' }):wait().code == 0 then
    vim.health.ok 'Java runs'
  else
    vim.health.warn('No working Java runtime, needed by sonarlint', 'Run `brew bundle --file=~/.config/nvim/Brewfile`')
  end
end

local function check_c_compiler()
  if vim.fn.executable 'cc' == 0 then
    vim.health.warn('No C compiler found', 'Run `xcode-select --install`')
    return
  end
  local result = vim.system({ 'cc', '-fsyntax-only', '-x', 'c', '-' }, { stdin = '#include <stdio.h>\n' }):wait()
  if result.code == 0 then
    vim.health.ok 'C compiler finds the system headers'
  else
    vim.health.warn(
      'C compiler cannot find the system headers, so native plugin builds (LuaSnip, telescope-fzf-native) will fail',
      'Set SDKROOT in lua/local.lua, see lua/local.example.lua'
    )
  end
end

local function check_env()
  for _, var in ipairs { 'OPENROUTER_API_KEY', 'ANTHROPIC_BASE_URL' } do
    if vim.env[var] and vim.env[var] ~= '' then
      vim.health.ok(string.format('$%s is set', var))
    else
      vim.health.warn(string.format('$%s is not set, codecompanion chat will fail', var))
    end
  end
end

local function check_local_overrides()
  local path = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'local.lua')
  if vim.uv.fs_stat(path) then
    vim.health.ok 'Loaded machine overrides from lua/local.lua'
  else
    vim.health.info 'No lua/local.lua, using shared defaults'
  end
  vim.health.info(string.format('vim.g.have_nerd_font = %s', tostring(vim.g.have_nerd_font)))
end

return {
  check = function()
    vim.health.start 'External tools'
    check_executables()
    check_java()
    check_c_compiler()

    vim.health.start 'Environment'
    check_env()

    vim.health.start 'Machine overrides'
    check_local_overrides()
  end,
}
