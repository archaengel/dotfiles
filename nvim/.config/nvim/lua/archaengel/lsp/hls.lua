local lsputil = require 'archaengel.lsp.util'
local custom_attach = lsputil.custom_attach
local capabilities = lsputil.capabilities
local lspconfig = require 'lspconfig'

capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true


lspconfig.hls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    cmd = { "haskell-language-server", "--lsp" },
}
