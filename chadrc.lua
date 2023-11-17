---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files

M.ui = {
	theme = "chadracula",
	theme_toggle = { "chadracula", "bearded-arc" },
	transparency = true,

    -- To find any highlight groups: "<cmd> Telescope highlights"
    -- Each highlight group can take a table with variables fg, bg, bold, italic, etc
    -- base30 variable names can also be used as colors
	hl_override = {
        gitcommitComment = {
            fg = "light_grey",
            italic = true
        },
        Folded = {
            fg = "dark_purple",
            italic = true
        },
        Comment = {
            bg = "darker_black",
            fg = "light_grey",
            italic = true
        },
    },
	hl_add = {
        NvimTreeOpenedFolderName = { fg = "green", bold = true },
    },
	cmp = {
		style = "atom_colored",
	},
	tabufline = {
		lazyload = false,
		enabled = false,
	},
	telescope = {
		style = "bordered",
	},
	statusline = {
		theme = "vscode_colored",
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
--
M.mappings = require("custom.mappings")

M.gitsigns = {
	signs = {
		add = { text = " " },
		change = { text = " " },
		delete = { text = " " },
		topdelete = { text = " " },
		changedelete = { text = " " },
		untracked = { text = " " },
	},
}

return M
