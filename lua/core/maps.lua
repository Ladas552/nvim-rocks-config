--- maps.lua - Keybindings
-- Set space as leader key
vim.g.mapleader = " "

-- Some weird shorthand names, as it should be
local kbd = vim.keymap.set

--- Disable
--
-- Disable accidentally pressing Ctrl-Z and suspending Neovim
kbd("n", "<C-z>", "<Nop>")

-- Disable ex-mode
kbd("n", "Q", "<Nop>")

--- Core
--
-- Fast command-line mode
kbd("n", ";", ":")

-- ESC to turn off search highlighting
kbd("n", "<esc>", "<cmd>nohlsearch<cr>")

-- Escape remaps
local esc_keys = {
  qwerty = { "jk", "kj" },
  dvorak = { "hh" },
}
for _, keys in ipairs(esc_keys[vim.g.layout]) do
  kbd("i", keys, "<esc>")
end

-- Helix comments
kbd("n","<C-c>","norm gcc<CR>")
kbd("v","<C-c>","norm gc<CR>")

-- Stay in visual mode after indenting with < or >
kbd("v", ">", ">gv")
kbd("v", "<", "<gv")

--AntiUndo
kbd("n", "<S-u>", "<cmd>redo<cr>")


-- Ah yes, lovely native multi-cursor hack, see
-- https://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-- kbd("n", "cn", "*``cgn")
-- kbd("n", "cN", "*``cgN")

-- Exit insert mode in terminal
kbd("t", "<esc>", "<C-\\><C-n>")

--- Movement
-- Move between buffers
kbd("n", "<leader>,", "<cmd>BufferPrevious<cr>",{ desc = "Left Buffer" })
kbd("n", "<leader>.", "<cmd>BufferNext<cr>",{ desc = "Right Buffer" })
kbd("n", "<leader>x", "<cmd>BufferClose<cr>",{ desc = "Close Buffer" })
-- Move between windows
--
-- left
kbd("n", "<S-Left>", "<C-w>h")

-- down
kbd("n", "<S-Down>", "<C-w>j")

-- upper
kbd("n", "<S-Up>", "<C-w>k")

-- right
kbd("n", "<S-Right>", "<C-w>l")

-- Resize splits
--
-- increase height
kbd("n", "<A-Up>", "<cmd>resize +2<cr>")

-- decrease height
kbd("n", "<A-Down>", "<cmd>resize -2<cr>")

-- increase width
kbd("n", "<A-Left>", "<cmd>vertical resize +2<cr>")

-- decrease width
kbd("n", "<A-Right>", "<cmd>vertical resize -2<cr>")

-- Smooth scrolling
kbd(
  "n",
  "<C-U>",
  "<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>"
)
kbd(
  "n",
  "<C-D>",
  "<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>"
)


-- Toggle spelling
kbd("n", "<leader>ts", function()
  ---@diagnostic disable-next-line
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spelling" })

-- Toggle automatic comments insertion
kbd("n", "<leader>tc", function()
  vim.cmd("ToggleCommentsInsertion")
end, { desc = "Toggle automatic comments insertion" })

-- Plugin manager
--
-- Synchronize
kbd("n", "<leader>ps", "<cmd>Rocks sync<cr>", { desc = "Sync" })

-- Edit
kbd("n", "<leader>pe", "<cmd>Rocks edit<cr>", { desc = "Edit" })

-- Update
kbd("n", "<leader>pu", "<cmd>Rocks update<cr>", { desc = "Update" })

-- Log
kbd("n", "<leader>pl", "<cmd>Rocks log<cr>", { desc = "Logs" })

--- maps.lua ends here

