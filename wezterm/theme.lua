{{ #if (eq_string use-native-colorscheme "true") }}
local theme = ({
	"Oxocarbon Dark", -- [1]
	"Catppuccin Mocha", -- [2]
})[1]

return {
	color_scheme = theme,
}
{{ /if }}

{{ #if (eq_string use-native-colorscheme "false") }}
local colors, _ = require("wezterm").color.load_base16_scheme(os.getenv( "HOME" ) .. "/.config/wezterm/colors/dynamic-base16.yaml") 
return {
    colors = colors
}
{{ /if}}
