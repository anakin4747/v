
-- You can use nvim-dap events to open and close the windows automatically (:help dap-extensions)
local dap, dapui = require("dap"), require("dapui")

dapui.setup()

local function dbg_open ()
    vim.opt.signcolumn = "yes"
    dapui.open()
end

local function dbg_close ()
    dapui.close()
    vim.opt.signcolumn = "no"
end

-- can these functions not just be the functions
dap.listeners.before.attach.dapui_config = dbg_open
dap.listeners.before.launch.dapui_config = dbg_open
dap.listeners.before.event_terminated.dapui_config = dbg_close
dap.listeners.before.event_exited.dapui_config = dbg_close
