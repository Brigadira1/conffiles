return {
    {

        "stevearc/conform.nvim",
        event = { "BufWritePre", "BufReadPre" },
        opts = require("configs.conform"),
    },
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
            require("configs.lint")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("configs.nvim-tree")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig")
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "html-lsp",
                "css-lsp",
                "prettier",
                "pyright",
                "mypy",
                "black",
                "debugpy",
                "isort",
                "shfmt",
                "taplo",
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("mason").setup()
            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "debugpy",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        opts = require("configs.treesitter"),
    },
}
