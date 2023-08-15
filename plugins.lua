-- vim: ts=2 sw=2:
local overrides = require("custom.configs.overrides")
local lib = require("custom.lib")

---@type NvPluginSpec[]
local plugins = {
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
	-- highlights arguments
	{
		"m-demare/hlargs.nvim",
		lazy = false,
		config = function()
			local hlargs = require("hlargs")
			hlargs.setup()
			hlargs.enable()
		end,
	},
	-- highlits TODO, FIXME, etc...
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"Wansmer/treesj",
		keys = { "<space>m" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				max_join_length = 300,
			})
		end,
	},
	{
		"stevearc/aerial.nvim",
		lazy = false,
		config = function()
			require("aerial").setup()
			require("telescope").load_extension("aerial")
		end,
	},
	{ "fedepujol/move.nvim", lazy = false },
	{ "aklt/plantuml-syntax", ft = "plantuml" },
	{ "NoahTheDuke/vim-just", ft = "just" },
	{ "vim-scripts/confluencewiki.vim", ft = "confluencewiki" },
	{ "NvChad/nvterm", enabled = false },

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

if not lib.isWorkLaptop then
	vim.g.codeium_manual = true
	vim.g.codeium_disable_bindings = true
	-- table.insert(plugins, {"nvim-lua/plenary.nvim", lazy=false})
	-- table.insert(plugins, {"jcdickinson/codeium.nvim", lazy=false,
	--     config = function()
	--         require("codeium").setup()
	--     end
	-- })
	table.insert(plugins, { "Exafunction/codeium.vim", lazy = false })
end

return plugins
