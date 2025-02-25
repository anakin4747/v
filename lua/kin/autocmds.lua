
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

-- my attempt at replacing the `recording @` with a blinking cursor since you
-- hid it by a side effect of having a minimal UI
-- vim.api.nvim_create_autocmd("RecordingEnter", {
--     pattern = "*",
--     command = [[ 
--         set guicursor=n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175,i-ci-ve:ver25,r-cr-o:hor20, 
--     ]],
--     desc = "Blink cursor when starting a macro"
-- })
--
-- vim.api.nvim_create_autocmd("RecordingLeave", {
--     pattern = "*",
--     command = [[ set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20 ]],
--     desc = "Restore cursor default behaviour after end of macro"
-- })
