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

	{ -- Treesitter
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function ()
            require('nvim-treesitter.configs').setup({
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                }
            })
        end
    },

    -- Tmux Integration
    'anakin4747/vim-tmux-nav-lua',
    -- 'christoomey/vim-tmux-navigator',

	{ -- Colorscheme
		'ellisonleao/gruvbox.nvim',
		name = 'gruvbox',
		config = function ()
			vim.o.background = 'dark'
			vim.cmd('colorscheme gruvbox')
			-- Enable opacity
			vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
		end,
	},

	{ -- Comments - gc to comment
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
		end
	},

    -- -- LSP 
    -- 'neovim/nvim-lspconfig',
    --
    -- requires = {
    --     {'williamboman/mason.nvim'},
    --     {'williamboman/mason-lspconfig.nvim'},
    --     {'folke/neodev.nvim'},
    -- }
             
    -- -- Completion
    -- 'hrsh7th/cmp-path',
    -- use('hrsh7th/nvim-cmp')
    -- use('hrsh7th/cmp-buffer')
    -- use('hrsh7th/cmp-cmdline')
    -- use('saadparwaiz1/cmp_luasnip')
    -- use('hrsh7th/cmp-nvim-lsp')

    -- -- Snippets
    -- use('L3MON4D3/LuaSnip')
    -- use('rafamadriz/friendly-snippets')

})
