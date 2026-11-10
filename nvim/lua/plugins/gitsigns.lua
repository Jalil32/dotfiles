return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	opts = {
		-- Color the line number too, not just the thin sign bar
		numhl = true,
		-- Solid bar for new (untracked) files instead of the faint dashed default
		signs = {
			untracked = { text = "┃" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Jump between changed blocks
			map("]h", function()
				gs.nav_hunk("next")
			end, "Next hunk")
			map("[h", function()
				gs.nav_hunk("prev")
			end, "Prev hunk")
			-- Show the old version of the block inline, under the change
			map("<leader>hp", gs.preview_hunk_inline, "Preview hunk inline")
			-- VS Code-style full-line green/red backgrounds, toggled on demand
			map("<leader>hl", gs.toggle_linehl, "Toggle line highlight")
			-- Highlight the exact words that changed within a line
			map("<leader>hw", gs.toggle_word_diff, "Toggle word diff")
			map("<leader>hs", gs.stage_hunk, "Stage hunk")
			map("<leader>hr", gs.reset_hunk, "Reset hunk")
			map("<leader>hb", gs.blame_line, "Blame line")
		end,
	},
}
