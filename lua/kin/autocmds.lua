
-- Yank on Highlight
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
    desc = "Highlight text on yank"
})

-- Auto Unfold All Folds
vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('Unfold', { clear = true }),
    callback = function()
        if vim.o.foldmethod == 'indent' then vim.cmd('norm zR') end
    end,
    pattern = '*',
    desc = "Unfold all folds that get folded automatically by foldmethod=indent"
})

-- Make on Write for LaTeX files
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('LatexMake', { clear = true }),
    callback = function()
        local current_directory = vim.fn.expand('%:p:h')

        -- Check if a Makefile exists in the current directory
        local makefile_exists = vim.fn.filereadable(current_directory .. '/Makefile') == 1

        if makefile_exists then
            -- vim.cmd('silent make')
            vim.loop.spawn('make', {})

        else
            print("No Makefile found for LaTeX compilation")
        end
    end,
    pattern = '*.tex',  -- Trigger only on LaTeX file writes
    desc = "Run make on write if in a LaTeX file"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.winrestview(view)
    end,
    desc = "Remove trailing whitespace on write"
})



-- vim.api.nvim_create_autocmd("VimEnter", {
--     pattern = "*",
--     callback = function()
--         vim.fn.system("notify-send VimEnter")
--
--
--         if not parent_file_present and not child_file_present then
--             vim.fn.system([[
--                 notify-send \
--                     "Parent Nvim Session started" \
--                     "Create parent file flag"
--             ]])
--             return
--         end
--
--         if not child_file_present then
--             vim.fn.system([[
--                 notify-send \
--                     "Child Nvim Session started" \
--                     "Create child file flag"
--             ]])
--         end
--     end,
--     desc = ""
-- })
--
-- vim.api.nvim_create_autocmd("VimLeave", {
--     pattern = "*",
--     callback = function()
--         vim.fn.system("notify-send VimLeave")
--
--         if not child_file_present then
--             vim.fn.system([[
--                 notify-send \
--                     "Child Nvim Session started" \
--                     "Create child file flag"
--             ]])
--         end
--
--     end,
--     desc = ""
-- })

-- vim.notify(vim.fn.system("pstree"))
--[[

4 states with 2 flags

On VimEnter

P C
0 0 -> No Parent Flag, No Child flag -> In parent process -> create parent flag
0 1 -> No Parent Flag, Child flag present -> assert and error out
1 0 -> Parent Flag present, no child flag -> In childe process -> create child flag
1 1 -> Parent flag present, child flag present -> In grandchild? bad -> error out

On VimLeave

P C
0 0 -> No Parent Flag, No Child flag -> assert and error out
0 1 -> No Parent Flag, Child flag present -> assert and error out
1 0 -> Parent Flag present, no child flag -> in parent process -> remove parent flag
1 1 -> Parent flag present, child flag present -> in child process -> remove child flag

--]]
