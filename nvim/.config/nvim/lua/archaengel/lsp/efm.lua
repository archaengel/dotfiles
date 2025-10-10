local util = require 'archaengel.lsp.util'
local custom_attach = util.custom_attach
local capabilities = util.make_capabilities_with_cmp()

local eslint = {
    lintCommand =
    "eslint_d -f visualstudio -c web-ui/eslint.config.mjs --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    env = { "ESLINT_D_PPID=" .. vim.fn.getpid(), "ESLINT_D_ROOT=" .. vim.fn.getcwd() .. "/web-ui", "ESLINT_USE_FLAT_CONFIG=true" },
    lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %trror %m" },
    formatCommand =
    "eslint_d -c eslint.config.mjs --fix-to-stdout --stdin --stdin-filename ${INPUT}",
    formatStdin = true
}

local prettier = {
    formatCommand = "prettierd ${INPUT}",
    formatStdin = true
}

local mypy = {
    lintCommand = "mypy --show-column-numbers",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" }
}

local autopep8 = {
    formatCommand = "autopep8 -",
    formatStdin = true
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
    typescript = { eslint, prettier },
    typescriptreact = { eslint, prettier },
    javascript = { eslint, prettier },
    javascriptreact = { eslint, prettier },
    graphql = { eslint, prettier },
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
