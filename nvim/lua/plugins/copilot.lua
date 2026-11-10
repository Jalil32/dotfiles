return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		vim.keymap.set("n", "<leader>cp", function()
			local status = vim.g.copilot_enabled
			if status == nil or status == true then
				vim.cmd("Copilot disable")
				vim.g.copilot_enabled = false
				print("Copilot disabled")
			else
				vim.cmd("Copilot enable")
				vim.g.copilot_enabled = true
				print("Copilot enabled")
			end
		end)
	end,
}
