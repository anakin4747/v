require('lspconfig').ccls.setup({})

local util = require('lspconfig.util')

local root_files = {
    'compile_commands.json',
    '.ccls',
}

return {
    default_config = {
        cmd = { 'ccls' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        offset_encoding = 'utf-32',
        -- ccls does not support sending a null root directory
        single_file_support = false,
    },
    docs = {
        description = [[ sudo pacman -S ccls ]],
        default_config = {
            root_dir = [[root_pattern('compile_commands.json', '.ccls', '.git')]],
        },
    },
}

