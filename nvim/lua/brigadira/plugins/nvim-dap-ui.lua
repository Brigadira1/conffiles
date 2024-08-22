-- Debugging Support
return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text", -- inline variable text while debugging
        "nvim-telescope/telescope-dap.nvim", -- telescope integration with dap
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
    opts = {
        controls = {
            element = "repl",
            enabled = false,
            icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = "",
            },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        force_buffers = true,
        icons = {
            collapsed = "",
            current_frame = "",
            expanded = "",
        },
        layouts = {
            {
                elements = {
                    {
                        id = "scopes",
                        size = 0.50,
                    },
                    {
                        id = "stacks",
                        size = 0.30,
                    },
                    {
                        id = "watches",
                        size = 0.10,
                    },
                    {
                        id = "breakpoints",
                        size = 0.10,
                    },
                },
                size = 40,
                position = "left", -- Can be "left" or "right"
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom", -- Can be "bottom" or "top"
            },
        },
        mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t",
        },
        render = {
            indent = 1,
            max_value_lines = 100,
        },
    },
    -- config = function(_, opts)
    --     local dap = require("dap")
    --     require("dapui").setup(opts)
    --
    --     dap.listeners.after.event_initialized["dapui_config"] = function()
    --         require("dapui").open()
    --     end
    --
    --     dap.listeners.before.event_terminated["dapui_config"] = function()
    --         -- Commented to prevent DAP UI from closing when unit tests finish
    --         -- require('dapui').close()
    --     end
    --
    --     dap.listeners.before.event_exited["dapui_config"] = function()
    --         -- Commented to prevent DAP UI from closing when unit tests finish
    --         -- require('dapui').close()
    --     end
    --
    --     -- Add dap configurations based on your language/adapter settings
    --     -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    --     -- dap.configurations.xxxxxxxxxx = {
    --     --   {
    --     --   },
    --     -- }
    -- end,
}
