local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Leader becomes space
vim.g.mapleader = " "

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- -- Make space a nop
-- keymap('n', '<Space>', '<Nop>', opts)
-- keymap('v', '<Space>', '<Nop>', opts)

-- Insert Mode Mappings --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
