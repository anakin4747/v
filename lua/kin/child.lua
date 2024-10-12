
-- local function file_exists(filename)
--     local file = io.open(filename, 'r')
--     if (file) then file:close() return true end
--     return false
-- end
--
-- if not file_exists(global_pipe) then return end

local global_pipe = '/tmp/nvim.pipe'
local channel = vim.fn.sockconnect('pipe', global_pipe, { rpc = true })

vim.fn.rpcrequest(channel, 'nvim_command', 'echom "helly"')

-- vim.fn.rpcrequest(channel, 'nvim_del_keymap', 't', '<esc><esc>')
