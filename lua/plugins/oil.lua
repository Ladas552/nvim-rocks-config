require("oil").setup({
  skip_confirm_for_simple_edits = true,
  watch_for_changes = true,

  delete_to_trash = true,
  view_options = {
    show_hidden = true
  },
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Oil" })

