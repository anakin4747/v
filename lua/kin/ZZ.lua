
local tabscope = require('tabscope')

function Get_tab_local_bufs()
    local tab_local_bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted then
            table.insert(tab_local_bufs, buf)
        end
    end
    return tab_local_bufs
end

local function ZZ()
    local buftype  = vim.api.nvim_get_option_value('buftype', {})
    local filetype = vim.api.nvim_get_option_value('filetype', {})
    local tabpage  = vim.api.nvim_get_current_tabpage()
    local windows  = vim.api.nvim_tabpage_list_wins(tabpage)

    if (buftype == 'help' and filetype == 'help') or
        buftype == 'nowrite' then

        if #windows ~= 1 then vim.api.nvim_win_close(0, true) end

        return
    end

    if buftype == 'terminal' then
        tabscope.remove_tab_buffer()

        -- If last window and buffer also quit to avoid annoying no name empty file
        if #windows == 1 and #Get_tab_local_bufs() == 1 then
            vim.cmd('quit')
        end

        return
    end

    if filetype == 'gitcommit' then
        vim.cmd('write | quit')

        return
    end

    if buftype == 'nofile' and filetype == 'lspinfo' then
        -- LspInfo floating window
        vim.cmd('quit')

        return
    end

    vim.cmd('silent! write')
    local cur_buf = vim.api.nvim_get_current_buf()
    -- vim.cmd('b#') -- TODO: figure out how to make this not reopen closed
    -- files
    tabscope.remove_tab_buffer(cur_buf)
end

return ZZ
