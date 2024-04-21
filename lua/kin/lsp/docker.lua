require('lspconfig').dockerls.setup({})
local util = require 'lspconfig.util'

return {
    default_config = {
        cmd = { 'docker-langserver', '--stdio' },
        filetypes = { 'dockerfile' },
        root_dir = util.root_pattern 'Dockerfile',
        single_file_support = true,
    },
    docs = {
        description = [[ yay -S dockerfile-language-server ]],
        default_config = {
            root_dir = [[root_pattern("Dockerfile")]],
        },
    },
}
