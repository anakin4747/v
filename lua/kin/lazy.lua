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
			vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' }) -- Enable opacity
		end,
	},

	{ -- Comments - gc to comment
		'numToStr/Comment.nvim',
		lazy = false,
		config = function ()
			require('Comment').setup()
		end
	},

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- LSPs
    'neovim/nvim-lspconfig',
    { 'folke/neodev.nvim', opts = {} },

    -- Debug Integration
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    {
        'theHamsta/nvim-dap-virtual-text',
        config = function ()
            require('nvim-dap-virtual-text').setup()
        end,
    },
    {
        'williamboman/mason.nvim',
        config = function ()
            require('mason').setup()
        end,
    },

})
