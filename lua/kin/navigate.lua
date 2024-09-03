
local vim_to_awe = {
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right',
}

local function navigate(key)

    local initial_winnr = vim.w.winnr
    vim.cmd('wincmd ' .. key)

    if initial_winnr ~= vim.w.winnr then return end

    vim.fn.system([[
        awesome-client '
            local awful = require("awful")
            awful.client.focus.global_bydirection("]] .. vim_to_awe[key] .. [[")
        '
    ]])
end

return navigate
