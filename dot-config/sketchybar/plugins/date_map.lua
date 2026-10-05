-- TODO: is there a way to source this dynamically from the SF Pro Font in Lua???
local dates = {
	[1] = "􃌦 ",
	[2] = "􃌧 ",
	[3] = "􃌨 ",
	[4] = "􃌩 ",
	[5] = "􃌪 ",
	[6] = "􃌫 ",
	[7] = "􃌬 ",
	[8] = "􃌭 ",
	[9] = "􃌮 ",
	[10] = "􃌯 ",
	[11] = "􃌰 ",
	[12] = "􃌱 ",
	[13] = "􃌲 ",
	[14] = "􃌳 ",
	[15] = "􃌴 ",
	[16] = "􃌵 ",
	[17] = "􃌶 ",
	[18] = "􃌷 ",
	[19] = "􃌸 ",
	[20] = "􃌹 ",
	[21] = "􃌺 ",
	[22] = "􃌻 ",
	[23] = "􃌼 ",
	[24] = "􃌽 ",
	[25] = "􃌾 ",
	[26] = "􃌿 ",
	[27] = "􃍀 ",
	[28] = "􃍁 ",
	[29] = "􃍂 ",
	[30] = "􃍃 ",
	[31] = "􃍄 ",
}

local function date_map(idx)
	if dates[idx] then
		return dates[idx]
	end
	return "􃏝 "
end

return date_map
