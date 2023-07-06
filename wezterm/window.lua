local is_dark = true
local use_bg_image = false

local padding = 60
local window_padding = {
  left = padding,
  top = padding,
  right = padding,
  bottom = padding/3,
}

local M = {
  window_padding = window_padding,
  window_decorations = "NONE",
	initial_cols = 110,
	initial_rows = 25,
  audible_bell = "Disabled",

  show_update_window = false,

  adjust_window_size_when_changing_font_size = false,

  window_background_image_hsb = { brightness = 0.3 },

	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = is_dark and 0.85 or 0.95,
	},
}

if use_bg_image then
  M.window_background_image = "$WEZTERM_DIRECTORY/background.png"
end

return M
