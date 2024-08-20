return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server", "stylua",
                "html-lsp", "css-lsp", "pyright",
                "mypy", "black", "ruff", "debugpy",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "black" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim", "lua", "vimdoc",
                "html", "css", "python"
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        event = "BufReadPre",
        config = function()
            require("lint").linters_by_ft = {
                python = { "mypy", "ruff", }
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",

            -- config = function()
            --     local dap = require("dap")
            --     local dapui = require("dapui")
            --     dapui.setup()
            --     dap.setup()
            --     dap.listeners.after.event_initialization["dapui_config"] = function()
            --         dapui.open()
            --     end
            --     dap.listeners.before.event_termination["dapui_config"] = function()
            --         dapui.close()
            --     end
            --     dap.listeners.before.event_exited["dapui_config"] = function()
            --         dapui.close()
            --     end
            -- end
        },

        config = function()
            require("configs.dap-ui").setup()
        end
    },
}
