-- TOP LEVEL init.lua

require('kin.lazy') -- Needs to be first for bootstrapping

local includes = {
    'autocmds',
    'cmp',
    'dbg',
    'help',
    'keymaps',
    'lsp',
    'options',
    -- 'snip',
    'telescope',
    'terminal',
    'treesitter',
    'zsh',
}

-- Makes sure each file required exists and is syntatically correct
-- Great for still having functionality if part of your config breaks
for _, file in ipairs(includes) do
    file = 'kin.' .. file
    local success, err = pcall(require, file)
    if success == false then
        local warning = 'init.lua: failed to require file: ' .. file
        warning = warning .. '\nERROR: ' .. err
        vim.notify(warning, vim.log.levels.WARN)
    end
end
