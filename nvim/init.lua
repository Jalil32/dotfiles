-- Leader key (must be before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.omni_sql_default_compl_type = "syntax"
-- Load core config
require("config.options")
require("config.keymaps")

-- Host-specific overrides (mac vs linux)
local os_name = vim.uv.os_uname().sysname
if os_name == "Darwin" then
	require("hosts.mac")
elseif os_name == "Linux" then
	require("hosts.linux")
end

-- Load plugins
require("config.lazy")
