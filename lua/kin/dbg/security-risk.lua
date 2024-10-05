local dap = require("dap")

local function is_spying_disabled()
    local spying_is_disabled = tonumber(vim.fn.readfile("/proc/sys/kernel/yama/ptrace_scope")[1]) == 1
    if not spying_is_disabled then
        vim.notify([[
Spying on other processes is still enabled

To disable spying on other processes run the following command:

echo 1 | sudo tee /proc/sys/kernel/yama/ptrace_scope

It has been copied to the `s` register for convienence
        ]], vim.log.levels.WARN)
        vim.fn.setreg('s', "echo 1 | sudo tee /proc/sys/kernel/yama/ptrace_scope")
    end
end

local function is_spying_enabled()
    local spying_is_enabled = tonumber(vim.fn.readfile("/proc/sys/kernel/yama/ptrace_scope")[1]) == 0
    if not spying_is_enabled then
        vim.notify([[
Spying on other processes is not enabled

To enable spying on other processes so gdb can attach to other processes run the
following command:

echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope

It has been copied to the `s` register for convienence
        ]], vim.log.levels.WARN)
        vim.fn.setreg('s', "echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope")
    end
end

dap.listeners.before.attach.spying = is_spying_enabled
dap.listeners.after.event_exited.spying = is_spying_disabled
