local M = {}

function M.setup()
    -- Define the custom highlight group for the red color
    vim.cmd("highlight DapBreakpointIcon guifg=#FF0000")

    -- Define the sign with the red icon using the custom highlight group
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointIcon", linehl = "", numhl = "" })
end

return M
