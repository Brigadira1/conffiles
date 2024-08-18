return {
    {
        "stevearc/dressing.nvim",
        lazy = false,
        opts = {},
    },
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
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
            -- Display debug text as a comment
            commented = true,
            -- Customize virtual text
            display_callback = function(variable, buf, stackframe, node, options)
                if options.virt_text_pos == "inline" then
                    return " = " .. variable.value
                else
                    return variable.name .. " = " .. variable.value
                end
            end,
        },
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
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
                print("DAP UI opened after initialization")
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
                print("DAP UI closed before termination")
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
                print("DAP UI closed before exit")
            end
            dap.listeners.after.stopped["dapui_config"] = function()
                dapui.open()
                print("DAP UI opened after stopped event")
            end
        end,
        opts = require("configs.nvim-dap-ui"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        opts = require("configs.treesitter"),
    },
}
