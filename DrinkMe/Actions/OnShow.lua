-- Function to simulate mana regeneration over time.
-- Note: This is a simplified model based on the provided logic.
function regen_simulation(target_p, current_p)
    local needed_p = target_p - current_p
    local regen_p = 0
    local regen_s = 0
    
    -- Only simulate if mana is needed.
    if needed_p <= 0 then
        return 0
    end
    
    while regen_p < needed_p do  -- according to https://www.wowhead.com/news=318430/water-regenerates-mana-slower-in-the-first-seconds-of-drinking-in-shadowlands-de#new-base-mana-and-mana-regen-values
        regen_s = regen_s + 1 --regeneration in %
        if regen_s <= 2 then
            regen_p = regen_p + 1 -- First 2 seconds
        elseif regen_s <= 4 then
            regen_p = regen_p + 2 -- Seconds 3-4
        elseif regen_s <= 6 then
            regen_p = regen_p + 3 -- Seconds 5-6
        elseif regen_s <= 8 then
            regen_p = regen_p + 4 -- Seconds 7-8
        elseif regen_s <= 10 then
            regen_p = regen_p + 5 -- Seconds 9-10
        else
            regen_p = regen_p + 6 -- After 10 seconds
        end
    end
    return regen_s
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
