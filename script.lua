-- =========================================================
-- QEEEWWIE HUB: DIRECT NO-UI AUTO EXECUTE (RIDE A PET)
-- =========================================================

local Workspace = game:GetService("Workspace")

print("Qeeewwie Hub Direct Auto-Farm Started!")

task.spawn(function()
    while true do
        task.wait(0.15)
        pcall(function()
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local parent = prompt.Parent
                    local fullStr = string.lower((parent and parent.Name or "") .. " " .. (parent and parent.Parent and parent.Parent.Name or ""))
                    local promptText = string.lower(prompt.ActionText .. " " .. prompt.ObjectText)
                    
                    -- Deteksi Telur di Map atau Base Orang
                    local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("blackhole") or fullStr:find("solaris")
                    local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase")
                    
                    if isEgg and not isRestricted then
                        -- Jadikan Instant (0 detik) dan langsung sikat
                        prompt.HoldDuration = 0
                        if fireproximityprompt then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end)
    end
end)
