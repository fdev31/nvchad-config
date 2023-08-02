local lib = require('custom.lib')

---@type MappingsTable
local M = {}

M.disabled = {
    v = {
        ["<leader>/"] = "",
        ["<leader>ra"] = "",
    },
    n = {
        ["<leader>/"] = "",
        ["<leader>ra"] = "",
    }
}

if not lib.isWorkLaptop then
    M.codeium = {
        i = {
            ["<C-g>"] = {
                function()
                    return vim.fn['codeium#Accept']()
                end,
                "Validate Codeium completion",
                opts = {expr = true}
            },
            ["<C-b>"] = {
                function()
                    require('plugins.configs.cmp').mapping["<C-e>"]()
                    return vim.fn['codeium#Complete']()
                end,
                "Complete via Codeium",
                opts = {expr = true}
            },
            ["<C-;>"] = {
                function()
                    return vim.fn['codeium#CycleCompletions'](1)
                end,
                "Switch to next codeium completion",
                opts = {expr = true}
            },
            ["<C-,>"] = {
                function()
                    return vim.fn['codeium#CycleCompletions'](-1)
                end,
                "Switch to previous codeium completion",
                opts = {expr = true}
            },
        }
    }
end

M.general = {
    n = {
        ["<leader>n"] = { "<cmd> set rnu! <CR>", "Toggle relative number" }
    },
    v = {
        ['<A-down>'] = {':MoveBlock(1)<CR>', "Move down", {noremap=true, silent=true}},
        ['<A-up>'] = {':MoveBlock(-1)<CR>', "Move up", {noremap=true, silent=true}},
        ['<A-left>'] = {':MoveHBlock(-1)<CR>', "Move left", {noremap=true, silent=true}},
        ['<A-right>'] = {':MoveHBlock(1)<CR>', "Move right", {noremap=true, silent=true}},
    }
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>c"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>c"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.gitsigns = {
    n = {
        ["<leader>D"] = {
            function()
                package.loaded.gitsigns.diffthis('~')
            end,
            "Show diff",
        },
    }
}

M.lspconfig = {
    n = {
        ["<leader>rn"] = {
            function()
                require("nvchad_ui.renamer").open()
            end,
            "LSP rename",
        },
    }
}

-- more keybinds!

return M
