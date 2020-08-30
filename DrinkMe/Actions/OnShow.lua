function get_time_to_mana_percent(percentage)
	mana_regen_base, casting = GetManaRegen();
	--print(mana_regen_base);
	seconds_until_percentage = (UnitPowerMax("player", 0) * percentage - UnitPower("player", 0)) / mana_regen_base;
	if (seconds_until_percentage > 0) then
		return seconds_until_percentage;
	else
		return 0;
	end
end

function get_mana_percentage()
	return UnitPower("player", 0) / UnitPowerMax("player", 0);
end

-- target percentage for mana
local target_mana_percentage = 0.8;

-- say something
SendChatMessage("is wolfing down some water.", "EMOTE");

local current_mana_percentage = get_mana_percentage();
SendChatMessage("Mana " .. string.format("%.0f", current_mana_percentage * 100) .. "%", "YELL");
if (target_mana_percentage > current_mana_percentage) then
	SendChatMessage("Mana " .. string.format("%.0f", target_mana_percentage * 100) .. "% in " .. string.format("%.2f", get_time_to_mana_percent(target_mana_percentage)) .. "s", "YELL");
end
