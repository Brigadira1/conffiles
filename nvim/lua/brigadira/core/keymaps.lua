vim.g.mapleader = " " -- setting up leader key to space

local opts = { noremap = true, silent = true }

local keymap = vim.keymap -- for conciseness

-- Turn off search matches with double-<Esc>
keymap.set("n", "<ESC><ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- Keep matches center screen when cycling with n|N
keymap.set("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
keymap.set("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

-- Move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-- leader-o/O inserts blank line below/above
keymap.set("n", "<leader>o", "o<ESC>", opts)
keymap.set("n", "<leader>O", "O<ESC>", opts)

-- Keeping the cursor always in the center of the page when C-d and C-u
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Mimic shell movements
keymap.set("i", "<C-E>", "<C-o>$", opts)
keymap.set("i", "<C-A>", "<C-o>^", opts)

-- windows management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split windows vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split windows horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- split windows equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Make spllit window height shorter" }) -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Make split windows height talle" }) -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5", { desc = "Make split windows width bigger" }) -- make split windows width bigger
-- keymap.set("n", "<leader>sh", "<C-w><5", { desc = "Make split windows width smaller" }) -- make split windows width smaller

-- tabs management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- PLUGINS KEYS MAPS
--
--
--
-- ------------------

-- compiler.nvim
keymap.set("n", "<leader>co", "<cmd>CompilerOpen<CR>", { desc = "Opens the compiler run menu" })
keymap.set("n", "<leader>ct", "<cmd>CompilerToggleResults<CR>", { desc = "Toggles the compiler" })
keymap.set("n", "<leader>cr", "<cmd>CompilerRedo<CR>", { desc = "Redos last action of the compiler" })

-- nvim-tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- Run a python script
keymap.set("n", "<leader>ri", function()
	local file = vim.fn.expand("%:p")
	vim.cmd("sp | terminal python " .. vim.fn.shellescape(file))
end, { noremap = true, silent = true, desc = "Run Python script" })

-- Set a vim motion to <Space> + / to comment the line under the cursor in normal mode
keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
-- Set a vim motion to <Space> + / to comment all the lines selected in visual mode
keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Shows current opened buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Searches in Neovim help" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- auto session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end)
keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end)
keymap.set("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
keymap.set("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end)
