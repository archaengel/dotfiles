local g = vim.g
local telescope_builtin = require 'telescope.builtin'

g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

-- terminal
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

-- telescope
vim.keymap.set('n', '<leader>ff',
               function() telescope_builtin.find_files {hidden = true} end)
vim.keymap.set('n', '<leader>bf',
               function() return telescope_builtin.buffers() end)
vim.keymap.set('n', '<leader>fb',
               function() return telescope_builtin.file_browser() end)
vim.keymap.set('n', '<leader>lg',
               function() return telescope_builtin.live_grep() end)
vim.keymap.set('n', '<leader>en', function()
    telescope_builtin.find_files {cwd = "~/.config/nvim"}
end)

-- lsp
vim.keymap.set('n', '<leader>vsd', vim.diagnostic.open_float, {silent = true})

-- netrw
vim.keymap.set('n', '<C-b>', function() vim.cmd [[:Lexplore<CR>]] end)

-- rest.nvim
vim.keymap.set('n', '<leader>rq', function() require'rest-nvim'.run() end)
