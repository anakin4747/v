-- Bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',

    'nvim-telescope/telescope.nvim', -- requires rip-grep
    -- TODO: Figure out how to bootstrap rip-grep
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },

    -- Tmux Integration
    'anakin4747/vim-tmux-nav-lua', -- 'christoomey/vim-tmux-navigator',

	{ -- Colorscheme
		'ellisonleao/gruvbox.nvim',
		name = 'gruvbox',
		config = function ()
			vim.o.background = 'dark'
			vim.cmd('colorscheme gruvbox')
			vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }) -- Enable opacity
		end,
	},

	{ -- Comments - gc to comment
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
		end
	},

    -- 'neovim/nvim-lspconfig',
    --
    -- { 'folke/neodev.nvim', opts = {} },


})
