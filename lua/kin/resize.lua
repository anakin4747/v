
local function resize_by_dir(direction, amount)

    local current_win = vim.api.nvim_get_current_win()
    local windows = vim.api.nvim_list_wins()
    local window_coords = {}
    for _, win in ipairs(windows) do
        local win_info = vim.api.nvim_win_get_position(win)
        table.insert(window_coords,
            { id = win, row = win_info[1], col = win_info[2] }
        )
    end

    local sorting_func = function () end

    if direction == "up" or direction == "down" then
        sorting_func = function (a, b) return a.row < b.row end
    elseif direction == "left" or direction == "right" then
        sorting_func = function (a, b) return a.col < b.col end
    end

    table.sort(window_coords, sorting_func)

    local cur_win_idx = 0
    for i, win in ipairs(window_coords) do
        if win.id == current_win then
            cur_win_idx = i
        end
    end

    -- print(vim.inspect(window_coords))
    -- print("selected")
    -- print(vim.inspect(window_coords[cur_win_idx]))

    local function is_top_win()
        return window_coords[cur_win_idx].row == window_coords[1].row
    end

    local function is_bottom_win()
        return window_coords[cur_win_idx].row == window_coords[#window_coords].row
    end

    local function is_left_win()
        return window_coords[cur_win_idx].col == window_coords[1].col
    end

    local function is_right_win()
        return window_coords[cur_win_idx].col == window_coords[#window_coords].col
    end

    if direction == "up" then
        if is_top_win() then
            -- print("top")
            vim.cmd("resize -" .. amount)
        elseif is_bottom_win() then
            -- print("bottom")
            vim.cmd("resize +" .. amount)
        end
    elseif direction == "down" then
        if is_top_win() then
            -- print("top")
            vim.cmd("resize +" .. amount)
        elseif is_bottom_win() then
            -- print("bottom")
            vim.cmd("resize -" .. amount)
        end
    elseif direction == "left" then
        if is_left_win() then
            -- print("left")
            vim.cmd("vert resize -" .. amount)
        elseif is_right_win() then
            -- print("right")
            vim.cmd("vert resize +" .. amount)
        end
    elseif direction == "right" then
        if is_left_win() then
            -- print("left")
            vim.cmd("vert resize +" .. amount)
        elseif is_right_win() then
            -- print("right")
            vim.cmd("vert resize -" .. amount)
        end
    else
        print("Invalid direction")
    end

    -- in left windows
    -- h is :vert resize -amount
    -- l is :vert resize +amount

    -- in right windows
    -- h is :vert resize +amount
    -- l is :vert resize -amount

    -- in top windows
    -- j is :resize +amount
    -- k is :resize -amount

    -- in bottom windows
    -- j is :resize -amount
    -- k is :resize +amount

    -- print(vim.inspect(window_coords))

    -- local current_win = vim.api.nvim_get_current_win()
    -- local current_win_height = vim.api.nvim_win_get_height(current_win)
    -- local current_win_width = vim.api.nvim_win_get_width(current_win)
    --
    -- if direction == "up" then
    --     vim.api.nvim_win_set_height(current_win, current_win_height - amount)
    -- elseif direction == "down" then
    --     vim.api.nvim_win_set_height(current_win, current_win_height + amount)
    -- elseif direction == "left" then
    --     vim.api.nvim_win_set_width(current_win, current_win_width + amount)
    -- elseif direction == "right" then
    --     vim.api.nvim_win_set_width(current_win, current_win_width - amount)
    -- else
    --     print("Invalid direction")
    -- end
end


local function toggle_resize_mode()

    if vim.g.resize == nil then
        vim.g.resize = true
    end

    if vim.g.resize then

        if #vim.api.nvim_list_wins() == 1 then
            print("resize: only one window")
        end

        vim.keymap.set("n", "h", function () resize_by_dir("left", 4) end)
        vim.keymap.set("n", "j", function () resize_by_dir("down", 4) end)
        vim.keymap.set("n", "k", function () resize_by_dir("up", 4) end)
        vim.keymap.set("n", "l", function () resize_by_dir("right", 4) end)
        vim.g.resize = false
    else
        vim.cmd("silent unmap h")
        vim.cmd("silent unmap j")
        vim.cmd("silent unmap k")
        vim.cmd("silent unmap l")
        vim.g.resize = true
    end
end

return toggle_resize_mode
