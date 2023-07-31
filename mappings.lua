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
            ["<C-b>"] = {
                function()
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
