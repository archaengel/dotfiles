local api = vim.api

api.nvim_exec([[
    augroup Indentation
        autocmd!
        autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
        autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 tabstop=2
        autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 tabstop=2
    augroup END]], false)

local lsputil = require 'archaengel.lsp.util'
local custom_attach = lsputil.custom_attach
local capabilities = lsputil.capabilities

local metals_config = require 'metals'.bare_config()
metals_config.capabilities = capabilities
metals_config.on_attach = custom_attach

local MetalsGroup = api.nvim_create_augroup("MetalsLsp", { clear = true })
api.nvim_create_autocmd("FileType", {
    pattern = "java,scala,sbt",
    callback = function()
        require('metals').initialize_or_attach(metals_config)
    end,
    group = MetalsGroup
})

local MarkdownGroup = api.nvim_create_augroup("SpellingMd", { clear = true })
api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal spell spelllang=en_us wrap",
    group = MarkdownGroup
})

local ContainerfileGroup = api.nvim_create_augroup("ContainerfileSyn", { clear = true })
api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
    pattern = "*.containerfile",
    command = "set filetype=dockerfile",
    group = ContainerfileGroup
})
