-- vim: ts=2 sw=2:
local overrides = require("custom.configs.overrides")
local lib = require("custom.lib")

-- All NvChad plugins are lazy-loaded by default
-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
--
---@type NvPluginSpec[]
local plugins = {
	-- DAP {{{
	{
		"mfussenegger/nvim-dap",
    ft = {"python", "javascript", "sh"},
		config = function()
			local dap = require("dap")
			vim.fn.sign_define("DapBreakpoint", { text = "🚩", texthl = "", linehl = "", numhl = "" })

			dap.defaults.fallback.force_external_terminal = true
			dap.defaults.fallback.external_terminal = {
				command = "/usr/bin/kitty",
				args = { "-e" },
			}
      -- Adapters {{{
			dap.adapters["pwa-node"] = {
				type = "server",
			}
      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      } -- }}}
      -- Configurations {{{
			dap.configurations.javascript = {
				{
					name = "Attach to process",
					type = "pwa-node",
					request = "attach",
					address = "192.168.100.42",
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.sh = {
				{
					type = "bashdb",
					request = "launch",
					name = "Launch file",
					showDebugOutput = true,
					trace = true,
					file = "${file}",
					program = "${file}",
					cwd = "${workspaceFolder}",
					args = {},
					env = {},
					terminalKind = "integrated",
					runInTerminal = false,
					pathCat = "cat",
					pathBash = "/bin/bash",
					pathMkfifo = "mkfifo",
					pathPkill = "pkill",
					pathBashdb = vim.fn.stdpath("data")
						.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
					pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
				},
        --- }}}
			}
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		requires = { "rcarriga/nvim-dap-ui" },
    ft = {"python", "javascript", "sh"},
		config = function()
			require("dap-python").setup()
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		requires = { "mfussenegger/nvim-dap" },
		ft = "javascript",
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = "/home/fab/dev/microsoft/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		lazy = false,
		config = function()
			require("dapui").setup()
		end,
	}, -- }}}
	-- Rainbow {{{
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
	}, -- }}}
	-- highlights arguments {{{
	{
		"m-demare/hlargs.nvim",
		lazy = false,
		config = function()
			local hlargs = require("hlargs")
			hlargs.setup()
			hlargs.enable()
		end,
	}, --- }}}
	-- highlights TODO, FIXME, etc... {{{
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	}, -- }}}
	-- split / join code {{{
	{
		"Wansmer/treesj",
		keys = { "<space>m" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				max_join_length = 300,
			})
		end,
	}, --}}}
	-- Navigate code (aerial) {{{
	{
		"stevearc/aerial.nvim",
		lazy = false,
		config = function()
			require("aerial").setup()
			require("telescope").load_extension("aerial")
		end,
	}, -- }}}
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

	-- override plugin configs {{{
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
	}, -- }}}

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
}

if not lib.isWorkLaptop then
	vim.g.codeium_manual = true
	vim.g.codeium_disable_bindings = true
	table.insert(plugins, { "Exafunction/codeium.vim", lazy = false })
end

return plugins
