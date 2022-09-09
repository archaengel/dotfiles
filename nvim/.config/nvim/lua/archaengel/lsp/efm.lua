local util = require 'archaengel.lsp.util'
local custom_attach = util.custom_attach
local lspconfig = require 'lspconfig'
local capabilities = util.make_capabilities_with_cmp()

local eslint = {
    lintCommand = "eslint_d -f visualstudio --rulesdir script/eslint_rules/build --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %trror %m" },
    -- eslint's formatting is at odds with what's in work repos, so using prettier here until I can nail
    -- down the root cause / misconfig
    -- formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatCommand = "prettierd ${INPUT}",
    formatStdin = true
}

local languages = {
    typescript = { eslint, eslint },
    typescriptreact = { eslint, eslint },
    javascript = { eslint, eslint },
    javascriptreact = { eslint, eslint }
}

lspconfig.efm.setup {
    capabilities = capabilities,
    init_options = { documentFormatting = true },
    on_attach = custom_attach,
    filetypes = vim.tbl_keys(languages),
    settings = { languages = languages }
}
