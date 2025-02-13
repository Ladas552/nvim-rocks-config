vim.bo.tw = 80

-- replacing typst-preview.nvim

vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    -- Get pid of Zathura to not kill every zathura window
    local zathura_pid = vim.fn.system("pgrep -f 'zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")) .. "'")
    -- Kill Zathura window if one is already open
    if zathura_pid ~= "" then
      vim.cmd("silent ! kill " .. zathura_pid)
    end
    -- Open file in Zathura
    vim.cmd("silent ! zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")) .. " &")

    -- Add an autocmd to kill the Zathura process when Neovim is closed
    vim.api.nvim_create_autocmd("VimLeave", {
      once = true,
      callback = function()
        local zathura_pid = vim.fn.system("pgrep -f 'zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")) .. "'")
        if zathura_pid ~= "" then
          vim.cmd("silent ! kill " .. zathura_pid)
        end
      end
    })
  end
end, {})
-- Keymap to make it easier to use on a whim
vim.keymap.set("n", "<leader>\\", "<cmd>OpenPdf<cr>", { silent = true })

