require('lze').load {
    "nvterm",
    keys = {
        { "<leader>st",
            function() require('nvterm.terminal').toggle('horizontal') end,
            mode = { 'n' },
            desc = "Open horizonal terminal",
        },
        { "<leader>rt",
            function() require('nvterm.terminal').toggle('vertical') end,
            mode = { 'n' },
            desc = "Open vertical terminal"
        },
        { "<leader>it",
            function() require('nvterm.terminal').toggle('float') end,
            mode = { 'n' },
            desc = "Open float terminal"
        },
    },
    after = function()
        require('nvterm').setup()
    end
}
