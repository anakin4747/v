
local term_group = vim.api.nvim_create_augroup('TerminalOptionsGroup', { clear = true })

local function set_term_buf_opts ()
    vim.cmd [[
        setlocal cmdheight=0 laststatus=0 modifiable nonumber norelativenumber noruler noshowcmd
    ]]
end

vim.api.nvim_create_autocmd('TermOpen', {
    group = term_group,
    callback = set_term_buf_opts,
    desc = 'Enable terminal options when opening a new terminal',
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = term_group,
    callback = set_term_buf_opts,
    pattern = 'term://*',
    desc = 'Enable terminal options when entering a terminal buffer',
})

local function unset_term_buf_opts ()
    vim.cmd [[
        set cmdheight=1 laststatus=2 ruler showcmd
    ]]
end

vim.api.nvim_create_autocmd('BufLeave', {
    group = term_group,
    callback = unset_term_buf_opts,
    pattern = 'term://*',
    desc = 'Disable terminal options when leaving a terminal buffer',
})
