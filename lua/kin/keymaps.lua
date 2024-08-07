-- Try to keep all keymaps here

vim.g.mapleader = ' '

local builtin = require('telescope.builtin')
-- local ls = require('luasnip')
local dap, dapui = require('dap'), require('dapui')
-- local ui_widgets = require('dap.ui.widgets')

local tabscope = require('tabscope')

local function get_tab_local_bufs()
    local tab_local_bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted then
            -- tab_local_bufs:insert(buf)
            table.insert(tab_local_bufs, buf)
        end
    end
    return tab_local_bufs
end

local function ZZ()

    local buftype  = vim.api.nvim_get_option_value('buftype', {})
    local filetype = vim.api.nvim_get_option_value('filetype', {})
    local tabpage  = vim.api.nvim_get_current_tabpage()
    local windows  = vim.api.nvim_tabpage_list_wins(tabpage)

    if (buftype == 'help' and filetype == 'help') or buftype == 'nowrite' then

        if #windows ~= 1 then vim.api.nvim_win_close(0, true) end

        return
    end

    if buftype == 'terminal' then
        tabscope.remove_tab_buffer()
        -- If last window and buffer also quit to avoid annoying no name empty file
        if #windows == 1 and #get_tab_local_bufs() == 1 then vim.cmd('quit') end

        return
    end

    if filetype == 'gitcommit' then
        vim.cmd('write | quit')

        return
    end

    if buftype == 'nofile' and filetype == 'lspinfo' then
        -- LspInfo floating window
        vim.cmd('quit')

        return
    end

    vim.cmd('silent! write')
    tabscope.remove_tab_buffer()
end

local vim_to_awe = {
    h = 'left',
    j = 'down',
    k = 'up',
    l = 'right',
}

local function navigate(key)

    local initial_winnr = vim.w.winnr
    vim.cmd('wincmd ' .. key)

    if initial_winnr ~= vim.w.winnr then return end

    vim.fn.system([[
        awesome-client '
            local awful = require("awful")
            awful.client.focus.global_bydirection("]] .. vim_to_awe[key] .. [[")
        '
    ]])
end

