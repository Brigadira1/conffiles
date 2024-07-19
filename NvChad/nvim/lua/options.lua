require "nvchad.options"

-- add yours here!

local g = vim.g
local o = vim.o

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

-- mostly just for cmp
-- o.completeopt = { "menuone", "noselect" }
-- so that `` is visible in markdown files
o.conceallevel = 0
-- pop up menu height
o.pumheight = 10
o.termguicolors = true
o.background = 'dark'
-- THE ROW BELOW SOLVE THE BUG WHERE PARANTHESES AND CURLY BRACKETS ARE HIGHLIGHTED AND THE CURSOR GOES DIRECTLY -- TO THE HIGHLIGHTED BRACKET/CURLY BRACKET
-- g.loaded_matchparen = 1

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 10
o.sidescrolloff = 10

-- the font used in graphical neovim applications
-- o.guifont = "monospace:h17"
-- Better editor UI
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = 'yes:2'
o.cmdheight = 3

-- o.smarttab = true
o.cindent = true
-- o.autoindent = true

o.wrap = false
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Stable buffer content on window open/close events.
o.splitkeep = 'screen'

-- Improve diff
vim.opt.diffopt:append('linematch:60')

-- Smooth scrolling
o.smoothscroll = true


-- o.fillchars = "vert:|"
-- WARN: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
