--- autocmds.lua - Autocommands

local au = vim.api.nvim_create_autocmd

-- Highlight yanked text
au("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

-- Autosave
au({ "InsertLeave", "FocusLost" }, {
  pattern = "<buffer>",
  command = "silent! write",
})

-- Update file on external changes
au({ "FocusGained", "TermClose", "TermLeave" }, {
  pattern = "<buffer>",
  command = "checktime",
})

-- Align windows when resizing Neovim
au("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- Auto cd to current buffer path
au("BufEnter", {
  pattern = "*",
  command = "silent! lcd %:p:h",
})

-- Breaks oil.nvim. https://www.reddit.com/r/neovim/comments/1g6f5jy/oilnvim_creating_empty_oil_directories/
-- Automatically create directory when saving a file in case it does not exist
-- au("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     require("core.autocmds.utils").create_directory_on_save()
--   end,
-- })

-- Preserve last editing position
au("BufReadPost", {
  pattern = "*",
  callback = function()
    require("core.autocmds.utils").preserve_position()
  end,
})

-- We do not like automatic comments on <cr> here, get lost
au("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Quickly exit help pages
au("FileType", {
  pattern = { "help", "notify", "checkhealth" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      silent = true,
      buffer = true,
    })
  end,
})

-- Trim trailing whitespaces
au("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.api.nvim_exec2([[keepjumps keeppatterns silent! %s/\s\+$//e]], {})
    vim.fn.winrestview(save)
  end,
})

-- Wrap and check for spelling
au("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Do not conceal JSON files
au("FileType", {
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Disable numbering, folding and signcolumn in Man pages and terminal buffers
local function disable_ui_settings()
  local opts = {
    number = false,
    relativenumber = false,
    signcolumn = "no",
    foldcolumn = "0",
    foldlevel = 999,
  }
  for opt, val in pairs(opts) do
    vim.opt_local[opt] = val
  end
end

local function start_term_mode()
  disable_ui_settings()
  vim.cmd("startinsert!")
end

au({ "BufEnter", "BufWinEnter" }, {
  pattern = "man://*",
  callback = disable_ui_settings,
})

au("TermOpen", {
  pattern = "term://*",
  callback = start_term_mode,
})

--- autocmds.lua ends here
