
local includes = {
    'kin.lsp.autotools',
    'kin.lsp.awk',
    'kin.lsp.bash',
    'kin.lsp.cmake',
    'kin.lsp.c',
    'kin.lsp.docker',
    'kin.lsp.javascript',
    'kin.lsp.keymaps',
    'kin.lsp.latex',
    'kin.lsp.lua',
    'kin.lsp.python',
}

-- Makes sure each file required exists and is syntatically correct
-- Great for still having functionality if part of your config breaks
for _, file in ipairs(includes) do
    local success, err = pcall(require, file)
    if success == false then
        vim.notify(
            'lsp/init.lua: failed to require file: ' .. file .. '\nerr: ' .. err,
            vim.log.levels.WARN
        )
    end
end
