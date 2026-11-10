-- plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
	},
	keys = {
		{ "<leader>pf", function() require("telescope.builtin").find_files() end },
		{ "<C-p>",      function() require("telescope.builtin").git_files() end },
		{ "<leader>ps", function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				-- include dotfiles in grep pickers, but skip .git internals
				vimgrep_arguments = {
					"rg", "--color=never", "--no-heading", "--with-filename",
					"--line-number", "--column", "--smart-case",
					"--hidden", "--glob", "!**/.git/*",
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})
		require("telescope").load_extension("fzf")
	end,
}
