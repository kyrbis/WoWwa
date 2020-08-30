function get_mana_percentage()
	return UnitPower("player", 0) / UnitPowerMax("player", 0);
end

SendChatMessage("Mana " .. string.format("%.0f", get_mana_percentage() * 100) .. "%", "YELL");
SendChatMessage("Is done drinking.", "EMOTE");