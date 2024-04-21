-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local global_mappings = {
    { 'n', '<leader>e', vim.diagnostic.open_float },
    { 'n', '[d',        vim.diagnostic.goto_prev },
    { 'n', ']d',        vim.diagnostic.goto_next },
    { 'n', '<leader>q', vim.diagnostic.setloclist },
}

for _, mapping in ipairs(global_mappings) do
    vim.keymap.set(unpack(mapping))
end


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        local buffer_mappings = {
            { 'n',          'gD',         vim.lsp.buf.declaration,                                                 opts },
            { 'n',          'gd',         vim.lsp.buf.definition,                                                  opts },
            { 'n',          'gr',         vim.lsp.buf.references,                                                  opts },
            { 'n',          'gt',         vim.lsp.buf.type_definition,                                             opts },
            { 'n',          'gi',         vim.lsp.buf.implementation,                                              opts },
            { 'n',          'K',          vim.lsp.buf.hover,                                                       opts },
            { 'n',          '<C-k>',      vim.lsp.buf.signature_help,                                              opts },
            { 'n',          '<leader>r',  vim.lsp.buf.rename,                                                      opts },
            { 'n',          '<leader>wa', vim.lsp.buf.add_workspace_folder,                                        opts },
            { 'n',          '<leader>wr', vim.lsp.buf.remove_workspace_folder,                                     opts },
            { 'n',          '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts },
            { { 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,                                                 opts },
            { 'n',          '<leader>f',  function() vim.lsp.buf.format { async = true } end,                      opts },
        }

        for _, mapping in ipairs(buffer_mappings) do
            vim.keymap.set(unpack(mapping))
        end
    end,
})
