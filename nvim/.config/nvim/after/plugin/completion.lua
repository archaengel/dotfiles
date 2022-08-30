local cmp = require 'cmp'
local lspkind = require 'lspkind'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

cmp.setup {
    snippet = {
        expand = function(args) require'luasnip'.lsp_expand(args.body) end
    },
    mapping = {
        ['<C-N>'] = cmp.mapping(cmp.mapping.select_next_item()),
        ['<C-P>'] = cmp.mapping(cmp.mapping.select_prev_item()),
        ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
        ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i'}),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i'})
    },
    formatting = {format = lspkind.cmp_format()},
    sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'luasnip'}},
                                 {{name = 'buffer'}})
}

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
