return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")

        -- Use an existing DAP highlight group
        vim.fn.sign_define("DapBreakpoint", {
            text = "",
            texthl = "DapUIBreakpointsInfo",
            linehl = "DapUIBreakpointsLine",
            numhl = "",
        })
    end,
}
