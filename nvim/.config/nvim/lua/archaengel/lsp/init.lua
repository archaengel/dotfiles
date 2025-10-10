local lsputil = require 'archaengel.lsp.util'
local custom_attach = lsputil.custom_attach
local capabilities = lsputil.capabilities
local lspconfig = vim.lsp.config

capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig('ccls', { on_attach = custom_attach, capabilities = capabilities })
vim.lsp.enable('ccls')
lspconfig('hls', {
    on_attach = custom_attach,
    capabilities = capabilities,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
})
vim.lsp.enable('hls')
lspconfig('ts_ls', {
    cmd = { "typescript-language-server", "--stdio", "--log-level", "4" },
    on_attach = function(client, bufnr)
        custom_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.callHierarchyProvider = true
    end,
    capabilities = capabilities,
    init_options = {
        maxTsServerMemory = 8192,
    }
})
vim.lsp.enable('ts_ls')
lspconfig('unison', {
    on_attach = custom_attach,
    capabilities = capabilities
})
vim.lsp.enable('unison')
-- lspconfig('rls', {on_attach = custom_attach})
-- vim.lsp.enable('rls')
lspconfig('terraformls', {
    on_attach = custom_attach,
    capabilities = capabilities
})
vim.lsp.enable('terraformls')
lspconfig('jedi_language_server', {
    on_attach = custom_attach,
    capabilities = capabilities
})
vim.lsp.enable('jedi_language_server')
lspconfig('rust_analyzer', {
    on_attach = custom_attach,
    capabilities = capabilities
})
vim.lsp.enable('rust_analyzer')
lspconfig('cssls', { on_attach = custom_attach, capabilities = capabilities })
vim.lsp.enable('cssls')
lspconfig('graphql', {
    on_attach = custom_attach,
    capabilities = capabilities,
})
vim.lsp.enable('graphql')
lspconfig('gopls', {
    on_attach = custom_attach,
    settings = {
        gopls = {
            buildFlags = { "-tags=test,testcontainers,assessor_db" }
        },
    },
    capabilities = capabilities
})
vim.lsp.enable('gopls')
lspconfig('nixd', { on_attach = custom_attach, capabilities = capabilities })
vim.lsp.enable('nixd')
require('archaengel.lsp.luaconfig')
require('archaengel.lsp.kotlin')
require('archaengel.lsp.efm')
vim.lsp.enable('all')
