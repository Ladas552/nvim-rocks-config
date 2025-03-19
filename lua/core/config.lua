--- config.lua - Neovim user configurations (saner defaults)

local builtins = {
  "tar",
  "zip",
  "gzip",
  "tarPlugin",
  "zipPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
}
local providers = { "perl", "node", "ruby", "python", "python3" }
for _, builtin in ipairs(builtins) do
  vim.g["loaded_" .. builtin] = 1
end
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Set C syntax for '.h' header files (default is C++)
vim.g.c_syntax_for_h = true

--- Global options
vim.opt.hidden = true
vim.opt.updatetime = 50
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 5
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess = "filnxtToOFatsc"
vim.opt.inccommand = "split"
vim.opt.path = "**"
vim.opt.isfname:append("@-@")
-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position


-- Use clipboard outside Neovim
-- vim.opt.clipboard = "unnamedplus"
-- Enable mouse input
vim.opt.mouse = "a"

-- Faster macros
vim.opt.lazyredraw = true

-- Disable swapfiles and enable undofiles
vim.opt.swapfile = false
vim.opt.undofile = true

--- UI-related options
-- Smooth all the way!
vim.opt.smoothscroll = true

-- Smooth mouse scrolling
vim.opt.mousescroll = { "hor:6", "ver:1" }

-- Confirmation prompts for unsaved files, etc
vim.opt.confirm = false

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- True-color
vim.opt.termguicolors = true

-- Columns and characters
-- vim.opt.signcolumn = "auto:1-3"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.wo.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldcolumn = "auto:2"
vim.opt.fillchars = {
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  fold = " ",
  diff = "─",
  msgsep = "‾",
  foldsep = "│",
  foldopen = "▾",
  foldclose = "▸",
}

vim.opt.list = true

-- Set windows width
vim.opt.winwidth = 40

-- Set a global statusline
vim.opt.laststatus = 2

--- Buffer options

-- Every wrapped line will continue visually indented, preserving horizontal spacing
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.wrap = true

-- Smart search
vim.opt.smartcase = true

-- Case-insensitive search
vim.opt.ignorecase = true

-- Indentation rules
vim.opt.copyindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true

-- Indentation level
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Expand tabs
vim.opt.expandtab = true
-- Copy indent from current line when starting new one
vim.opt.autoindent = true

-- Enable concealing
vim.opt.conceallevel = 2

-- Automatic split locations
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll off
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Freely move cursor in buffer while in Visual block mode
vim.opt.virtualedit = "block"

-- Spelling
vim.opt.spelllang = "en_us,ru"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.spellsuggest = "best,6"

--- config.lua ends here
