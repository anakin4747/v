
-- Yank on Highlight
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

-- Auto Unfold All Folds
vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('Unfold', { clear = true }),
    callback = function()
        vim.cmd('norm zR')
    end,
    pattern = '*',
})

-- Make on Write for LaTeX files
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('LatexMake', { clear = true }),
    callback = function()
        local current_directory = vim.fn.expand('%:p:h')

        -- Check if a Makefile exists in the current directory
        local makefile_exists = vim.fn.filereadable(current_directory .. '/Makefile') == 1

        if makefile_exists then
            vim.cmd('silent make')
        else
            print("No Makefile found for LaTeX compilation")
        end
    end,
    pattern = '*.tex',  -- Trigger only on LaTeX file writes
})
