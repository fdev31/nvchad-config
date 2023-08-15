-- vim: ts=2 sw=2:
local M = {}

M.telescope = {
	style = "bordered",
}

M.treesitter = {
	ensure_installed = {
		"bash",
		"vue",
		"c",
		"css",
		"python",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"vim",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"deno",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
