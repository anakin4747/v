
local term_group = vim.api.nvim_create_augroup('TerminalOptionsGroup', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
    group = term_group,
    callback = function()
        vim.api.nvim_exec2([[
            setlocal nonumber
            setlocal norelativenumber
            setlocal laststatus=0
        ]], {})
    end,
    desc = 'Set terminal specific options',
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = term_group,
    command = 'setlocal laststatus=0',
    pattern = 'term://*',
    desc = 'Disable status line if entering a terminal buffer',
})

vim.api.nvim_create_autocmd('BufLeave', {
    group = term_group,
    command = 'setlocal laststatus=2',
    pattern = 'term://*',
    desc = 'Enable status line if leaving a terminal buffer',
})
