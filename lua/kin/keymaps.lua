local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
local dap, dapui = require("dap"), require("dapui")
-- local ui_widgets = require('dap.ui.widgets')

local global_keymaps = {

    -- Navigate buffers
    { "n", "<S-l>",      ":bnext<CR>",             opts },
    { "n", "<S-h>",      ":bprevious<CR>",         opts },

    -- Press jk fast to escape
    { "i", "jk",         "<ESC>",                  opts },

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
    { 'n',          '<leader>dr', dap.repl.open },
    { 'n',          '<leader>uo', dapui.open },
    { 'n',          '<leader>uc', dapui.close },
    -- TODO Learn these first before implementing them
    -- { 'n',          '<leader>dl', dap.run_last },
    -- { { 'n', 'v' }, '<leader>dh', ui_widgets.hover },
    -- { { 'n', 'v' }, '<leader>dp', ui_widgets.preview },
    -- { 'n',          '<leader>df', function() ui_widgets.centered_float(ui_widgets.frames) end },
    -- { 'n',          '<leader>ds', function() ui_widgets.centered_float(ui_widgets.scopes) end },
}

for _, keymap in ipairs(global_keymaps) do
    vim.keymap.set(unpack(keymap))
end
