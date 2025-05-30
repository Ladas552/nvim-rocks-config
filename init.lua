--- init.lua - Neovim init file

-- Do not load Neovim runtime plugins automatically
-- vim.opt.loadplugins = false

-- Manually load runtime Man plugin to use Neovim as my man pager
vim.api.nvim_command("runtime! plugin/man.lua")

-- Enable the experimental Lua module loader, slightly improves startup time
vim.loader.enable()

-- Set colorscheme
vim.g.colorscheme = "catppuccin"


-- Set keyboard layout.
vim.g.layout = "qwerty"
-- rocks.nvim config and bootstrapping {{{
-- Specifies where to install/use rocks.nvim
---@diagnostic disable-next-line param-type-mismatch
local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")

-- Set up configuration options related to rocks.nvim (recommended to leave as default)
local rocks_config = {
  rocks_path = vim.fs.normalize(install_location),
}
-- HACK: Nix does not expose development headers by default,
-- so I extract the relevant header files from the lua5.1
-- tarball and it seems to do the trick.
-- rocks_config.luarocks_config = {
--   variables = {
--     LUA_INCDIR = vim.env.HOME .. "/.cache/Nvim/lua-inc",
--   },
-- }

vim.g.rocks_nvim = rocks_config
-- Configure the package path (so that plugin code can be found)
local luarocks_path = {
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
  vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

-- Configure the C path (so that e.g. tree-sitter parsers can be found)
local luarocks_cpath = {
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
  vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

-- Load all installed plugins, including rocks.nvim itself
vim.opt.runtimepath:append(
  vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*")
)


-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
  ---@diagnostic disable-next-line param-type-mismatch
  local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")
  ---@diagnostic disable-next-line undefined-field
  if not vim.uv.fs_stat(rocks_location) then
    -- Pull down rocks.nvim
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/nvim-neorocks/rocks.nvim",
      rocks_location,
    })
  end

  -- If the clone was successful then source the bootstrapping script
  assert(
    vim.v.shell_error == 0,
    "rocks.nvim installation failed. Try exiting and re-entering Neovim!"
  )

  vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))

  vim.fn.delete(rocks_location, "rf")
end
-- }}}

-- Load configuration core
local loaded_core, core_err = xpcall(require, debug.traceback, "core")
if not loaded_core then
  vim.notify_once(
    string.format("There was an error requiring 'core'. Traceback:\n%s", core_err),
    vim.log.levels.ERROR
  )
end
