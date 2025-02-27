vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })

vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Rip-grep" })

vim.keymap.set("n", "<leader>fc", "<cmd>Telescope find_files<cr>", { desc = "Grep Curent Buffer" })

vim.keymap.set("n", "<leader>fn", "<cmd>Telescope neorg find_norg_files<cr>", { desc = "Find Norg File" })

vim.keymap.set("n", "<leader>n", "<cmd>Telescope neorg switch_workspace<cr>", { desc = "Change Neorg Workspace" })

vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", { desc = "Find Diagnostics" })
