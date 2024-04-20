
-- Yank on Highlight
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Auto Unfold All Folds
local autounfold_group = vim.api.nvim_create_augroup('Unfold', {})
vim.api.nvim_create_autocmd('BufRead', {
    callback = function()
        vim.cmd('norm zR')
    end,
    group = autounfold_group,
    pattern = '*',
})
