local wezterm = require 'wezterm'

local font_size = 11.5
local bold = false
local line_height = 1.225

local font_family = ({
  "RobotoMono Nerd Font Mono", -- [1]
  "FiraCode Nerd Font Mono", -- [2]
  "JetBrainsMono Nerd Font Mono", -- [3]
  "MesloLGMDZ Nerd Font Mono" -- [4]
})[1]

local opts = {}
if bold then opts['weight'] = 'Bold' end
local font = wezterm.font(font_family, opts)

return {
  font = font,
  font_size = font_size,
  line_height = line_height
}
