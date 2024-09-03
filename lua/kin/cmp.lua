
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
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
        { name = 'buffer' },
    },
    formatting = {
        fields = { 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lua = '[API]',
                nvim_lsp = '[LSP]',
                luasnip = '[SNIP]',
                path = '[PATH]',
                buffer = '[BUF]',
            })[entry.source.name]
            return vim_item
        end,
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})
