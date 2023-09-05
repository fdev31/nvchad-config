local lib = require("custom.lib")

---@type MappingsTable

require("core.mappings").nvterm = nil

local M = {
	disabled = { -- {{{
		v = {
			["<leader>/"] = "",
			["<leader>ra"] = "",
		},
		n = {
			["<leader>/"] = "",
			["<leader>ra"] = "",
		},
	}, -- }}}
	general = { -- {{{
		n = {
			["<leader>n"] = { "<cmd> set rnu! <CR>", "Toggle relative number", { noremap = true, silent = true } },
		},
		v = {
			["<A-down>"] = { ":MoveBlock(1)<CR>", "Move down", { noremap = true, silent = true } },
			["<A-up>"] = { ":MoveBlock(-1)<CR>", "Move up", { noremap = true, silent = true } },
			["<A-left>"] = { ":MoveHBlock(-1)<CR>", "Move left", { noremap = true, silent = true } },
			["<A-right>"] = { ":MoveHBlock(1)<CR>", "Move right", { noremap = true, silent = true } },
		},
	}, -- }}}
	dap = { --- {{{
		n = {
			["<leader>i"] = {
				function()
					require("dapui").toggle()
				end,
				"Toggle debugger UI",
				{ noremap = true, silent = true },
			},
			["<leader>b"] = {
				function()
					require("dap").toggle_breakpoint()
				end,
				"Toggle debugger breakpoint",
				{ noremap = true, silent = true },
			},
		},
	}, -- }}}
	comment = { -- {{{
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
	}, -- }}}
	gitsigns = { -- {{{
		n = {
			["<leader>sh"] = {
				function()
					package.loaded.gitsigns.stage_hunk()
				end,
				"Stage hunk",
			},
			["<leader>uh"] = {
				function()
					package.loaded.gitsigns.undo_stage_hunk()
				end,
				"Revert saged hunk",
			},
			["<leader>D"] = {
				function()
					package.loaded.gitsigns.diffthis()
				end,
				"Show diff",
			},
		},
	}, -- }}}
	lspconfig = { -- {{{
		n = {
			["<leader>rn"] = {
				function()
					require("nvchad.renamer").open()
				end,
				"LSP rename",
			},
		},
	}, -- }}}
	telescope = { -- {{{
		n = {
			["<C-,>"] = {
				function()
					require("telescope").extensions.aerial.aerial()
				end,
				"Toggle code outline window",
			},
		},
	}, -- }}}
}

-- Conditional:

-- vim diff {{{
if lib.isGitMergetool then
	M.diffmode = {
		plugin = false,
		n = {
			["dr"] = {
				"<cmd>diffget REMOTE<CR>",
				"get remote",
			},
			["dl"] = {
				"<cmd>diffget LOCAL<CR>",
				"get local",
			}
		},
	}
end
-- }}}

-- codeium {{{
if not lib.isWorkLaptop then
	M.codeium = {
		i = {
			["<C-g>"] = {
				function()
					return vim.fn["codeium#Accept"]()
				end,
				"Validate Codeium completion",
				opts = { expr = true },
			},
			["<C-b>"] = {
				function()
					local fn = require("plugins.configs.cmp").mapping["<C-e>"]
					pcall(fn)
					return vim.fn["codeium#Complete"]()
				end,
				"Complete via Codeium",
				opts = { expr = true },
			},
			["<C-;>"] = {
				function()
					return vim.fn["codeium#CycleCompletions"](1)
				end,
				"Switch to next codeium completion",
				opts = { expr = true },
			},
			["<C-,>"] = {
				function()
					return vim.fn["codeium#CycleCompletions"](-1)
				end,
				"Switch to previous codeium completion",
				opts = { expr = true },
			},
		},
	}
end
-- }}}

return M
