local opt = vim.opt

-- Line numbers
opt.nu = true
opt.relativenumber = true
opt.numberwidth = 2

-- Tabs and indentation
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Display
opt.wrap = true
opt.linebreak = true -- break at word boundaries, not mid-word
opt.breakindent = true -- wrapped lines keep the original indentation
opt.scrolloff = 20
opt.sidescrolloff = 8
opt.pumheight = 10
opt.cmdheight = 1
opt.showmode = false
opt.conceallevel = 0
-- Highlight only the current line number (CursorLineNr), not the whole line
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Floating window borders (LSP hover, signature help, diagnostics, etc.)
opt.winborder = "rounded"

-- System
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.undofile = true
opt.timeoutlen = 1000
opt.completeopt = "menuone,noselect"

-- Line wrapping behaviour
opt.whichwrap:append("b,s,<,>,[,],h,l")
opt.shortmess:append("c")
opt.guicursor = {
	"n-v-c:block-blinkon250-blinkoff250",
	"i-ci-ve:ver25-blinkon250-blinkoff250",
	"r-cr-o:hor20-blinkon250-blinkoff250",
}

-- Netrw
vim.g.netrw_banner = 0

-- Winbar: show the current path relative to the project (cwd)
local function project_path(path)
	local cwd = vim.fn.getcwd()
	local root = vim.fn.fnamemodify(cwd, ":t")
	if path == cwd then
		return root
	elseif vim.startswith(path, cwd .. "/") then
		return root .. "/" .. path:sub(#cwd + 2)
	end
	return vim.fn.fnamemodify(path, ":~")
end

-- Renders as a breadcrumb: dim dirs, › separators, icon + bold filename, dot when modified.
-- Inactive windows render entirely in WinBarNC.
function _G.path_winbar()
	local active = vim.g.statusline_winid == tonumber(vim.g.actual_curwin)
	local function hl(group, text)
		text = text:gsub("%%", "%%%%")
		return active and ("%#" .. group .. "#" .. text) or text
	end

	local is_netrw = vim.bo.filetype == "netrw"
	local path = is_netrw and project_path(vim.b.netrw_curdir or vim.fn.expand("%:p:h"))
		or project_path(vim.fn.expand("%:p"))
	local parts = vim.split(path, "/", { trimempty = true })
	local name = is_netrw and "" or table.remove(parts)

	local out = { active and "%#WinBar# " or "%#WinBarNC# " }
	for _, dir in ipairs(parts) do
		table.insert(out, hl("WinBarDir", dir) .. hl("WinBarSep", " › "))
	end
	if is_netrw then
		return table.concat(out)
	end

	local ok, devicons = pcall(require, "nvim-web-devicons")
	if ok then
		local icon, icon_hl = devicons.get_icon(name, vim.fn.fnamemodify(name, ":e"), { default = true })
		table.insert(out, hl(icon_hl, icon .. " "))
	end
	table.insert(out, hl("WinBarFile", name))
	if vim.bo.modified then
		table.insert(out, hl("WinBarModified", " ●"))
	end
	return table.concat(out)
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
	callback = function()
		local is_netrw = vim.bo.filetype == "netrw"
		local is_file = vim.bo.buftype == "" and vim.fn.expand("%") ~= ""
		if is_netrw or is_file then
			vim.wo.winbar = "%{%v:lua.path_winbar()%}"
		elseif vim.wo.winbar:find("path_winbar", 1, true) then
			vim.wo.winbar = ""
		end
	end,
})

-- Transparent background
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		-- Soft grey borders for all popups (LSP, cmp, harpoon, snacks)
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#4f4f4f", bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#4f4f4f", bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })

		-- Telescope
		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#4f4f4f", bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#4f4f4f", bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#4f4f4f", bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#4f4f4f", bg = "none" })

		-- vscode style for nvimcmp
		-- gray
		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
		-- blue
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
		-- light blue
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
		vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
		-- pink
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
		-- front
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
	end,
})

-- Format on save is handled by conform.nvim (lua/plugins/conform.lua).

-- JS/TS family: 2-space indentation (Prettier's default)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc", "yaml", "css", "scss" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

-- Set colors for TMUX
vim.o.termguicolors = true

-- Disable legacy sqlcomplete
vim.g.omni_sql_default_compl_type = "syntax"

-- Stop auto comment on next line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.g.omni_sql_no_default_maps = 1

-- Enable diagnostics
vim.diagnostic.config({
	virtual_text = true, -- Show virtual text for diagnostics
	signs = true, -- Show diagnostic signs (error, warning, etc.)
	underline = true, -- Underline the lines with errors
	update_in_insert = true, -- Update diagnostics while typing
	float = {
		border = "rounded",
	},
})

-- Reload buffers changed outside Neovim (e.g. by Claude Code in another tmux pane)
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	callback = function()
		vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
	end,
})
