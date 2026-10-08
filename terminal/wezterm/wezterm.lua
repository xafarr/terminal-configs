local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font settings
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16

-- Colors
config.colors = {
	cursor_bg = "white",
	cursor_border = "white",
}
config.color_scheme = "Catppuccin Mocha"

-- Appearance
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Miscellaneous
config.max_fps = 120
config.prefer_egl = true

return config
