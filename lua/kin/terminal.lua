
local term_group = vim.api.nvim_create_augroup('TerminalOptionsGroup', { clear = true })

local function set_term_buf_opts()
    vim.cmd [[
        setlocal modifiable nonumber norelativenumber
    ]]
    local cwd_cmd = "readlink -e /proc/" .. vim.b.terminal_job_pid .. "/cwd"
    local cwd = vim.fn.system(cwd_cmd):sub(1, -2)
    vim.cmd("cd " .. cwd)
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

local function unset_term_buf_opts()
    vim.cmd [[
        set scrolloff=9
    ]]
end

vim.api.nvim_create_autocmd('BufLeave', {
    group = term_group,
    callback = unset_term_buf_opts,
    pattern = 'term://*',
    desc = 'Disable terminal options when leaving a terminal buffer',
})
