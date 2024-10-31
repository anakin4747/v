
--- Get a list of tab local buffers
---@param terminal_bufs? boolean|nil only get terminal or non-terminal buffers
---@return table tab local buffers
local function get_tab_local_bufs(terminal_bufs)

    local tab_local_bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if not vim.bo[buf].buflisted then
            goto continue -- skip buffer if unlisted
        end

        if terminal_bufs == nil then
            table.insert(tab_local_bufs, buf)
        elseif terminal_bufs then
            if vim.bo[buf].buftype == 'terminal' then
                table.insert(tab_local_bufs, buf)
            end
        else -- only non-terminal buffers
            if vim.bo[buf].buftype ~= 'terminal' then
                table.insert(tab_local_bufs, buf)
            end
        end

        ::continue::
    end
    return tab_local_bufs
end

--- REMOVE this after confirming get_tab_local_bufs always returns a sorted
--- array
--- Asserts that the table is an array of numbers sorted in ascending order.
---@param tbl table The table (array) to check.
---@return boolean True if the table is sorted, raises an error otherwise.
local function assert_sorted(tbl)
    assert(type(tbl) == 'table', 'Input must be a table')

    for i = 1, #tbl - 1 do
        assert(type(tbl[i]) == 'number', 'All elements must be numbers')
        if tbl[i] > tbl[i + 1] then
            error('Table is not sorted at index ' .. i)
        end
    end

    return true
end

local set_old_buf = require('kin.old_buf').set_old_buf
local get_old_buf = require('kin.old_buf').get_old_buf

--- Non wrapping next buffer
---@param terminal_bufs? boolean|nil move through terminal buffers if true, move
---through non-terminal buffers if false, move through any if nil
---@param move_rightously? boolean|nil default true for moving right
local function next_buf(terminal_bufs, move_rightously)
    if move_rightously == nil then move_rightously = true end
    -- cannot be written as `move_rightously = move_rightously or true` since nil and false
    -- are handled differently

    local bufs = get_tab_local_bufs(terminal_bufs)
    assert_sorted(bufs) -- REMOVE this after confirming get_tab_local_bufs always returns a sorted list

    if #bufs == 0 then return end -- No buffers to move to -> do nothing

    local cur_buf = vim.api.nvim_get_current_buf()

    if cur_buf == bufs[#bufs] and move_rightously then
        return -- if last buffer and moving right do nothing
    end

    if cur_buf == bufs[1] and not move_rightously then
        return -- if first buffer and moving left do nothing
    end

    --- Check if current buffer is in desired list of buffers
    ---@return boolean true if the current buffer is in the list, false otherwise.
    ---@return number|nil the index of the buffer in the list if found, nil otherwise.
    local function cur_buf_in_bufs()
        for i, buf in pairs(bufs) do
            if buf == cur_buf then return true, i end
        end
        return false
    end

    local cur_buf_is_in_bufs, idx = cur_buf_in_bufs()

    if not cur_buf_is_in_bufs then
        -- Goto old buffer in the desired list or first if nil
        local old_buf = get_old_buf(terminal_bufs) or bufs[1]
        vim.cmd('b' .. old_buf)
        return
    end

    set_old_buf(cur_buf, terminal_bufs)

    if move_rightously then
        vim.cmd('b' .. bufs[idx+1])
        return
    end

    vim.cmd('b' .. bufs[idx-1])
end

return next_buf
