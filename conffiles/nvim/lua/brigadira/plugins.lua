-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync',
})

return require('packer').startup({
    function(use)
        ---------------------
        -- Package Manager --
        ---------------------

        use('wbthomason/packer.nvim')

        ----------------------
        -- Required plugins --
        ----------------------

        use('nvim-lua/plenary.nvim')

        ----------------------------------------
        -- Theme, Icons, Statusbar, Bufferbar --
        ----------------------------------------
        -- use "lunarvim/colorschemes"
        use "lunarvim/darkplus.nvim"
        use "folke/tokyonight.nvim"

     	-- Cmp - Completions plugins 
        use {"hrsh7th/nvim-cmp",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
        use {"hrsh7th/cmp-buffer",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
        use {"hrsh7th/cmp-path",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
	    use {"saadparwaiz1/cmp_luasnip",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
        use {"L3MON4D3/LuaSnip",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
        use {"rafamadriz/friendly-snippets",
            config = function()
                require('brigadira.plugins.cmp')
            end,}
	    use {"hrsh7th/cmp-nvim-lua",
            config = function()
                require('brigadira.plugins.cmp')
            end,}

        use "hrsh7th/cmp-nvim-lsp"

        -- LSP
        -- enable LSP
        -- simple to use language server installer
        use {"neovim/nvim-lspconfig",
            config = function()
                require('brigadira.lsp')
            end,}

        use {"williamboman/mason.nvim",
            config = function()
                require('brigadira.lsp')
            end,}

        -- simple to use language server installer
        use {"williamboman/mason-lspconfig.nvim",
            config = function()
                require('brigadira.lsp')
            end,}

        -- LSP diagnostics and code actions
        use {'jose-elias-alvarez/null-ls.nvim',
            config = function()
                require('brigadira.lsp')
            end,}

        use {'nvim-treesitter/nvim-treesitter',
            config = function()
                require('brigadira.plugins.treesitter')
            end,}

        use({
            'nvim-lualine/lualine.nvim',
            event = 'BufEnter',
            config = function()
                require('brigadira.plugins.lualine')
            end,
        })
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