local global_keymaps = {
    -- { mode, lhs, rhs, description }

    -- Navigate buffers
    { 'n', '<S-l>', ':bnext<CR>',     'Go to next buffer' },
    { 'n', '<S-h>', ':bprevious<CR>', 'Go to previous buffer' },

    -- Navigate tabs
    { { 'n', 't' }, '<C-l>', '<C-\\><C-n>:tabNext<CR>',     'Go to next tab' },
    { { 'n', 't' }, '<C-h>', '<C-\\><C-n>:tabprevious<CR>', 'Go to previous tab' },

    -- Terminal
    { 't', '<esc><esc>', '<C-\\><C-n>',           'Double <esc> to exit terminal mode' },
    { 'n', '<leader>t',  ':tabnew +terminal<cr>', 'Open a terminal' },
    { { 'n', 't', }, '<C-b>s', '<C-\\><C-n>:split +terminal<cr>i',      'Open a terminal below' },
    { { 'n', 't', }, '<C-b>v', '<C-\\><C-n>:vert split +terminal<cr>i', 'Open a terminal on the right' },

    -- Navigate windows
    { { 'n', 'i', 'v', 'x', 't', }, '<M-h>', function () navigate('h') end, 'Move to left window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-j>', function () navigate('j') end, 'Move to lower window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-k>', function () navigate('k') end, 'Move to higher window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-l>', function () navigate('l') end, 'Move to right window' },

    { 't', '<C-w>', '<C-\\><C-n><C-w>', 'Terminal wincmds passthrough' },

    -- Resize mode
    { 'n', '<leader>rs', require('kin.resize'), 'Toggle resize mode' },

    -- Goto file
    { 'n', 'gf', require('kin.gf_callback'), 'PWD aware goto file' },

    -- Toggle crosshair
    { 'n', '<leader>ch', ':set invcuc | set invcul<CR>', 'Toggle crosshair' },

    -- Keep cursor postion with J
    { 'n', 'J', 'mzJ`z', 'Keeps cursor in place when using `J`' },

    -- Center after jumps
    { 'n', '<C-d>', '<C-d>zz', 'Center after <C-d>' },
    { 'n', '<C-u>', '<C-u>zz', 'Center after <C-u>' },
    { 'n', 'n', 'nzzzv', 'Center after next match' },
    { 'n', 'N', 'Nzzzv', 'Center after previous match' },

    -- ZZ closes non-terminal buffers or single windows
    { 'n', 'ZZ', ZZ, 'ZZ only wq! for nested nvim instances' },

    -- Undotree
    { 'n', '<leader>ut', vim.cmd.UndotreeToggle, 'Toggle undotree' },

    -- Telescope
    { 'n', '<leader>&',     builtin.vim_options,  'Telescope Vim options' },
    { 'n', '<leader><C-o>', builtin.resume,       'Reopen last telescope window' },
    { 'n', '<leader>au',    builtin.autocommands, 'Telescope :autocmd' },
    { 'n', '<leader>bu',    builtin.buffers,      'Telescope :buffers' },
    { 'n', '<leader>fd',    builtin.fd,           'Telescope !fd' },
    { 'n', '<leader>ff',    builtin.find_files,   'Telescope find files' },
    { 'n', '<leader>fg',    builtin.live_grep,    'Telescope live grep' },
    { 'n', '<leader>ht',    builtin.help_tags,    'Telescope help_tags' },
    { 'n', '<leader>gc',    builtin.git_bcommits, 'Telescope current buffer\'s git commits' },
    { 'n', '<leader>gf',    builtin.git_files,    'Telescope git files' },
    { 'n', '<leader>gl',    builtin.git_commits,  'Telescope current git commits' },
    { 'n', '<leader>gr',    builtin.grep_string,  'Telescope grep -r word under cursor' },
    { 'n', '<leader>gs',    builtin.git_status,   'Telescope !git status' },
    { 'n', '<leader>km',    builtin.keymaps,      'Telescope keymaps' },
    { 'n', '<leader>m',     builtin.man_pages,    'Telescope man pages' },
    { 'n', '<leader>of',    builtin.oldfiles,     'Telescope :oldfiles' },
    { 'n', '<leader>qf',    builtin.quickfix,     'Telescope quickfix list' },
    { 'n', '<leader>rg',    builtin.registers,    'Telescope :registers' },
    -- { 'n', '<leader>ts',    builtin.treesitter,   'Telescope treesitter symbols' },

    -- Diagnostics
    { 'n', '<leader>e', vim.diagnostic.open_float, 'Open diagnostics in floating window' },
    { 'n', '[d',        vim.diagnostic.goto_prev,  'Go to previous error' },
    { 'n', ']d',        vim.diagnostic.goto_next,  'Go to next error' },
    -- { 'n', '<leader>q', vim.diagnostic.setloclist, 'idk' },

    -- Debugging
    { 'n', '<leader>c',  dap.continue,          'Start or continue debugging' },
    { 'n', '<leader>n',  dap.step_over,         'Debug: Step over' },
    { 'n', '<leader>si', dap.step_into,         'Debug: Step into' },
    { 'n', '<leader>so', dap.step_out,          'Debug: Step out' },
    { 'n', '<leader>b',  dap.toggle_breakpoint, 'Debug: Toggle breakpoint' }, -- TODO add logic to set signcolumn = 'no' if there are no more brkpnts
    { 'n', '<leader>dr', dap.repl.open,         'Open debugger REPL' },

    --- Debugging UI
    { 'n', '<leader>uo', dapui.open,  'Open debugger UI' },
    { 'n', '<leader>uc', dapui.close, 'Close debugger UI' },

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
    --         vim.notify('expand_or_jumpable', vim.log.levels.WARN)
    --     end
    --     ls.expand_or_jump()
    --     vim.notify('not expand_or_jumpable', vim.log.levels.WARN)
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
            { 'n', 'gD',        b.declaration,     'LSP: Go to declaration' },
            { 'n', 'gd',        b.definition,      'LSP: Go to definition' },
            { 'n', 'gr',        b.references,      'LSP: Get references' },
            { 'n', 'gt',        b.type_definition, 'LSP: Go to type definition' },
            { 'n', 'gi',        b.implementation,  'LSP: Go to implementation' },
            { 'n', 'K',         b.hover,           'LSP: Hover documentation' },
            { 'n', '<C-k>',     b.signature_help,  'LSP: Signature help' },
            { 'n', '<leader>r', b.rename,          'LSP: Project global rename' },
            -- { 'n', '<leader>f', function() b.format { async = true } end, 'LSP: Format' },

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
