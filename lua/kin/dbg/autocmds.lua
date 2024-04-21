
-- Below is an attempted remake of this so if autocomplete doen't work in the
-- repl this is why
-- au FileType dap-repl lua require('dap.ext.autocompl').attach()

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('ReplAutoCmp', { clear = true }),
    callback = function()
        require('dap.ext.autocompl').attach()
    end,
    pattern = 'dap-repl',
})
