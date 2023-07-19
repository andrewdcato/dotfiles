local wezterm = require("wezterm")

local Tab = {}

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = wezterm.color.parse("blue") },
			{ Text = "󰡨" },
		},
		["docker-compose"] = {
			{ Foreground = wezterm.color.parse("blue") },
			{ Text = "󰡨" },
		},
		["nvim"] = {
			{ Foreground = wezterm.color.parse("green") },
			{ Text = "" },
		},
		["bob"] = {
			{ Foreground = wezterm.color.parse("blue") },
			{ Text = "" },
		},
		["vim"] = {
			{ Foreground = wezterm.color.parse("green") },
			{ Text = "" },
		},
		["node"] = {
			{ Foreground = wezterm.color.parse("green") },
			{ Text = "󰋘" },
		},
		["zsh"] = {
			{ Foreground = wezterm.color.parse("overlay1") },
			{ Text = "" },
		},
		["bash"] = {
			{ Foreground = wezterm.color.parse("overlay1") },
			{ Text = "" },
		},
		["htop"] = {
			{ Foreground = wezterm.color.parse("yellow") },
			{ Text = "" },
		},
		["btop"] = {
			{ Foreground = wezterm.color.parse("rosewater") },
			{ Text = "" },
		},
		["cargo"] = {
			{ Foreground = wezterm.color.parse("peach") },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["go"] = {
			{ Foreground = wezterm.color.parse("sapphire") },
			{ Text = "" },
		},
		["git"] = {
			{ Foreground = wezterm.color.parse("peach") },
			{ Text = "󰊢" },
		},
		["lazygit"] = {
			{ Foreground = wezterm.color.parse("mauve") },
			{ Text = "󰊢" },
		},
		["lua"] = {
			{ Foreground = wezterm.color.parse("blue") },
			{ Text = "" },
		},
		["wget"] = {
			{ Foreground = wezterm.color.parse("yellow") },
			{ Text = "󰄠" },
		},
		["curl"] = {
			{ Foreground = wezterm.color.parse("yellow") },
			{ Text = "" },
		},
		["gh"] = {
			{ Foreground = wezterm.color.parse("mauve") },
			{ Text = "" },
		},
		["flatpak"] = {
			{ Foreground = wezterm.color.parse("blue") },
			{ Text = "󰏖" },
		},
		["dotnet"] = {
			{ Foreground = wezterm.color.parse("mauve") },
			{ Text = "󰪮" },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	if not process_name then
		process_name = "zsh"
	end

	return wezterm.format(
		process_icons[process_name]
			or { { Foreground = wezterm.color.parse("sky") }, { Text = string.format("[%s]", process_name) } }
	)
end

local function get_current_working_folder_name(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	cwd_uri = cwd_uri:sub(8)

	local slash = cwd_uri:find("/")
	local cwd = cwd_uri:sub(slash)

	local HOME_DIR = os.getenv("HOME")
	if cwd == HOME_DIR then
		return "  ~"
	end

	return string.format("  %s", string.match(cwd, "[^/]+$"))
end

function Tab.setup(config)
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 50
	config.hide_tab_bar_if_only_one_tab = false

	wezterm.on("format-tab-title", function(tab)
		return wezterm.format({
			{ Attribute = { Intensity = "Half" } },
			{ Foreground = wezterm.color.parse("surface2") },
			{ Text = string.format(" %s  ", tab.tab_index + 1) },
			"ResetAttributes",
			{ Text = get_process(tab) },
			{ Text = " " },
			{ Text = get_current_working_folder_name(tab) },
			{ Foreground = wezterm.color.parse("base") },
			{ Text = "  ▕" },
		})
	end)
end

return Tab
