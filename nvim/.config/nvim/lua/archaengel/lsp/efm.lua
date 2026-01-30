local util = require 'archaengel.lsp.util'
local custom_attach = util.custom_attach
local capabilities = util.make_capabilities_with_cmp()

local prettier = {
    formatCommand = "prettierd ${INPUT}",
    formatStdin = true
}

local mypy = {
    lintCommand = "mypy --show-column-numbers",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" }
}

local ruff = {
    formatCommand = "ruff format --stdin-filename ${INPUT}",
    formatStdin = true
}

local nixfmt = {
    formatCommand = "nixfmt",
    formatStdin = true
}

local ormolu = {
    formatCommand = "ormolu --stdin-input-file ${INPUT}",
    formatStdin = true,
}

local go = {
    lintCommand = "staticcheck ${INPUT}",
    lintFormats = { "%f:%l:%c: %m" }
}

local languages = {
    typescript = { prettier },
    typescriptreact = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    graphql = { prettier },
    python = { mypy, ruff },
    nix = { nixfmt },
    haskell = { ormolu },
    go = { go }
}

vim.lsp.config('efm', {
    capabilities = capabilities,
    init_options = { documentFormatting = true },
    on_attach = custom_attach,
    filetypes = vim.tbl_keys(languages),
    settings = { languages = languages }
})
vim.lsp.enable('efm')
