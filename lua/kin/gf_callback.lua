
local function file_exists(filename)
    local file = io.open(filename, "r")
    if (file) then file:close() return true end
    return false
end

local function gf_callback()

    local cwd = ""

    local pid = vim.b.terminal_job_pid
    if pid ~= nil then
        local cwd_cmd = "readlink -e /proc/" .. pid .. "/cwd"
        cwd = vim.fn.system(cwd_cmd):sub(1, -2)
    else
        cwd = vim.loop.cwd() or ""
    end

    local cfile = vim.fn.expand("<cfile>")
    local abs_file_path = cwd .. "/" .. cfile

    --[[
    -- BUG:
    --  if you are in folder1 and want to open folder1/folder2/Makefile
    --  but there is a folder1/Makefile it will open that instead
    --]]
    if file_exists(abs_file_path) then
        vim.cmd("edit " .. abs_file_path)
        print("terminal.lua: gf_callback: opened `" .. cfile .. "` in cwd:`" .. cwd .. "`")
        return
    end

    -- Make here below async
    print("terminal.lua: gf_callback: not a complete path. SEARCHING " .. cwd)

    local find_cmd = ""

    if cfile:find('/') then
        -- print("terminal.lua: gf_callback: slashes in <cfile>")
        find_cmd = "find " .. cwd .. " -path '*" .. cfile .. "*' 2> /dev/null"
    else
        -- print("terminal.lua: gf_callback: no slashes in <cfile>")
        find_cmd = "find " .. cwd .. " -name " .. cfile .. " 2> /dev/null"
    end

    local find_stdout = vim.fn.system(find_cmd)

    -- print("\nSTDOUT\n")
    -- print(find_stdout)
    -- print("STDOUT END\n")

    local paths = vim.split(find_stdout, "\n")

    -- print(#lines)

    if #paths == 2 then
        vim.cmd("edit " .. paths[1])
        return
    end

    print("terminal.lua: gf_callback: more than one find")

    local qf_items = {}

    for i, path in ipairs(paths) do
        qf_items[i] = { filename = path }
    end

    -- get rid of last
    qf_items[#qf_items] = nil

    -- print("\nqf_items:\n")
    -- print(qf_items)
    -- print("qf_items: END\n")

    vim.fn.setqflist({}, ' ', {
        title = "goto file",
        items = qf_items
    })

    vim.cmd('copen')
end

return gf_callback
