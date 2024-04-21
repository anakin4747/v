
-- You can use nvim-dap events to open and close the windows automatically (:help dap-extensions)
local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- can these functions not just be the functions
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
