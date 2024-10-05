--- DEBUG init.lua

local includes = {
    'autocmds',
    'bashdb',
    'dapui',
    'debugpy',
    'gdb',
    'security-risk',
}

-- Makes sure each file required exists and is syntatically correct
-- Great for still having functionality if part of your config breaks
for _, file in ipairs(includes) do
    file = 'kin.dbg.' .. file
    local success, err = pcall(require, file)
    if success == false then
        local warning = 'dbg/init.lua: failed to require file: ' .. file
        warning = warning .. '\nERROR: ' .. err
        vim.notify(warning, vim.log.levels.WARN)
    end
end

