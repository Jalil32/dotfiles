return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>a", function() require("harpoon"):list():add() end },
		{ "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list(), { border = "rounded" }) end },
		{ "<C-u>",     function() require("harpoon"):list():select(1) end },
		{ "<C-i>",     function() require("harpoon"):list():select(2) end },
		{ "<C-o>",     function() require("harpoon"):list():select(3) end },
	},
	config = function()
		require("harpoon"):setup()
	end,
}
