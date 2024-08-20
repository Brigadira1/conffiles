require "nvchad.mappings"

-- add yours here
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Debugging
local dap = require('dap')
local dapui = require('dapui')

map('n', '<leader>ri', function()
    local file = vim.fn.expand('%:p')
    vim.cmd('sp | terminal python ' .. vim.fn.shellescape(file))
end, { noremap = true, silent = true, desc = "Run Python script" })

map('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "Set Conditional Breakpoint" })

-- Start debugging
map('n', '<leader>dpr', require('dap-python').test_method, { desc = "Debug Python Test Method" })
map('n', '<leader>dpc', function()
    require('dap-python').debug_selection()
end, { desc = "Debug Python Selection" })

-- Debugger controls
map('n', '<leader>dc', dap.continue, { desc = "Debug Continue" })
map('n', '<leader>do', dap.step_over, { desc = "Debug Step Over" })
map('n', '<leader>di', dap.step_into, { desc = "Debug Step Into" })
map('n', '<leader>dO', dap.step_out, { desc = "Debug Step Out" })

-- Debugger UI
map('n', '<leader>du', dapui.toggle, { desc = "Toggle Debug UI" })

-- Copy/pasting
map({ "n", "v" }, "<leader>v", [["+p]], { desc = "paste AFTER from clipboard" })
map({ "n", "v" }, "<leader>V", [["+P]], { desc = "paste BEFORE from clipboard" })
map({ "n", "v" }, "<leader>s", [["*p]], { desc = "paste AFTER from primary" })
map({ "n", "v" }, "<leader>S", [["*P]], { desc = "paste BEFORE from primary" })

-- Turn off search matches with double-<Esc>
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { silent = true })

-- Keep matches center screen when cycling with n|N
map("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

-- Move text up and down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- leader-o/O inserts blank line below/above
map('n', '<leader>o', 'o<ESC>', opts)
map('n', '<leader>O', 'O<ESC>', opts)

-- Keeping the cursor always in the center of the page when C-d and C-u
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- Remap gj and gk as when the text is wrapped j and k are missing lines
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- Mimic shell movements
map('i', '<C-E>', '<C-o>$', opts)
map('i', '<C-A>', '<C-o>^', opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv^", opts)
map("v", ">", ">gv^", opts)

-- Move text up and down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":m '>+1<CR>gv=gv", opts)
map("x", "K", ":m '<-2<CR>gv=gv", opts)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
