-- Try to keep all keymaps here
--
-- Only other place for sure that they are set are in my tmux plugin and
-- cmp.lua


vim.g.mapleader = " "

local builtin = require('telescope.builtin')
-- local ls = require('luasnip')
local dap, dapui = require("dap"), require("dapui")
-- local ui_widgets = require('dap.ui.widgets')

local gf_callback = require("kin.gf_callback")

local global_keymaps = {
    -- { mode, lhs, rhs, description }

    -- Navigate buffers
    { "n", "<S-l>", ":bnext<CR>", "Go to next buffer" },
    { "n", "<S-h>", ":bprevious<CR>", "Go to previous buffer" },

    { { 'n', 'i', 'v', 'x', }, '<M-h>', '<C-w>h', 'Move to left window' },
    { { 'n', 'i', 'v', 'x', }, '<M-j>', '<C-w>j', 'Move to lower window' },
    { { 'n', 'i', 'v', 'x', }, '<M-k>', '<C-w>k', 'Move to higher window' },
    { { 'n', 'i', 'v', 'x', }, '<M-l>', '<C-w>l', 'Move to right window' },

    -- Goto file
    { 'n', 'gf', gf_callback, 'PWD aware goto file' },

    -- Terminal
    { 't', '<M-h>', '<C-\\><C-n><C-w>h', "Exit terminal and move left" },
    { 't', '<M-j>', '<C-\\><C-n><C-w>j', "Exit terminal and move down" },
    { 't', '<M-k>', '<C-\\><C-n><C-w>k', "Exit terminal and move up" },
    { 't', '<M-l>', '<C-\\><C-n><C-w>l', "Exit terminal and move right" },
    { 't', '<esc><esc>', '<C-\\><C-n>',  "Double <esc> to exit terminal mode" },
    { 'n', '<leader>t', ':terminal<cr>', "Open a terminal" },

    -- Toggle crosshair
    { "n", "<leader>ch", ":set invcuc | set invcul<CR>", "Toggle crosshair" },

    -- Keep cursor postion with J
    { "n", "J", "mzJ`z", "Keeps cursor in place when using `J`" },

    -- Center after jumps
    { "n", "<C-d>", "<C-d>zz", "Center after <C-d>" },
    { "n", "<C-u>", "<C-u>zz", "Center after <C-u>" },
    { "n", "n", "nzzzv", "Center after next match" },
    { "n", "N", "Nzzzv", "Center after previous match" },


    -- Undotree
    { "n", "<leader>ut", vim.cmd.UndotreeToggle, "Toggle undotree" },

    -- Telescope
    { 'n', '<leader>&',     builtin.vim_options,  "Telescope Vim options" },
    { 'n', '<leader><C-o>', builtin.resume,       "Reopen last telescope window" },
    { 'n', '<leader>au',    builtin.autocommands, "Telescope :autocmd" },
    { 'n', '<leader>bu',    builtin.buffers,      "Telescope :buffers" },
    { 'n', '<leader>fd',    builtin.fd,           "Telescope !fd" },
    { 'n', '<leader>ff',    builtin.find_files,   "Telescope find files" },
    { 'n', '<leader>fg',    builtin.live_grep,    "Telescope live grep" },
    { 'n', '<leader>fh',    builtin.help_tags,    "Telescope help_tags" },
    { 'n', '<leader>gbc',   builtin.git_bcommits, "Telescope  current buffer's git commits" },
    { 'n', '<leader>gc',    builtin.git_commits,  "Telescope current git commits" },
    { 'n', '<leader>gf',    builtin.git_files,    "Telescope git files" },
    { 'n', '<leader>gr',    builtin.grep_string,  "Telescope grep -r word under cursor" },
    { 'n', '<leader>gs',    builtin.git_status,   "Telescope !git status" },
    { 'n', '<leader>km',    builtin.keymaps,      "Telescope keymaps" },
    { 'n', '<leader>m',     builtin.man_pages,    "Telescope man pages" },
    { 'n', '<leader>of',    builtin.oldfiles,     "Telescope :oldfiles" },
    { 'n', '<leader>qf',    builtin.quickfix,     "Telescope quickfix list" },
    { 'n', '<leader>rg',    builtin.registers,    "Telescope :registers" },
    -- { 'n', '<leader>ts',    builtin.treesitter,   "Telescope treesitter symbols" },

    -- Diagnostics
    { 'n', '<leader>e', vim.diagnostic.open_float, "Open diagnostics in floating window" },
    { 'n', '[d',        vim.diagnostic.goto_prev,  "Go to previous error" },
    { 'n', ']d',        vim.diagnostic.goto_next,  "Go to next error" },
    -- { 'n', '<leader>q', vim.diagnostic.setloclist, "idk" },

    -- Debugging
    { 'n', '<leader>c',  dap.continue,          "Start or continue debugging" },
    { 'n', '<leader>n',  dap.step_over,         "Debug: Step over" },
    { 'n', '<leader>si', dap.step_into,         "Debug: Step into" },
    { 'n', '<leader>so', dap.step_out,          "Debug: Step out" },
    { 'n', '<leader>b',  dap.toggle_breakpoint, "Debug: Toggle breakpoint" }, -- TODO add logic to set signcolumn = "no" if there are no more brkpnts
    { 'n', '<leader>dr', dap.repl.open,         "Open debugger REPL" },

    --- Debugging UI
    { 'n', '<leader>uo', dapui.open,  "Open debugger UI" },
    { 'n', '<leader>uc', dapui.close, "Close debugger UI" },

    -- TODO Learn these first before implementing them
    -- { 'n', '<leader>lp', function()
    --     dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    -- end, opts },
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
    local mode, lhs, rhs, desc = unpack(keymap)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
end


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local b = vim.lsp.buf

        local buffer_keymaps = {
            -- { mode, lhs, rhs, description }
            { 'n', 'gD',        b.declaration,     "LSP: Go to declaration" },
            { 'n', 'gd',        b.definition,      "LSP: Go to definition" },
            { 'n', 'gr',        b.references,      "LSP: Get references" },
            { 'n', 'gt',        b.type_definition, "LSP: Go to type definition" },
            { 'n', 'gi',        b.implementation,  "LSP: Go to implementation" },
            { 'n', 'K',         b.hover,           "LSP: Hover documentation" },
            { 'n', '<C-k>',     b.signature_help,  "LSP: Signature help" },
            { 'n', '<leader>r', b.rename,          "LSP: Project global rename" },
            { 'n', '<leader>f', function() b.format { async = true } end, "LSP: Format" },

            -- TODO: Figure out if you actually would use these
            -- { 'n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts },
            -- { 'n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts },
            -- { 'n', '<leader>wl', vim.lsp.buf.list_workspace_folders, opts },
            -- { 'n', '<leader>Ca', vim.lsp.buf.code_action, opts },
        }

        for _, keymap in ipairs(buffer_keymaps) do
            local mode, lhs, rhs, desc = unpack(keymap)
            local opts = { buffer = ev.buf, noremap = true, silent = true, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
    end,
})
