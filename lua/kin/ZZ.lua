
local tabscope = require('tabscope')
local ob = require('kin.old_buf')

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

        local old_term_buf = ob.get_old_buf(true)
        if old_term_buf ~= nil then
            vim.cmd('b' .. old_term_buf)
        end
        return
    end

    if filetype == 'gitcommit' then
        vim.cmd('write | quit')
        return
    end

    if buftype == 'nofile' and filetype == 'lspinfo' then
        vim.cmd('quit')
        return
    end

    vim.cmd('silent! write')

    tabscope.remove_tab_buffer()

    local old_buf = ob.get_old_buf(false)
    print(old_buf)
    if old_buf ~= nil then
        vim.cmd('b' .. old_buf)
    end
end

return ZZ
