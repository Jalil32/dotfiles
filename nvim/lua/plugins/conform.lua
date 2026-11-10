-- Formatting: Prettier (the project's own, from node_modules) when the project has a
-- Prettier config; otherwise fall back to LSP formatting (biome, gopls, ...).
local prettier = { "prettier" }

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = prettier,
			javascriptreact = prettier,
			typescript = prettier,
			typescriptreact = prettier,
			json = prettier,
			jsonc = prettier,
			css = prettier,
			scss = prettier,
			markdown = prettier,
			yaml = prettier,
		},
		formatters = {
			-- Only run when a Prettier config is found, so non-Prettier projects keep using biome.
			prettier = { require_cwd = true },
		},
		format_on_save = {
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
}
