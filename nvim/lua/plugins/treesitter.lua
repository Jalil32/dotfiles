return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local ts = require("nvim-treesitter")

		ts.install({
			"lua",
			"python",
			"typescript",
			"javascript",
			"tsx",
			"c",
			"cpp",
			"rust",
			"bash",
			"json",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end

				-- Auto-install parsers for languages not listed above
				if not vim.tbl_contains(ts.get_installed(), lang) then
					if vim.tbl_contains(ts.get_available(), lang) then
						ts.install({ lang })
					end
					return
				end

				-- pcall so a missing/broken parser never throws
				if pcall(vim.treesitter.start, args.buf, lang) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
