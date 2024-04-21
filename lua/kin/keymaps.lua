local opts = { noremap = true, silent = true }

-- Leader becomes space
vim.g.mapleader = " "

local builtin = require('telescope.builtin')
local dap = require('dap')
local ui_widgets = require('dap.ui.widgets')

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
    { 'n', '<Leader>b',  dap.toggle_breakpoint },
    { 'n', '<Leader>B',  dap.set_breakpoint },

    { 'n', '<Leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end },
    { 'n',          '<Leader>dr', dap.repl.open },
    { 'n',          '<Leader>dl', dap.run_last },
    { { 'n', 'v' }, '<Leader>dh', ui_widgets.hover },
    { { 'n', 'v' }, '<Leader>dp', ui_widgets.preview },
    { 'n',          '<Leader>df', function() ui_widgets.centered_float(ui_widgets.frames) end },
    { 'n',          '<Leader>ds', function() ui_widgets.centered_float(ui_widgets.scopes) end },
}

for _, keymap in ipairs(global_keymaps) do
    vim.keymap.set(unpack(keymap))
end
