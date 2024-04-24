-- Try to keep all keymaps here
--
-- Only other place for sure that they are set are in my tmux plugin and
-- cmp.lua

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
local ls = require('luasnip')
local dap, dapui = require("dap"), require("dapui")
-- local ui_widgets = require('dap.ui.widgets')

local global_keymaps = {

    -- Navigate buffers
    { "n", "<S-l>", ":bnext<CR>",     opts },
    { "n", "<S-h>", ":bprevious<CR>", opts },

    -- Press jk fast to escape
    { "i", "jk",    "<ESC>",          opts },

    { "n", "<leader>ut", vim.cmd.UndotreeToggle },

    -- Telescope keymaps
    { 'n', '<leader>ff', builtin.find_files,       opts },
    { 'n', '<leader>fg', builtin.live_grep,        opts },
    { 'n', '<leader>fb', builtin.buffers,          opts },
    { 'n', '<leader>fh', builtin.help_tags,        opts },
    { 'n', '<leader>km', builtin.keymaps,          opts },

    -- Diagnostics
    { 'n', '<leader>e',  vim.diagnostic.open_float },
    { 'n', '[d',         vim.diagnostic.goto_prev },
    { 'n', ']d',         vim.diagnostic.goto_next },
    { 'n', '<leader>q',  vim.diagnostic.setloclist },

    -- Debugging
    { 'n', '<leader>c',  dap.continue },
    { 'n', '<leader>n',  dap.step_over },
    { 'n', '<leader>si', dap.step_into },
    { 'n', '<leader>so', dap.step_out },
    { 'n', '<leader>b',  dap.toggle_breakpoint }, -- TODO add logic to set signcolumn = "no" if there are no more brkpnts

    { 'n', '<leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end },

    { 'n', '<leader>dr', dap.repl.open },
    { 'n', '<leader>uo', dapui.open },
    { 'n', '<leader>uc', dapui.close },
    -- TODO Learn these first before implementing them
    -- { 'n',          '<leader>dl', dap.run_last },
    -- { { 'n', 'v' }, '<leader>dh', ui_widgets.hover },
    -- { { 'n', 'v' }, '<leader>dp', ui_widgets.preview },
    -- { 'n',          '<leader>df', function() ui_widgets.centered_float(ui_widgets.frames) end },
    -- { 'n',          '<leader>ds', function() ui_widgets.centered_float(ui_widgets.scopes) end },

    -- TODO
    -- Snippets
    -- { { 'i', 's' }, '<c-l>', function()
    --     if ls.expand_or_jumpable() then
    --         vim.notify("expand_or_jumpable", vim.log.levels.WARN)
    --     end
    --     ls.expand_or_jump()
    --     vim.notify("not expand_or_jumpable", vim.log.levels.WARN)
    -- end, { silent = true } },
    --
    -- { { 'i', 's' }, '<c-j>', function()
    --     if ls.jumpable(-1) then
    --         ls.jump(-1)
    --     end
    -- end, { silent = true } },
    --
    -- { 'i', '<c-k>', function()
    --     if ls.choice_active() then
    --         ls.choice_active(1)
    --     end
    -- end, { silent = true } },
    -- { 'n', '<leader><leader>s', '<cmd>source ~/.arch.files/.config/nvim/lua/kin/snip.lua<CR>', },

}

for _, keymap in ipairs(global_keymaps) do
    vim.keymap.set(unpack(keymap))
end


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        local buffer_keymaps = {
            { 'n',          'gD',         vim.lsp.buf.declaration,                                                 opts },
            { 'n',          'gd',         vim.lsp.buf.definition,                                                  opts },
            { 'n',          'gr',         vim.lsp.buf.references,                                                  opts },
            { 'n',          'gt',         vim.lsp.buf.type_definition,                                             opts },
            { 'n',          'gi',         vim.lsp.buf.implementation,                                              opts },
            { 'n',          'K',          vim.lsp.buf.hover,                                                       opts },
            { 'n',          '<C-k>',      vim.lsp.buf.signature_help,                                              opts },
            { 'n',          '<leader>r',  vim.lsp.buf.rename,                                                      opts },
            { 'n',          '<leader>wa', vim.lsp.buf.add_workspace_folder,                                        opts },
            { 'n',          '<leader>wr', vim.lsp.buf.remove_workspace_folder,                                     opts },
            { 'n',          '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts },
            { { 'n', 'v' }, '<leader>Ca', vim.lsp.buf.code_action,                                                 opts },
            { 'n',          '<leader>f',  function() vim.lsp.buf.format { async = true } end,                      opts },
        }

        for _, keymap in ipairs(buffer_keymaps) do
            vim.keymap.set(unpack(keymap))
        end
    end,
})
