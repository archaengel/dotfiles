local lsputil = require 'archaengel.lsp.util'
local custom_attach = lsputil.custom_attach
local capabilities = lsputil.capabilities
local lspconfig = require 'lspconfig'

capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.ccls.setup { on_attach = custom_attach, capabilities = capabilities }
lspconfig.hls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    cmd = { "haskell-language-server-wrapper", "--lsp" },
}
lspconfig.ts_ls.setup {
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
}
lspconfig.unison.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}
-- lspconfig.rls.setup {on_attach = custom_attach}
lspconfig.terraformls.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}
lspconfig.jedi_language_server.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}
lspconfig.rust_analyzer.setup {
    on_attach = custom_attach,
    capabilities = capabilities
}
lspconfig.cssls.setup { on_attach = custom_attach, capabilities = capabilities }
lspconfig.graphql.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
}
lspconfig.gopls.setup {
    on_attach = custom_attach,
    settings = {
        gopls = {
            buildFlags = { "-tags=test,testcontainers" }
        },
    },
    capabilities = capabilities
}
lspconfig.nixd.setup { on_attach = custom_attach, capabilities = capabilities }
require('archaengel.lsp.luaconfig')
require('archaengel.lsp.kotlin')
require('archaengel.lsp.efm')
