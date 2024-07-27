local options = {
    autoread = true,
    backup = true,                                           -- enable backups
    backupcopy = "yes",                                      -- make a copy and overwrite the original
    backupdir = vim.fn.expand("~/.local/share/nvim/backup") .. "//",
    backupext = ".bak",                                      -- backup file extenstion
    clipboard = "unnamedplus",
    cmdheight = 0, -- EXPERIMENTAL hides cmdline
    -- colorcolumn = "80",                                      -- vertical bar at 80
    completeopt = { "menuone", "noselect" },                 -- mostly just for cmp
    conceallevel = 0,                                        -- so that `` is visible in markdown files
    -- cursorcolumn = true,                                     -- highlight the current line
    -- cursorline = true,                                       -- highlight the current line
    dir = vim.fn.expand("~/.local/share/nvim/swap") .. "//", -- specify swap dir
    expandtab = true,                                        -- convert tabs to spaces
    fileencoding = "utf-8",                                  -- the encoding written to a file
    foldmethod = "indent",
    hlsearch = false,                                        -- highlight all matches on previous search pattern
    ignorecase = true,                                       -- ignore case in search patterns
    incsearch = true,
    infercase = true,                                        -- allows completions to use the case you've already typed
    iskeyword = "a-z,A-Z,48-57,_",                           -- What characters count as part of a word
    laststatus = 0, -- Hide status bar
    modeline = false,
    mouse = "",                                              -- allow the mouse to be used in neovim
    number = true,                                           -- set numbered lines
    numberwidth = 4,                                         -- set number column width to 2 {default 4}
    pumheight = 10,                                          -- pop up menu height
    relativenumber = true,                   -- set relative numbered lines
    ruler = false, -- Hide cursor position
    scrolloff = 9,                                           -- is one of my fav
    shellcmdflag = "-ic", -- Allows the :! terminal to use my .zshrc
    shiftwidth = 4,                                          -- the number of spaces inserted for each indentation
    showcmd = false,
    showmode = false,                                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0,                                         -- always show tabs
    sidescrolloff = 0,
    signcolumn = "number",                                   -- always show the sign column, otherwise it would shift the text each time
    smartcase = true,                                        -- smart case
    smartindent = true,                                      -- make indenting smarter again
    -- spell = true,                         -- Spell Check, once you get better with it
    -- spelllang = "en_ca",
    splitbelow = true,                                       -- force all horizontal splits to go below current window
    splitright = true,                                       -- force all vertical splits to go to the right of current window
    swapfile = true,                                         -- creates a swapfile
    tabstop = 4,                                             -- insert 2 spaces for a tab
    termguicolors = true,                                    -- Provides more color options
    textwidth = 79,
    timeoutlen = 1000,                                       -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                                         -- enable persistent undo
    updatetime = 300,                                        -- faster completion (4000ms default)
    wrap = false,                                            -- display lines as one long line
    -- wrapscan = false,                     -- searches wrap back to the top
    writebackup = true,                                      -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

--[[
Human mode options:
    paste
    mouse
--]]

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.o.shortmess = vim.o.shortmess .. "I"    -- Avoid intro message on startup
