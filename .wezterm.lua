-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
-- This will hold the action
local action = wezterm.action

-- Enable Sixel graphics
wezterm.gpu_sixel_enabled = true
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
config.font = wezterm.font("JetBrains Mono")
config.window_decorations = "RESIZE"
config.font_size = 13
-- config.color_scheme = "Batman"

config.term = "xterm-256color"

-- set leader key
config.leader = {
	km = "b",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

config.keys = {
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		km = "f",
		mods = "CTRL",
		action = action.TogglePaneZoomState,
	},
	{
		key = "c",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "j",
		mods = "SHIFT",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "k",
		mods = "SHIFT",
		action = action.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "LEADER",
		action = action.ActivateCopyMode,
	},
	{
		key = "j",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Up"),
	},
	{
		km = "h",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		km = "l",
		mods = "CTRL",
		action = action.ActivatePaneDirection("Right"),
	},

	{ km = "{", mods = "SHIFT|ALT", action = action.MoveTabRelative(-1) },
	{ km = "}", mods = "SHIFT|ALT", action = action.MoveTabRelative(1) },
}

-- and finally, return the configuration to wezterm
return config
