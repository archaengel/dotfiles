require'gitsigns'.setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Navigation
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr = true})
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr = true})
        vim.keymap.set('n', '<leader>hr', function() gs.reset_hunk() end)
        vim.keymap.set('n', '<leader>hp', function() gs.preview_hunk() end)
    end
}
