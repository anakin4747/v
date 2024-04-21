
require('lspconfig').ltex.setup({})

local util = require 'lspconfig.util'

local language_id_mapping = {
    bib = 'bibtex',
    plaintex = 'tex',
    rnoweb = 'sweave',
    rst = 'restructuredtext',
    tex = 'latex',
    xhtml = 'xhtml',
    pandoc = 'markdown',
}

local bin_name = 'ltex-ls'

return {
    default_config = {
        cmd = { bin_name },
        filetypes = { 'bib', 'gitcommit', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex', 'pandoc', 'quarto', 'rmd' },
        root_dir = util.find_git_ancestor,
        single_file_support = true,
        get_language_id = function(_, filetype)
            local language_id = language_id_mapping[filetype]
            if language_id then
                return language_id
            else
                return filetype
            end
        end,
    },
    docs = {
        description = [[ yay -S ltex-ls-bin ]],
    },
}
