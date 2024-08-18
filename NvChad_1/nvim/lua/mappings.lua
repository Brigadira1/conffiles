require("nvchad.mappings")

-- add yours here
local opts = { noremap = true, silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

map("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

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
map("n", "<leader>o", "o<ESC>", opts)
map("n", "<leader>O", "O<ESC>", opts)

-- Keeping the cursor always in the center of the page when C-d and C-u
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Remap gj and gk as when the text is wrapped j and k are missing lines
map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

-- Mimic shell movements
map("i", "<C-E>", "<C-o>$", opts)
map("i", "<C-A>", "<C-o>^", opts)

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

-- LSP
map("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
map("v", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
map("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
map("i", "<C-Space>", "<cmd>lua vim.lsp.buf.completion()<CR>")

-- Debugging
map("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
map("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
map("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
map("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
map("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
map("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
map("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
map("n", "<leader>dd", function()
    require("dap").disconnect()
    require("dapui").close()
end)
map("n", "<leader>dt", function()
    require("dap").terminate()
    require("dapui").close()
end)
map("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
map("n", "<leader>di", function()
    require("dap.ui.widgets").hover()
end)
map("n", "<leader>d?", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
end)
map("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
map("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
map("n", "<leader>de", function()
    require("telescope.builtin").diagnostics({ default_text = ":E:" })
end)
map("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
