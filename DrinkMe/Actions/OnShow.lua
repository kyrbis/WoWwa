function regen_simulation(target_mana_p, current_mana_p)
    local needed_p = target_mana_p - current_mana_p
    local regen_p = 0
    local regen_s = 0
    while regen_p < needed_p do -- according to https://www.wowhead.com/news=318430/water-regenerates-mana-slower-in-the-first-seconds-of-drinking-in-shadowlands-de#new-base-mana-and-mana-regen-values
        if (regen_s < 2) then --first two seconds
            regen_p = regen_p + 2 --regeneration in %
        elseif (regen_s < 3) then
            regen_p = regen_p + 3
        elseif (regen_s < 5) then
            regen_p = regen_p + 4
        elseif (regen_s < 6) then
            regen_p = regen_p + 4
        elseif (regen_s < 7) then
            regen_p = regen_p + 5
        elseif (regen_s > 7) then
            regen_p = regen_p + 6
        else
            regen_p = regen_p + 5 --fallback default
            print("Fallback Value. This shouldn't happen!")
        end
        regen_s = regen_s + 1
    end
    return regen_s;
end

function get_mana_percentage()
    return 100 * UnitPower("player", 0) / UnitPowerMax("player", 0)
end


-- target percentage for mana
local target_mana_percentage = 80

local current_mana_percentage = get_mana_percentage()

-- say something
SendChatMessage("is wolfing down some water.", "EMOTE");
SendChatMessage("Mana " .. string.format("%.0f", current_mana_percentage) .. "%", "YELL")

if (target_mana_percentage > current_mana_percentage) then
    SendChatMessage("Mana " .. string.format("%.0f", target_mana_percentage) .. "% in " .. string.format("%.0f", regen_simulation(target_mana_percentage, current_mana_percentage)) .. "s (Mana Bun)", "YELL")
end
