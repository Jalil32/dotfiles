return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "pyright", "ts_ls", "lua_ls", "biome", "eslint", "html" },
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local on_attach = function(client, bufnr)
				-- Let biome own formatting for the JS/TS family so it doesn't
				-- fight with ts_ls (biome adds semicolons by default).
				if client.name == "ts_ls" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
				-- eslint is for diagnostics and code actions only; Prettier/biome do the formatting.
				if client.name == "eslint" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end

				local map = function(keys, func)
					-- nowait: Neovim's built-in grr/gri/grn/... defaults would otherwise
					-- make "gr" wait timeoutlen for a possible longer mapping.
					vim.keymap.set("n", keys, func, { buffer = bufnr, nowait = true })
				end
				-- Snacks picker: fuzzy list with live preview (jumps directly when there's one result)
				map("gd", function() Snacks.picker.lsp_definitions() end)
				map("gr", function() Snacks.picker.lsp_references() end)
				map("gI", function() Snacks.picker.lsp_implementations() end)
				map("gy", function() Snacks.picker.lsp_type_definitions() end)
				map("K", vim.lsp.buf.hover)
				map("<leader>rn", vim.lsp.buf.rename)
				map("<leader>ca", vim.lsp.buf.code_action)
				map("<leader>d", vim.diagnostic.open_float)
				map("<leader>f", function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client then
						on_attach(client, args.buf)
					end
				end,
			})

			vim.lsp.config("gopls", {})
			vim.lsp.config("pyright", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("biome", {
				-- Upstream only attaches biome when a biome.json is present.
				-- Attach for any JS/TS project instead so formatting (incl.
				-- semicolon insertion) works without one -- unless the project
				-- uses Prettier, in which case Prettier (via conform) owns formatting.
				root_dir = function(bufnr, on_dir)
					local util = require("lspconfig.util")
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local biome_root = util.root_pattern("biome.json", "biome.jsonc")(fname)
					if biome_root then
						on_dir(biome_root)
						return
					end
					local prettier_root = util.root_pattern(
						".prettierrc",
						".prettierrc.json",
						".prettierrc.js",
						".prettierrc.cjs",
						".prettierrc.mjs",
						".prettierrc.yaml",
						".prettierrc.yml",
						"prettier.config.js",
						"prettier.config.cjs",
						"prettier.config.mjs"
					)(fname)
					if prettier_root then
						return
					end
					local root = util.root_pattern("package.json", ".git")(fname)
					on_dir(root or vim.fn.getcwd())
				end,
			})
			-- Uses the nearest eslint.config.* and the project's own eslint from node_modules.
			vim.lsp.config("eslint", {})
			vim.lsp.config("html", {})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.enable({ "gopls", "pyright", "ts_ls", "lua_ls", "biome", "eslint", "html" })
		end,
	},
}
