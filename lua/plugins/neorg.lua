require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {
      config  = {
        icon_preset = "diamond",
      }
    },
    ["core.dirman"] = {
      config = {
        default_workspace = "general",
        workspaces = {
          general = "~/Documents/Norg",
          journal = "~/Documents/Norg/Journal",
          life = "~/Documents/Norg/Life",
          work = "~/Documents/Norg/Study",
          archive = "~/Documents/Norg/Archive",
        },
      },
    },
    ["core.esupports.metagen"] = {
      config = {
        timezone = "implicit-local",
        type = "empty",
        undojoin_updates = false,
      },
    },
    ["core.integrations.telescope"] = {},
    ["core.journal"] = {
      config = {
        journal_folder = "/./",
        workspace = "journal",
      }
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader><Leader>",
      }
    },
    ["core.summary"] = {},
    ["core.tangle"] = {
      config = {
        report_on_empty = true,
        tangle_on_write = false,
      }
    },
    ["core.completion"] = {
      config = {
        engine = {
          module_name = "external.lsp-completion",
        }
      },
    },
    -- External modules
    ["external.interim-ls"] = { -- rename doesn't work on nightly
      config = {
        completion_provider = {
          categories = true,
        }
      }
    },
  },
})
