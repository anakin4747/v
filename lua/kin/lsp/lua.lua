local lspconfig = require('lspconfig')

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

lspconfig.lua_ls.setup({
    -- From neodev config example
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    },
})
