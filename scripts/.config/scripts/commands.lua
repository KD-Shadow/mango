#!/bin/env lua

local commands = {
	{ name = "file manager", exec = "yazi" },
	{ name = "typing test", exec = "/home/$USER/go/bin/gotype" },
	{ name = "cava", exec = "cava" },
	{ name = "tui music", exec = "rmpc" },
	{ name = "yt downloader", exec = "xytz" },
	{ name = "youtube", exec = "/home/$USER/.config/scripts/vid-cli" },
	{ name = "anime", exec = "/home/$USER/.config/scripts/ani-cli" },
	{ name = "btop", exec = "btop" },
}
local terminal = "ghostty"

local rofi_theme = "/home/$USER/.config/rofi/style_3.rasi"
local rofi_base = { "rofi", "-dmenu", "-theme", tostring(rofi_theme) }

local function file_exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

local function open_rofi(items, prompt)
	prompt = prompt or "Select"
	if not items or #items == 0 then
		return nil
	end
	local rofi_input = table.concat(items, "\n")

	-- Build rofi command arguments
	local rofi_args = {}
	for i, v in ipairs(rofi_base) do
		rofi_args[i] = v
	end
	table.insert(rofi_args, "-p")
	table.insert(rofi_args, prompt)

	-- Use io.popen with read mode, not write mode
	local cmd = table.concat(rofi_args, " ")
	local handle = io.popen("echo '" .. rofi_input:gsub("'", "'\"'\"'") .. "' | " .. cmd, "r")

	if not handle then
		return nil
	end

	local result = handle:read("*a")
	handle:close()

	if result then
		result = result:gsub("^%s+", ""):gsub("%s+$", "")
		if result == "" then
			return nil
		end
		return result
	end
	return nil
end

local function open_command(selected_cmd)
	if not selected_cmd or selected_cmd == "" then
		return
	end
	-- Execute the command in terminal
	local cmd = terminal .. " -e " .. selected_cmd
	os.execute(cmd)
end

-- Test theme exists
if file_exists(rofi_theme) then
	print("Theme file exists")
else
	print("Theme file doesn't exist")
end

-- Create display list and command mapping
local display_list = {}
local cmd_map = {}

for _, cmd in ipairs(commands) do
	table.insert(display_list, cmd.name)
	cmd_map[cmd.name] = cmd.exec
end

-- Show rofi and get selection
local rofi_output = open_rofi(display_list, "Choose command:")

-- Execute the corresponding command
if rofi_output and cmd_map[rofi_output] then
	open_command(cmd_map[rofi_output])
elseif rofi_output then
	print("Error: No command found for selection: " .. rofi_output)
end
