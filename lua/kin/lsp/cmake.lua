require('lspconfig').cmake.setup({})

-- maybe checkout neocmakelsp its written in rust instead of typescript

local util = require 'lspconfig.util'

local root_files = {
    'CMakePresets.json',
    'CTestConfig.cmake',
    '.git',
    'build',
    'cmake'
}

return {
    default_config = {
        cmd = { 'cmake-language-server' },
        filetypes = { 'cmake' },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
        init_options = {
            buildDirectory = 'build',
        },
    },
    docs = {
        description = [[ yay -S cmake-language-server ]],
        default_config = {
            root_dir = [[root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake')]],
        },
    },
}
