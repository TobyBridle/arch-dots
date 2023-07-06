local wezterm = require("wezterm")

local function send_hash(window, pane)
	window:perform_action(wezterm.action.SendKey({ key = "#", mods = "" }), pane)
end

wezterm.on("SendKeyHash", function(window, pane)
	send_hash(window, pane)
end)

local M = {
	keys = {
		{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
		-- { key = "[", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
		-- { key = "]", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
		-- { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
		-- { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
		-- { key = "v", mods = "ALT", action = wezterm.action.ActivateCopyMode },
		-- { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		-- { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "3", mods = "ALT", action = wezterm.action.EmitEvent("SendKeyHash") },
	},
}

return M
