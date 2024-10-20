
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

--- Non wrapping next buffer
---@param terminal_bufs? boolean|nil move through terminal buffers if true, move
---through non-terminal buffers if false, move through any if nil
---@param direction? boolean|nil default true for moving right
local function next_buf(terminal_bufs, direction)
    if direction == nil then direction = true end
    -- cannot be written as `direction = direction or true` since nil and false
    -- are handled differently

    local bufs = get_tab_local_bufs(terminal_bufs)
    if #bufs == 0 then return end -- No buffers to move to -> do nothing
    assert_sorted(bufs) -- REMOVE this after confirming get_tab_local_bufs always returns a sorted

    local cur_buf = vim.api.nvim_get_current_buf()

    -- print('\n\n')
    -- print('cur_buf', cur_buf)
    -- print('bufs', vim.inspect(bufs))
    -- print('num_of_bufs', num_of_bufs)

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

    -- print(buf_is_in_bufs, idx)

    if not cur_buf_is_in_bufs then
        -- TODO: add a way to jump to previous buffer in the desired list
        -- instead of just the first
        vim.cmd('b' .. bufs[1]) -- Goto left-most buffer in requested buftype list
        -- print('Current buffer not in requested buffers')
        return
    end

    if cur_buf == bufs[#bufs] and direction then
        -- print(direction)
        -- print('cur_buf is last buf')
        return
    end

    if cur_buf == bufs[1] and not direction then
        -- print('cur_buf is first buf')
        return
    end

    -- print('move to cur_buf's index+1')

    if direction then
        -- print(direction, idx)
        vim.cmd('b' .. bufs[idx+1])
        return
    end

    -- print(idx)
    vim.cmd('b' .. bufs[idx-1])
end

return next_buf
