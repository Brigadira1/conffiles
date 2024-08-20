-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "catppuccin",

    hl_override = {

        CursorLine = {
            bg = "#FF0000", -- Adjust this color to make it lighter than your background
        },
        LineNr = {
            fg = "#757575", -- This is a bright orange color, adjust as needed
        },
        -- You can also set the color for the current line number separately
        -- CursorLineNr = {
        --     fg = "#FF79C6", -- This is a bright pink color, adjust as needed
        -- },
        -- 	Comment = { italic = true },
        -- 	["@comment"] = { italic = true },
    },
}

return M
