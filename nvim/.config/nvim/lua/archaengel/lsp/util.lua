local nvim_exec = function(txt) vim.api.nvim_exec(txt, false) end

local function custom_attach(client)
    local server_capabilities = client.server_capabilities
    if server_capabilities.documentHighlightProvider then
        nvim_exec [[
            augroup docuemnt_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]]
    end

    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>aa', vim.lsp.buf.code_action)

    if server_capabilities.documentFormattingProvider then
        nvim_exec [[
            augroup document_formatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
        ]]
    end

    if server_capabilities.renameProvider then
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    end
end

local make_capabilities = vim.lsp.protocol.make_client_capabilities
local capabilities = require 'cmp_nvim_lsp'.update_capabilities(
    make_capabilities())

local make_capabilities_with_cmp = function()
    return require 'cmp_nvim_lsp'.update_capabilities(make_capabilities())
end

return {
    capabilities = capabilities,
    custom_attach = custom_attach,
    make_capabilities_with_cmp = make_capabilities_with_cmp
}
