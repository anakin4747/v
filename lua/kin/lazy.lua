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

    -- Telescope
    'nvim-telescope/telescope.nvim', -- requires rip-grep
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },

    'mbbill/undotree',

    'tpope/vim-fugitive',

    -- Tmux Integration
    'anakin4747/vim-tmux-nav-lua',
    -- 'christoomey/vim-tmux-navigator',

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
		'numToStr/Comment.nvim', lazy = false,
		config = function () require('Comment').setup() end
	},

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'chrisbra/unicode.vim', -- Emojis and digraphs
    'saadparwaiz1/cmp_luasnip',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    -- LSP
    'neovim/nvim-lspconfig',
    { 'p00f/clangd_extensions.nvim' },
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

    -- Tab local buffers
    'tiagovla/scope.nvim',

    {
        'williamboman/mason.nvim',
        config = function ()
            require('mason').setup()
        end,
    },

    -- 'nvim-treesitter/nvim-treesitter-context',

})
