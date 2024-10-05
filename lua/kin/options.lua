local options = {
    backup = true,
    backupcopy = "yes",
    backupdir = vim.fn.expand("~/.local/share/nvim/backup") .. "//",
    backupext = ".bak",
    clipboard = "unnamedplus",
    cmdheight = 0,    -- EXPERIMENTAL hides cmdline
    -- colorcolumn = "80",    -- vertical bar at 80
    completeopt = { "menuone", "noselect" },
    -- cursorcolumn = true,    -- highlight the current line
    -- cursorline = true,    -- highlight the current line
    dir = vim.fn.expand("~/.local/share/nvim/swap") .. "//",
    expandtab = true,
    fileencoding = "utf-8",
    foldmethod = "indent",
    hlsearch = false,
    ignorecase = true,
    incsearch = true,
    infercase = true,    -- allows completions to use the case you've already typed
    iskeyword = "a-z,A-Z,48-57,_",    -- What characters count as part of a word
    laststatus = 0,    -- Hide status bar
    modeline = false,
    mouse = "",
    number = true,
    -- pumheight = 10,    -- pop up menu height
    relativenumber = true,
    ruler = false,    -- Hide cursor position at bottom right
    scrollback = 100000,
    scrolloff = 9,
    shellcmdflag = "-ic",    -- Allows the :! terminal to use my .zshrc
    shiftwidth = 4,    -- the number of spaces inserted for each indentation
    showcmd = false,
    showmode = false,
    showtabline = 0,
    sidescrolloff = 0,
    signcolumn = "number", -- no git signs in the gutter
    smartcase = true,
    smartindent = true,
    -- spell = true,    -- Spell Check, once you get better with it
    -- spelllang = "en_ca",
    splitbelow = true,
    splitright = true,
    swapfile = true,
    tabstop = 4,
    termguicolors = true,    -- Provides more color options (needed for crosshair to look good)
    textwidth = 79,
    undofile = true,    -- enable persistent undo
    updatetime = 300,    -- faster completion (4000ms default)
    virtualedit = "all",    -- Allows the cursor to go anywhere
    wrap = false,
    -- wrapscan = false,    -- searches wrap back to the top
    writebackup = true,    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
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
