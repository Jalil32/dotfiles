local map = vim.keymap.set

-- File explorer
map("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Buffer navigation
map("n", "<A-6>", ":bprev<CR>", { noremap = true, silent = true })
map("n", "<C-6>", "<C-^>", { noremap = true, silent = true })

-- Move to the window on the left, or the tmux pane on the left if there is none
map("n", "<C-h>", function()
	local win = vim.fn.winnr()
	vim.cmd("wincmd h")
	if vim.fn.winnr() == win and vim.env.TMUX then
		vim.fn.system("tmux select-pane -L")
	end
end, { silent = true })

-- Toggle maximize for the current window, restoring the exact layout after
map("n", "<leader>z", function()
	if vim.t.zoom_restore then
		vim.cmd(vim.t.zoom_restore)
		vim.t.zoom_restore = nil
	else
		vim.t.zoom_restore = vim.fn.winrestcmd()
		vim.cmd("wincmd |")
		vim.cmd("wincmd _")
	end
end, { desc = "Toggle maximize window" })

-- Open the current file in a new tab (e.g. to explore from a diff), and close it to go back.
-- codediff's git-revision buffers (codediff://) have no LSP, so open the real file instead.
map("n", "<leader>ts", function()
	local name = vim.api.nvim_buf_get_name(0)
	local ok, vf = pcall(require, "codediff.core.virtual_file")
	local root, _, path = nil, nil, nil
	if ok and name:match("^codediff://") then
		root, _, path = vf.parse_url(name)
	end
	if root and path then
		local line = vim.fn.line(".")
		vim.cmd("tabedit " .. vim.fn.fnameescape(root .. "/" .. path))
		vim.fn.cursor(math.min(line, vim.fn.line("$")), 1)
	else
		vim.cmd("tab split")
	end
end, { desc = "Open file in new tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
