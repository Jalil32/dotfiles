return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G", "Gread", "Gwrite", "Gdiff", "Gblame" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>" },
		{ "<leader>gb", "<cmd>Git blame<cr>" },
	},
}
