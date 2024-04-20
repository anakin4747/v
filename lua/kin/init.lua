
local includes = {
    'kin.lazy',
    'kin.autocmds',
    'kin.keymaps',
    'kin.lsps',
    'kin.options',
    'kin.telescope',
    'kin.treesitter',
}

-- Makes sure each file required exists and is syntatically correct
-- Great for still having functionality if part of your config breaks
for _, file in ipairs(includes) do
    local success, err = pcall(require, file)
    if success == false then
        vim.notify(
            'init.lua: failed to require file: ' .. file .. '\nerr: ' .. err,
            vim.log.levels.WARN
        )
    end
end
