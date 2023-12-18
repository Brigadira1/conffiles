
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local map = vim.keymap.set

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- <leader>p|P paste from yank register (0)
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
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":m '>+1<CR>gv=gv", opts)
map("x", "K", ":m '<-2<CR>gv=gv", opts)
map("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Fix n and N. Keeping cursor in center
   -- map('n', 'n', 'nzz')
   -- map('n', 'N', 'Nzz')
-- Fix * (Keep the cursor position, don't move to next match)
   -- map('n', '*', '*N')
-- Quickly save the current buffer or all buffers
   -- map('n', '<leader>w', '<CMD>update<CR>')
   -- map('n', '<leader>W', '<CMD>wall<CR>')
-- Navigate buffers
   -- keymap("n", "<S-l>", ":bnext<CR>", opts)
   -- keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- Quit neovim
   -- map('n', '<C-Q>', '<CMD>q<CR>')
-- Shortcut to yank register
   -- map({ 'n', 'x' }, '<leader>p', '"0p')
-- Move to the next/previous buffer
   -- map('n', '<leader>[', '<CMD>bp<CR>')
   -- map('n', '<leader>]', '<CMD>bn<CR>')
-- Move to last buffer
   -- map('n', "''", '<CMD>b#<CR>')
-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
   --map('n', '<C-j>', '<CMD>move .+1<CR>')
   --map('n', '<C-k>', '<CMD>move .-2<CR>')
   --map('x', '<C-j>', ":move '>+1<CR>gv=gv")
   --map('x', '<C-k>', ":move '<-2<CR>gv=gv")
-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
   -- map('o', 'A', ':<C-U>normal! mzggVG<CR>`z')
   -- map('x', 'A', ':<C-U>normal! ggVG<CR>')
