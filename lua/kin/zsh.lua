
local zsh_autocd_hook = [[

############################################################
# Needed for Neovim as a terminal multiplexer              #
############################################################
neovim_autocd() {
    [ $NVIM ] && nvim --server $NVIM --remote-send "<C-\\><C-N>:silent cd $PWD<CR>i"
}
chpwd_functions+=( neovim_autocd )
############################################################

]]

local zshrc_path = vim.fn.expand('~/.zshrc')

-- If neovim_autocd is in zshrc exit
if vim.fn.system({ 'grep', 'neovim_autocd', zshrc_path }) ~= "" then
    return
end

vim.notify("neovim_autocd hook is not in ~/.zshrc", vim.log.levels.WARN)

local zshrc_file, open_err = io.open(zshrc_path, "a")

if not zshrc_file then
    vim.notify("Could not open ~/.zshrc for appending: " .. (open_err or "Unknown error"), vim.log.levels.ERROR)
    return
end

vim.notify("Writing neovim_autocd hook in ~/.zshrc", vim.log.levels.INFO)

local write_status, write_err = zshrc_file:write(zsh_autocd_hook)

if not write_status then
    vim.notify("Could not write neovim_autocd hook to ~/.zshrc: " .. (write_err or "Unknown error"), vim.log.levels.ERROR)
end

zshrc_file:close()
