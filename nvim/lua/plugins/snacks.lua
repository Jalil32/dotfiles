return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = {
			enabled = true,
			doc = {
				inline = true,
				float = true,
			},
		},
		explorer = {
			-- Keep netrw for :Ex / <leader>pv
			replace_netrw = false,
		},
		picker = {
			sources = {
				explorer = {
					actions = {
						-- Open the file but keep the cursor in the tree
						confirm_stay = function(picker, item)
							picker:action("confirm")
							if item and not item.dir then
								picker:focus("list")
							end
						end,
					},
					win = {
						list = {
							keys = {
								["<CR>"] = "confirm_stay",
							},
						},
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				local explorer = Snacks.picker.get({ source = "explorer" })[1]
				if explorer then
					explorer:close()
				else
					Snacks.explorer()
				end
			end,
			desc = "Toggle file tree",
		},
	},
}
