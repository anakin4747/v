
local dap = require("dap")
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.defaults.fallback.external_terminal = {
    command = '/usr/local/bin/st',
    args = { '-e' }
}
dap.defaults.fallback.force_external_terminal = true


local gdb_cfg = {
    {
        -- Do this before debugging an external process
        -- echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = 'Attach to neovim',
        type = 'gdb',
        request = 'attach',
        pid = function ()
            local output = vim.fn.system(vim.fn.expand('~/src/neovim/dbg.sh'))
            local pid = tonumber(output)
            assert(type(pid) == "number", "gdb.lua: dbg.sh did not print a number")
            return tonumber(pid)
        end,
    },
    {
        name = 'launch neovim',
        type = 'gdb',
        request = 'launch',
        program = '/home/kin/src/neovim/build/bin/nvim',
        externalConsole = true
    },
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
    },
}

dap.configurations.c = gdb_cfg
dap.configurations.cpp = gdb_cfg
