-- LSP init.lua
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

local includes = {
    'autotools_ls',
    'awk_ls',
    'bashls',
    'bitbake_ls',
    'clangd',
    'cmake',
    'dockerls',
    'ltex',
    'pyright',
    'tsserver',
}

for _, file in ipairs(includes) do
    lspconfig[file].setup({})
end
