local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = { "pylsp", "html", "cssls", "clangd", "tailwindcss", "tsserver", "volar", "eslint" }


for _, lsp in ipairs(servers) do
    if lsp ~= "volar" then
        lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

lspconfig.volar.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'vue', 'json'},
	init_options = {
    typescript = {
            tsdk = "/usr/lib/node_modules/typescript/lib/"
		},
	},
})
