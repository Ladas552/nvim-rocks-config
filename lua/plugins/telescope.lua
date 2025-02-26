vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" })


vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Rip-grep" })

vim.keymap.set("n", "<leader>fc", "<cmd>Telescope find_files<cr>", { desc = "Grep curent buffer" })

vim.keymap.set("n", "<leader>fn", "<cmd>Telescope neorg find_norg_files<cr>", { desc = "Find Norg File" })

vim.keymap.set("n", "<leader>n", "<cmd>Telescope neorg switch_workspace<cr>", { desc = "Change Neorg Workspace" })
