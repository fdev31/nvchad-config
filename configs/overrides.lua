-- vim: ts=2 sw=2:
local M = {}

M.telescope = {
	style = "bordered",
}

M.treesitter = {
	ensure_installed = {
		"bash",
		"toml",
		"vue",
		"c",
		"cpp",
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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
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
    -- "deno",
    "typescript-language-server",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",

		"bash-debug-adapter",
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
