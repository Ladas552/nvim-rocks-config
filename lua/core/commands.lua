--- commands.lua - Commands

vim.api.nvim_create_user_command("SudoWrite", function()
  require("utils.sudo_write").write()
end, { desc = "Write file with sudo permissions" })

