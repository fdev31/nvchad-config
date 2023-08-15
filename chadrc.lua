---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
    theme = "github_dark",
    theme_toggle = { "github_dark", "bearded-arc" },
    -- transparency = true,

    hl_override = highlights.override,
    hl_add = highlights.add,
    cmp = {
        style = "atom_colored",
    },
    tabufline = {
        lazyload = false,
        enabled = false,
    },
    telescope = {
        style = "bordered"
    },
    statusline = {
        theme="vscode"
    }

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
--
M.mappings = require "custom.mappings"

M.gitsigns = {
  signs = {
    add = { text = " " },
    change = { text = " " },
    delete = { text = " " },
    topdelete = { text = " " },
    changedelete = { text = " " },
    untracked = { text = " " },
  }
}

return M
