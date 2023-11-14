local lib = require("custom.lib")

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "pylsp", "html", "cssls", "clangd", "tsserver", "volar", "eslint", "lua_ls" }
local custom_setup = { "volar", "pylsp" } -- list of manually configured servers
custom_setup.has = lib.has

if not lib.isWorkLaptop then
	table.insert(servers, "tailwindcss")
end

for _, lsp in ipairs(servers) do
	if not custom_setup:has(lsp) then
		lspconfig[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end
end

lspconfig.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "vue", "json" },
	init_options = {
		typescript = {
			tsdk = "/usr/lib/node_modules/typescript/lib/",
		},
	},
})

lspconfig.pylsp.setup({
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {
				-- formatter options
				black = { enabled = true },
				autopep8 = { enabled = true },
				yapf = { enabled = false },
				-- linter options
				pylint = { enabled = true },
				pyflakes = { enabled = true },
				pycodestyle = { enabled = true },
				-- type checker
				pylsp_mypy = { enabled = true },
				-- auto-completion options
				jedi_completion = { fuzzy = true },
				-- import sorting
				pyls_isort = { enabled = true },
			},
		},
	},
})
