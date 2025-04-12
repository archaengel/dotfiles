require('lze').load(
    'nvim-autopairs',
    {
        after = function()
            require('nvim-autopairs').setup {
                fast_wrap = {}
            }
        end,
    }
)
