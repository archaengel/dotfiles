local g = vim.g
local cmd = vim.cmd
local telescope_builtin = require 'telescope.builtin'
local remote_sshfs_api = require 'remote-sshfs.api'
local remote_connections = require 'remote-sshfs.connections'

g.mapleader = ' '
g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>pv', ':Ex<CR>')
vim.keymap.set('n', '<leader>w', [[<C-w>]])
vim.keymap.set('n', '<leader>xx', ':so %<CR>')
-- Deal with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- remote-sshfs
vim.keymap.set('n', '<leader>rc', function() return remote_sshfs_api.connect() end)
vim.keymap.set('n', '<leader>rd', function() return remote_sshfs_api.disconnect() end)
vim.keymap.set('n', '<leader>re', function() return remote_sshfs_api.edit() end)

-- terminal
vim.keymap.set('t', [[<C-x><C-x>]], [[<C-\><C-n>]])

-- telescope
vim.keymap.set('n', '<leader>ff',
    function()
        if remote_connections.is_connected() then
            return remote_sshfs_api.find_files()
        end

        return telescope_builtin.find_files { hidden = true }
    end)
vim.keymap.set('n', '<leader><Space>',
    function() return telescope_builtin.buffers() end)
vim.keymap.set('n', '<leader>fb',
    function() return telescope_builtin.file_browser() end)
vim.keymap.set('n', '<leader>lg',
    function()
        if remote_connections.is_connected() then
            return remote_sshfs_api.live_grep()
        end

        return telescope_builtin.live_grep()
    end)
vim.keymap.set('n', '<leader>lh',
    function() return telescope_builtin.live_grep { additional_args = function() return { "-." } end } end)
vim.keymap.set('n', '<leader>en', function()
    telescope_builtin.find_files { cwd = "~/.config/nvim" }
end)
vim.keymap.set('n', '<leader>?', function() return telescope_builtin.keymaps() end, { desc = '[?] Search Keymaps' })
vim.keymap.set('n', '<leader>/',
    function() return telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search current buffer' })
vim.keymap.set('n', '<leader>rf', function() return telescope_builtin.lsp_references() end)
vim.keymap.set('n', '<leader>ds', function() return telescope_builtin.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>ggs', function()
    return telescope_builtin.git_status()
end)

-- harpoon
local harpoon_ui = require 'harpoon.ui'
vim.keymap.set('n', '<leader>hm', function()
    return require 'harpoon.mark'.add_file()
end)
vim.keymap.set('n', '<leader>hh', function()
    return harpoon_ui.toggle_quick_menu()
end, { desc = '[hh] Toggle Harpoon Quick Menu' })
vim.keymap.set('n', '<leader>ha', function()
    return harpoon_ui.nav_file(1)
end)
vim.keymap.set('n', '<leader>hs', function()
    return harpoon_ui.nav_file(2)
end)
vim.keymap.set('n', '<leader>hd', function()
    return harpoon_ui.nav_file(3)
end)
vim.keymap.set('n', '<leader>hf', function()
    return harpoon_ui.nav_file(4)
end)

-- dadbod
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>')

-- markdown
-- Markdown plugin isn't checking filetypes correctly so plugging in directly
-- to the vimscript function instead of <Plug> function
vim.keymap.set('n', '<leader>pp', ':call mkdp#util#toggle_preview()<CR>')

-- lsp
vim.keymap.set('n', '<leader>vsd', vim.diagnostic.open_float, { silent = true })

-- netrw
vim.keymap.set('n', '<C-b>', function() vim.cmd [[:Lexplore<CR>]] end)

-- rest.nvim
vim.keymap.set('n', '<leader>rq', function() require 'rest-nvim'.run() end)
