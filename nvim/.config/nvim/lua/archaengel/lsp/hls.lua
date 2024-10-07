local lsputil = require 'archaengel.lsp.util'
local custom_attach = lsputil.custom_attach
local capabilities = lsputil.capabilities
local lspconfig = require 'lspconfig'

capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local home = os.getenv('HOME')
local hls_path = home ..
'/repos/haskell-language-server/dist-newstyle/build/x86_64-osx/ghc-9.6.3/haskell-language-server-2.8.0.0/x/haskell-language-server/build/haskell-language-server/haskell-language-server'

lspconfig.hls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
    cmd = { hls_path, "--lsp" },
}
