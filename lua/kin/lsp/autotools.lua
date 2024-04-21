require('lspconfig').autotools_ls.setup({})
local util = require 'lspconfig.util'

local root_files = { 'configure.ac', 'Makefile', 'Makefile.am', '*.mk' }

return {
    default_config = {
        cmd = { 'autotools-language-server' },
        filetypes = { 'config', 'automake', 'make' },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
    },
    docs = {
        description = [[ yay -S autotools-language-server ]],
        default_config = {
            root_dir = root_files,
        },
    },
}
