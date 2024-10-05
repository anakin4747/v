-- You can use nvim-dap events to open and close the windows automatically (:help dap-extensions)
local dap, dapui = require("dap"), require("dapui")

dapui.setup({
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        -- {
        --     elements = {
        --         { id = "scopes", size = 0.25 },
        --         { id = "breakpoints", size = 0.25 },
        --         { id = "stacks", size = 0.25 },
        --         { id = "watches", size = 0.25 },
        --     },
        --     position = "left",
        --     size = 40,
        -- },
        {
            elements = {
                { id = "repl", size = 0.5 },
                -- { id = "console", size = 0.5 }
            },
            position = "bottom",
            size = 10,
        }
    },
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>", "ZZ" }
        }
    },
    controls = {
        element = "repl",
        enabled = false,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    render = {
        indent = 1,
        max_value_lines = 100
    },
    element_mappings = {},
    expand_lines = true,
    force_buffers = true,
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
})

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
