
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('TerminalOptionsGroup', { clear = true }),
    callback = function()
        vim.cmd 'setlocal nonumber | setlocal norelativenumber'
    end, pattern = '*',
})

