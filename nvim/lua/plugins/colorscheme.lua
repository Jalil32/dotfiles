return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Local scheme in colors/nextjs.lua; swap back with vim.cmd.colorscheme("tokyonight")
		vim.cmd.colorscheme("nextjs")
	end,
}
--
-- return {
-- 	"getomni/neovim",
-- 	name = "omni",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("omni")
-- 	end,
-- }

-- return {
-- 	"sainnhe/gruvbox-material",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.gruvbox_material_background = "medium"
-- 		vim.g.gruvbox_material_foreground = "material"
-- 		vim.cmd.colorscheme("gruvbox-material")
-- 	end,
-- }

-- return {
-- 	"RRethy/base16-nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("base16-default-dark")
-- 	end,
-- }
