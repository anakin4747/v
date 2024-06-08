-- LSP init.lua
local lspconfig = require('lspconfig')

local default_ls_configs = {
    -- The file name in lua/lspconfig/server_configurations/*.lua
    -- https://github.com/neovim/nvim-lspconfig.git
    'autotools_ls',
    'awk_ls',
    'bashls',
    'bitbake_ls',
    'clangd',
    'cmake',
    'dockerls',
    -- 'ltex',
    -- 'mesonlsp',
    'pyright',
    'tsserver',
}

-- setup default lsp configs
for _, def_ls_cfg_file in ipairs(default_ls_configs) do
    lspconfig[def_ls_cfg_file].setup({})
end

local custom_config = {
    -- The file name in lua/lspconfig/server_configurations/*.lua
    'lua',
}

-- safely require all custom config files
for _, ls_cfg_file in ipairs(custom_config) do
    local success, err = pcall(require, 'kin.lsp.' .. ls_cfg_file)
    if success == false then
        local warning = 'lsp/init.lua: failed to require file: ' .. ls_cfg_file
        if debug == true then
            warning = warning .. ' \n ERROR: ' .. err
        end
        vim.notify(warning, vim.log.levels.WARN)
    end
end
