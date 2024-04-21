
require('lspconfig').awk_ls.setup({})

return {
  default_config = {
    cmd = { 'awk-language-server' },
    filetypes = { 'awk' },
    single_file_support = true,
  },
  docs = {
    description = [[ yay -S awk-language-server ]],
  },
}
