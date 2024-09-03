
local dap = require("dap")
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

local gdb_cfg = {
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
        name = 'Attach to gdbserver :3333',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:3333',
        program = '/tmp/temp/a.out',
        cwd = '${workspaceFolder}'
    },
    {
        name = 'Launch and Attach to gdbserver :3333',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:3333',
        program = function ()
            local program = '/tmp/temp/a.out'
            local server = 'gdbserver'

            -- kill gdbserver if already running
            if vim.fn.system('pgrep ' .. server) ~= "" then
                vim.fn.system('killall ' .. server)
            end

            vim.uv.spawn(server,
                { args = { 'localhost:3333', program } }
            )
            return program
        end,
        cwd = '${workspaceFolder}'
    },
}

dap.configurations.c = gdb_cfg
dap.configurations.cpp = gdb_cfg
