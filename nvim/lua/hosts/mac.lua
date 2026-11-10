-- macOS-only overrides.
-- lua/config/options.lua and lua/config/keymaps.lua hold settings shared
-- across every machine; put anything mac-specific (GUI font, Cmd-key maps,
-- clipboard quirks, mac-only plugins) here.

-- The CLT 26.x linker can't read the macOS 27 SDK, which breaks native plugin
-- builds (treesitter parsers, telescope-fzf-native). Build against the default SDK.
local sdk = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
if not vim.env.SDKROOT and vim.uv.fs_stat(sdk) then
	vim.env.SDKROOT = sdk
end
