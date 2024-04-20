
-- -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
-- require("neodev").setup({
--     -- add any options here, or leave empty to use the default settings
-- })
--
-- -- then setup your lsp server as usual
-- local lspconfig = require('lspconfig')
--
-- -- example to setup lua_ls and enable call snippets
-- lspconfig.lua_ls.setup({
--     settings = {
--         Lua = {
--             completion = {
--                 callSnippet = "Replace"
--             }
--         }
--     }
-- })

vim.lsp.start({
    name = 'lua-server',
    cmd = { 'lua-language-server' },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- if client.server_capabilities.completionProvider then
        --     vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        -- end
        -- if client.server_capabilities.definitionProvider then
        --     vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        -- end
        -- if client.server_capabilities.hoverProvider then
        --     vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        -- end
    end,
})

-- vim.api.nvim_create_autocmd("LspDetach", {
--     callback = function(args)
--         -- local client = vim.lsp.get_client_by_id(args.data.client_id)
--     end,
-- })
--
-- vim.api.nvim_create_autocmd('LspTokenUpdate', {
--     callback = function(args)
--         local token = args.data.token
--         if token.type == 'variable' and not token.modifiers.readonly then
--             vim.lsp.semantic_tokens.highlight_token(
--                 token, args.buf, args.data.client_id,
--                 'MyMutableVariableHighlight'
--             )
--         end
--     end,
-- })

vim.lsp.buf_attach_client(0, vim.lsp.get_active_clients())
