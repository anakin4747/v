-- TODO: :h ins-completion

local cmp, luasnip = require('cmp'), require('luasnip')

cmp.setup({
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ['<C-space>'] = cmp.mapping.complete(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer',  keyword_length = 5 },
    },
    formatting = {
        fields = { 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lua = '[API]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                path = '[Path]',
                buffer = '[Buffer]',
            })[entry.source.name]
            return vim_item
        end,
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})
