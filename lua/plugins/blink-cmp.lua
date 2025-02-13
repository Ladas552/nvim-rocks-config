require("blink.cmp").setup({
  keymap = {
    -- Similar to cmp defaults, but somewhat better
    preset = "enter", -- enter is also nice
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "accept", "fallback" }
    -- cmdline = {
    --   preset = "enter",
    -- },
  },
  completion = {
    -- 'prefix' will fuzzy match on the text before the cursor
    -- 'full' will fuzzy match on the text before *and* after the cursor
    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    keyword = { range = "full" },
    -- Insert completion item on selection if cmdline, otherwise preselect
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },

    menu = {
      border = "single",
      draw = {
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind" },
        },
      },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 1000,
      window = { border = "rounded" },
    },

    ghost_text = { enabled = true },
  },

  sources = {
    default = function()
      local success, node = pcall(vim.treesitter.get_node)
      if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
        return { "buffer" }
      end
      return { "lsp", "path", "snippets", "buffer" }
    end,
    -- Disable cmdline completions
    -- cmdline = {},
  },

  -- Experimental signature help support
  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
})
