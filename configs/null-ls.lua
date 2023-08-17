local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
	b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes
	-- python
	b.diagnostics.mypy,
	-- b.diagnostics.pylint,
	b.diagnostics.pylama,

	b.formatting.black.with({ extra_args = { "--line-length", "160" } }),
	b.diagnostics.flake8.with({ extra_args = { "--max-line-length", "160" } }),
	-- generic code
	b.code_actions.gitsigns,
	b.code_actions.refactoring,
	b.code_actions.shellcheck,

	-- Lua
	b.formatting.stylua,

	-- cpp
	b.formatting.clang_format,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
