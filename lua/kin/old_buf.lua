local M = {}

Old_terminal_buf = {}
Old_non_term_buf = {}

function M.get_old_buf(terminal_bufs)
    local tabpage = vim.api.nvim_get_current_tabpage()
    local buf

    if terminal_bufs then
        buf = Old_terminal_buf[tabpage]
    else
        buf = Old_non_term_buf[tabpage]
    end

    if buf == nil then return nil end

    if not vim.api.nvim_buf_is_valid(buf) then return nil end

    if not vim.bo[buf].buflisted then return nil end

    return buf
end

function M.set_old_buf(bufnr, terminal_bufs)
    local tabpage = vim.api.nvim_get_current_tabpage()
    if terminal_bufs then
        Old_terminal_buf[tabpage] = bufnr
    else
        Old_non_term_buf[tabpage] = bufnr
    end
    return bufnr
end

return M
