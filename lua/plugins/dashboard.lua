require("dashboard").setup({
    config = {
        center = {
            { action = "Telescope oldfiles", desc = " Recent files", icon = "󰥔 ", key = "R" },
            { action = "Telescope find_files", desc = " Find files", icon = " ", key = "F" },
            { action = "ene | startinsert", desc = " New file", icon = " ", key = "N" },
            { action = "Neorg workspace life", desc = " Neorg Life", icon = "󰠮 ", key = "E" },
            { action = "Neorg workspace work", desc = " Neorg Work", icon = " ", key = "W" },
            { action = "Neorg journal today", desc = " Neorg Journal", icon = "󰛓 ", key = "J" },
            { action = "qa", desc = " Quit", icon = "󰩈 ", key = "Q" },
        },
        footer = { "Just Do Something Already!" },
        header = {
            "                                                                ",
            "██╗      █████╗ ██████╗  █████╗ ███████╗███████╗███████╗██████╗ ",
            "██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝╚════██╗",
            "██║     ███████║██║  ██║███████║███████╗███████╗███████╗ █████╔╝",
            "██║     ██╔══██║██║  ██║██╔══██║╚════██║╚════██║╚════██║██╔═══╝ ",
            "███████╗██║  ██║██████╔╝██║  ██║███████║███████║███████║███████╗",
            "╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝",
            "                                                                ",
        },
    },
    shortcut_type = "number",
    theme = "doom",
})

