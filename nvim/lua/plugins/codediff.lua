return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	keys = {
		{ "<leader>gd", "<cmd>CodeDiff<cr>" },
		{ "<leader>gh", "<cmd>CodeDiff history<cr>" },
		-- Branch vs its base: master if the repo has one, otherwise main
		{
			"<leader>gD",
			function()
				vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", "master" })
				local base = vim.v.shell_error == 0 and "master" or "main"
				vim.cmd("CodeDiff " .. base .. "...HEAD")
			end,
			desc = "Diff branch against master/main",
		},
	},
	opts = {
		-- Show changed files as a folder tree on the left, like the Snacks file tree
		explorer = {
			position = "left",
			width = 40,
			view_mode = "tree",
			indent_markers = true,
			-- Show +added / -deleted line counts per file and folder
			line_stats = {
				enabled = true,
				count_untracked = false,
			},
		},
		history = {
			position = "left",
			width = 40,
			view_mode = "tree",
		},
	},
	config = function(_, opts)
		require("codediff").setup(opts)

		-- codediff re-pins the panel to the configured width on every file switch,
		-- so a manual resize gets thrown away. Write resizes back into the live
		-- config so the panel keeps whatever size you dragged it to.
		local panels = { ["codediff-explorer"] = "explorer", ["codediff-history"] = "history" }
		vim.api.nvim_create_autocmd("WinResized", {
			group = vim.api.nvim_create_augroup("codediff_keep_panel_size", { clear = true }),
			callback = function()
				local options = require("codediff.config").options
				for _, win in ipairs(vim.v.event.windows or {}) do
					if vim.api.nvim_win_is_valid(win) then
						local name = panels[vim.bo[vim.api.nvim_win_get_buf(win)].filetype]
						local panel = name and options[name]
						if panel then
							if (panel.position or "left") == "bottom" then
								panel.height = vim.api.nvim_win_get_height(win)
							else
								panel.width = vim.api.nvim_win_get_width(win)
							end
						end
					end
				end
			end,
		})
	end,
}
