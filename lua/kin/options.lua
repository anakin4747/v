local options = {
    cmdheight = 1,                                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" },                 -- mostly just for cmp
    conceallevel = 0,                                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                                  -- the encoding written to a file
    hlsearch = false,                                        -- highlight all matches on previous search pattern
    incsearch = true,
    ignorecase = true,                                       -- ignore case in search patterns
    infercase = true,                                        -- allows completions to use the case you've already typed
    mouse = "",                                              -- allow the mouse to be used in neovim
    pumheight = 10,                                          -- pop up menu height
    showmode = false,                                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0,                                         -- always show tabs
    smartcase = true,                                        -- smart case
    smartindent = true,                                      -- make indenting smarter again
    splitbelow = true,                                       -- force all horizontal splits to go below current window
    splitright = true,                                       -- force all vertical splits to go to the right of current window
    swapfile = true,                                         -- creates a swapfile
    dir = vim.fn.expand("~/.local/share/nvim/swap") .. "//", -- specify swap dir
    backup = true,                                           -- enable backups
    backupcopy = "yes",                                      -- make a copy and overwrite the original
    writebackup = true,                                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    backupext = ".bak",                                      -- backup file extenstion
    backupdir = vim.fn.expand("~/.local/share/nvim/backup") .. "//",
    timeoutlen = 1000,                                       -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                                         -- enable persistent undo
    updatetime = 300,                                        -- faster completion (4000ms default)
    expandtab = true,                                        -- convert tabs to spaces
    shiftwidth = 4,                                          -- the number of spaces inserted for each indentation
    tabstop = 4,                                             -- insert 2 spaces for a tab
    cursorline = true,                                       -- highlight the current line
    cursorcolumn = true,                                     -- highlight the current line
    colorcolumn = "80",                                      -- vertical bar at 80
    textwidth = 79,
    number = true,                                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    numberwidth = 4,                                         -- set number column width to 2 {default 4}
    signcolumn = "number",                                   -- always show the sign column, otherwise it would shift the text each time
    wrap = false,                                            -- display lines as one long line
    -- wrapscan = false,                     -- searches wrap back to the top
    scrolloff = 9,                                           -- is one of my fav
    sidescrolloff = 0,
    termguicolors = true,                                    -- Provides more color options
    foldmethod = "indent",
    iskeyword = "a-z,A-Z,48-57,_",                           -- What characters count as part of a word
    -- spell = true,                         -- Spell Check, once you get better with it
    -- spelllang = "en_ca",
    shellcmdflag = "-ic", -- Allows the :! terminal to use my .zshrc
    autoread = true,
    clipboard = "unnamedplus",
}

--[[
Human mode options:
    paste
    mouse
--]]

for k, v in pairs(options) do
    vim.opt[k] = v
end
