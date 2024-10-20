-- Try to keep all keymaps here

vim.g.mapleader = ' '

local builtin = require('telescope.builtin')
local dap, dapui = require('dap'), require('dapui')
local cmp = require('cmp')

local navigate = require('kin.navigate')
local ZZ = require('kin.ZZ')
local next_buf = require('kin.next_buf')

-- nvim-cmp
cmp.setup({
    mapping = {
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
})

local global_keymaps = {
    -- { mode, lhs, rhs, description }

    -- Navigate buffers
    { {  'n', 'i', 'x', 'v' }, '<C-h>', function () next_buf(true, false)  end, 'Previous terminal buffer' },
    { {  'n', 'i', 'x', 'v' }, '<C-l>', function () next_buf(true, true)   end, 'Next terminal buffer' },
    { {  'n', 'i', 'x', 'v' }, '<S-h>', function () next_buf(false, false) end, 'Previous non-terminal buffer' },
    { {  'n', 'i', 'x', 'v' }, '<S-l>', function () next_buf(false, true)  end, 'Next non-terminal buffer' },

    -- Terminal
    { 't', '<esc><esc>', '<C-\\><C-n>',           'Double <esc> to exit terminal mode' },
    { 'n', '<leader>t',  ':tabnew +terminal<cr>', 'Open a terminal' },
    { { 'n', 't', }, '<C-b>s', '<C-\\><C-n>:split +terminal<cr>i',      'Open a terminal below' },
    { { 'n', 't', }, '<C-b>v', '<C-\\><C-n>:vert split +terminal<cr>i', 'Open a terminal on the right' },
    { 't', '<C-w>', '<C-\\><C-n><C-w>', 'Terminal wincmds passthrough' },
    -- { 't', '<C-y>', '<C-\\><C-n><C-y>', 'Terminal escape when scrolling with C-y or trackpad' },
    -- { 't', '<C-e>', '<C-\\><C-n><C-e>', 'Terminal escape when scrolling with C-e or trackpad' },
    { 't', '<C-o>', '<C-\\><C-n><C-o>', 'Terminal escaped C-o' },
    -- { 't', 'kk', '<C-\\><C-n>k', 'Typing kk in the terminal breaks out of terminal mode' },

    -- Navigate windows
    { { 'n', 'i', 'v', 'x', 't', }, '<M-h>', function () navigate('h') end, 'Move to left window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-j>', function () navigate('j') end, 'Move to lower window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-k>', function () navigate('k') end, 'Move to higher window' },
    { { 'n', 'i', 'v', 'x', 't', }, '<M-l>', function () navigate('l') end, 'Move to right window' },

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
    { 'n', '<leader>au',    builtin.autocommands, 'Telescope :autocmds' },
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
    { 'n', '<leader>rg',    builtin.registers,    'Telescope :registers' },
    -- { 'n', '<leader>ts',    builtin.treesitter,   'Telescope treesitter symbols' },

    -- Diagnostics
    { 'n', '<leader>e', vim.diagnostic.open_float, 'Open diagnostics in floating window' },
    { 'n', '<leader>et', builtin.diagnostics, 'Open diagnostics in telescope window' },
    { 'n', '[d',        vim.diagnostic.goto_prev,  'Go to previous error' },
    { 'n', ']d',        vim.diagnostic.goto_next,  'Go to next error' },
    -- { 'n', '<leader>q', vim.diagnostic.setloclist, 'idk' },

    -- Debugging
    { 'n', '<leader>dc', dap.continue,          'Debug: Start or continue debugging' },
    { 'n', '<leader>dn', dap.step_over,         'Debug: Step over' },
    { 'n', '<leader>di', dap.step_into,         'Debug: Step into' },
    { 'n', '<leader>do', dap.step_out,          'Debug: Step out' },
    { 'n', '<leader>db', dap.toggle_breakpoint, 'Debug: Toggle breakpoint' }, -- TODO add logic to set signcolumn = 'no' if there are no more brkpnts
    { 'n', '<leader>dr', dap.repl.open,         'Debug: Open debugger REPL' },
    { 'n', '<leader>uo', dapui.open,            'Debug: Open UI' },
    { 'n', '<leader>uc', dapui.close,           'Debug: Close UI' },
    { 'n', '<leader><C-k>', function () dapui.eval(nil, { enter = true}) end, 'Debug: Evaluate at cursor' },

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
    --         ls.jum(-1)
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

for i = 1, 9 do
    local opts = { noremap = true, silent = true, desc = "Move to " .. i .. " tabpage" }
    vim.keymap.set(
        { 'n', 't', 'v', 'i', 'x' },
        ('<M-%d>'):format(i),          -- Alt+[1-9]
        ('<C-\\><C-n>%dgt'):format(i), -- goto tab [1-9] (needs terminal escaping)
        opts
    )
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
            { 'n', 'grt',       builtin.lsp_references, 'LSP: Get references in Telescope window' },
            { 'n', 'gt',        b.type_definition, 'LSP: Go to type definition' },
            { 'n', 'gtt',       builtin.lsp_type_definitions, 'LSP: Go to type definition' },
            { 'n', 'gi',        builtin.lsp_implementations,  'LSP: Go to implementation' },
            { 'n', 'K',         b.hover,           'LSP: Hover documentation' },
            { 'n', '<C-k>',     b.signature_help,  'LSP: Signature help' },
            { 'n', '<leader>r', b.rename,          'LSP: Project global rename' },
            -- { 'n', '<leader>f', function() b.format { async = true } end, 'LSP: Format' },

            { 'n', '<leader>fs', builtin.lsp_document_symbols, 'LSP: document symbols in Telescope window' },
            { 'n', '<leader>ws', builtin.lsp_workspace_symbols, 'LSP: workspace symbols in Telescope window' },
            { 'n', '<leader>ic', builtin.lsp_incoming_calls,   'LSP: incoming calls in Telescope window' },
            { 'n', '<leader>oc', builtin.lsp_outgoing_calls,   'LSP: outgoing calls in Telescope window' },

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
