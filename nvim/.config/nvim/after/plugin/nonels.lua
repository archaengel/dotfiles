local null_ls = require("null-ls")
local custom_attach = require("archaengel.lsp.util").custom_attach


null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d")
    },
    on_attach = custom_attach
})
