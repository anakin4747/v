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
    'ginko_ls',
    'gopls',
    -- 'ltex',
    'nil_ls',
    'basedpyright',
    'rust_analyzer',
    'tsserver',
    'vimls',
}

-- setup default lsp configs
for _, def_ls_cfg_file in ipairs(default_ls_configs) do
    lspconfig[def_ls_cfg_file].setup({})
end

local custom_config = {
    -- The file name in lua/lspconfig/server_configurations/*.lua
    'lua',
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- safely require all custom config files
for _, ls_cfg_file in ipairs(custom_config) do
    local success, err = pcall(require, 'kin.lsp.' .. ls_cfg_file)
    if success == false then
        local warning = 'lsp/init.lua: failed to require file: ' .. ls_cfg_file
        warning = warning .. '\nERROR: ' .. err
        vim.notify(warning, vim.log.levels.WARN)
    end
end

require('mason-tool-installer').setup({

    ensure_installed = {

        'autotools-language-server',
        'awk-language-server',
        'bash-language-server',
        'bash-debug-adapter',
        'lua-language-server',
        'shellcheck',
        'vim-language-server',

        -- 'ansible-language-server',
        -- 'ansible-lint',
        -- 'asm-lsp',
        -- 'asmfmt',
        -- 'ast-grep',
        -- 'basedpyright',
        -- 'clang-format',
        'cmake-language-server',
        -- 'cmakelang',
        -- 'cmakelint',
        -- 'cortex-debug',
        -- 'css-lsp',
        -- 'css-variables-language-server',
        -- 'cssmodules-language-server',
        'debugpy',
        'delve',
        -- 'docker-compose-language-service',
        'dockerfile-language-server',
        'ginko_ls',
        -- 'gitlab-ci-ls',
        -- 'go-debug-adapter',
        -- 'gofumpt',
        -- 'goimports',
        -- 'goimports-reviser',
        -- 'golangci-lint',
        -- 'golangci-lint-langserver',
        -- 'golines',
        -- 'gomodifytags',
        'gopls',
        -- 'gospel',
        -- 'gotests',
        -- 'gotestsum',
        -- 'grammarly-languageserver',
        'groovy-language-server',
        -- 'haskell-debug-adapter',
        -- 'haskell-language-server',
        -- 'html-lsp',
        -- 'htmx-lsp',
        -- 'java-debug-adapter',
        -- 'java-language-server',
        -- 'java-test',
        -- 'json-lsp',
        -- 'ltex-ls',
        'lua-language-server',
        -- 'markdown-oxide',
        -- 'markdown-toc',
        -- 'markdownlint',
        -- 'markdownlint-cli2',
        'mesonlsp',
        -- 'perl-debug-adapter',
        -- 'python-lsp-server',
        -- 'r-languageserver',
        -- 'rstcheck',
        'rust-analyzer',
        'shellcheck',
        -- 'shellharden',
        -- 'shfmt',
        -- 'sqlls',
        -- 'sqls',
        'tree-sitter-cli',
        'vim-language-server',
        -- 'yaml-language-server',
        -- 'yamlfix',
        -- 'yamlfmt',
        -- 'yamllint',

    },

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = true,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay

    -- Only attempt to install if 'debounce_hours' number of hours has
    -- elapsed since the last time Neovim was started. This stores a
    -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
    -- This is only relevant when you are using 'run_on_start'. It has no
    -- effect when running manually via ':MasonToolsInstall' etc....
    -- Default: nil
    debounce_hours = 5, -- at least 5 hours between attempts to install/update

    -- By default all integrations are enabled. If you turn on an integration
    -- and you have the required module(s) installed this means you can use
    -- alternative names, supplied by the modules, for the thing that you want
    -- to install. If you turn off the integration (by setting it to false) you
    -- cannot use these alternative names. It also suppresses loading of those
    -- module(s) (assuming any are installed) which is sometimes wanted when
    -- doing lazy loading.
    integrations = {
        ['mason-lspconfig'] = true,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = true,
    },
})
