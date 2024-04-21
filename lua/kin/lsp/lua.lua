
require("neodev").setup()

require('lspconfig').lua_ls.setup({
    -- From neodev config example
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    },
})
