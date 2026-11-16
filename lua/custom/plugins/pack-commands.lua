-- Keep plugin revisions the same on every machine through nvim-pack-lock.json.
-- See SETUP.md for the routine.

-- Update to the newest revisions allowed by each plugin's `version`, then commit the lockfile.
vim.api.nvim_create_user_command('PackUpdate', function() vim.pack.update() end, { desc = 'Update plugins and the lockfile' })

-- Move every plugin to the revision in the lockfile, e.g. after `git pull` or to roll back.
vim.api.nvim_create_user_command('PackSync', function() vim.pack.update(nil, { target = 'lockfile' }) end, { desc = 'Match plugins to the lockfile' })
