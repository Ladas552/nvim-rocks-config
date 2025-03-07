---@diagnostic disable: undefined-field
-- Initially taken from [NTBBloodbath](https://github.com/NTBBloodbath/nvim/blob/main/lua/core/lsp.lua)

-- Diagnostics {{{
local severity = vim.diagnostic.severity
vim.diagnostic.config({
  underline = {
    enable = true,
    severity = {
      min = severity.WARN,
    },
  },
  virtual_lines = {
    enable = true,
    current_line = true,
  },
  signs = {
    severity = {
      min = severity.HINT,
    },
    -- I don't like sign collumn
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
  virtual_text = false,
  -- virtual_lines = true,
  -- underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "if_many",
    border = "rounded",
    show_header = false,
  },
})

-- }}}

-- Improve LSPs UI {{{
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden" } }
)


local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- }}}
local loaded_blink, blink = xpcall(require, debug.traceback, "blink.cmp")
if loaded_blink then
  ---@diagnostic disable-next-line undefined-field
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
})
-- }}}

-- Disable the default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
  vim.keymap.del("n", bind)
end
-- }}}

-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- -- nightly has inbuilt completions, this can replace all completion plugins
    -- if client.supports_method("textDocument/completion") then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    -- All the keymaps
    -- stylua: ignore start
    local keymap = vim.keymap.set
    local lsp = vim.lsp
    local opts = { silent = true, buffer = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end
    keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
    keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, opt("Go to implementation"))
    keymap("n", "gr", lsp.buf.references, opt("Show References"))
    keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
    keymap("n", "<C-k>", lsp.buf.signature_help, opts)
    keymap("n", "K", function() lsp.buf.hover({ border = "single" }) end, opts)
    keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
    keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
    keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
    keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
      opt("Toggle Inlayhints"))
    keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
    keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
    keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
    keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

    keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
    keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
    keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
    keymap("n", "<Leader>dv", function()
      local new_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = new_config })
    end, opt("Toggle diagnostic virtual_lines"))
    -- stylua: ignore end
  end,
})
-- }}}

-- Servers {{{

-- Go {{{
vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gotempl", "gowork", "gomod" },
  root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      ["ui.inlayhint.hints"] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
vim.lsp.enable("gopls")
-- }}}
-- Nix {{{
-- TODO: Add expr for options, while also figure out how to add it depending on host in my NixOS config. Preferable without breaking config for people not on NixOS lol
vim.lsp.config.nixd = {
  cmd = {
    "nixd",
    "--inlay-hints=true",
  },
  -- vim.uv.cwd() is the equivalent of `single_file_mode` in lspconfig
  ---@diagnostic disable-next-line undefined-field
  root_markers = { "flake.nix", ".git", vim.uv.cwd() },
  filetypes = { "nix" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
    },
  },
}
vim.lsp.enable("nixd")
-- }}}

-- Typst {{{
vim.lsp.config.timymist = {
  cmd = { "tinymist" },
  root_markers = { "src.typ", ".git", vim.uv.cwd() },
  filetypes = { "typ", "typst" },
  settings = {
    exportPdf = "onType",
    outputPath = "$root/$name",
    fontPaths = "./fonts",
    formatterMode = "typstyle",
  },
}
vim.lsp.enable("timymist")

-- }}}

-- C/C++ {{{
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "-j=" .. 2,
    "--background-index",
    "--clang-tidy",
    "--inlay-hints",
    "--fallback-style=llvm",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--pch-storage=memory",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    "CMakeLists.txt",
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
    vim.uv.cwd(),
  },
}
vim.lsp.enable("clangd")
-- }}}

-- }}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
  vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if opts.args == "" or opts.args == client.name then
      client:stop(true)
      vim.notify(client.name .. ": stopped")
    end
  end
end, {
  desc = "Stop all LSP clients or a specific client attached to the current buffer.",
  nargs = "?",
  complete = function(_, _, _)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local client_names = {}
    for _, client in ipairs(clients) do
      table.insert(client_names, client.name)
    end
    return client_names
  end,
})

vim.api.nvim_create_user_command("LspRestart", function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop(true)
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start(client[1].config, { attach = false })
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ": restarted")
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
  desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("silent checkhealth vim.lsp")
end, {
  desc = "Get all the information about all LSP attached",
})
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
