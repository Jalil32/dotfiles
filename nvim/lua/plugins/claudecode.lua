return {
	"coder/claudecode.nvim",
	cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd", "ClaudeCodeTreeAdd" },
	opts = {
		terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
		focus_after_send = true,
		terminal = {
			split_side = "right",
			split_width_percentage = 0.35,
			provider = "native",
		},
	},
	config = function(_, opts)
		require("claudecode").setup(opts)

		-- Ctrl-h in the Claude panel jumps back to the editor window
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*claude*",
			callback = function(ev)
				vim.keymap.set("t", "<C-h>", "<cmd>wincmd p<cr>", { buffer = ev.buf, desc = "Back to editor" })
			end,
		})
	end,
	keys = {
		{ "<leader>Cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
		{ "<leader>Cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
		{ "<leader>Cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
		{ "<leader>CC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>Cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>Cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
		{ "<leader>Cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send selection to Claude" },
		{ "<leader>Ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
		{ "<leader>Cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
	},
}
