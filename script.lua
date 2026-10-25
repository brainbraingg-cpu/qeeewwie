-- =========================================================
-- QEEEWWIE HUB: SAFE ANTI-ROBUX AUTO-FARM (RIDE A PET)
-- =========================================================

local Workspace = game:GetService("Workspace")

print("Safe Anti-Robux Auto-Farm Active!")

task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local parent = prompt.Parent
                    local grandParent = parent and parent.Parent
                    local fullStr = string.lower((parent and parent.Name or "") .. " " .. (grandParent and grandParent.Name or ""))
                    local promptText = string.lower((prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
                    
                    -- Deteksi Telur yang sah
                    local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("blackhole") or fullStr:find("solaris")
                    
                    -- FILTER KETAT: Blokir mutlak semua hal berbau Robux, Beli, dan Lewat (Skip)
                    local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase") or promptText:find("lewat") or promptText:find("skip") or fullStr:find("shop") or fullStr:find("toko")
                    
                    if isEgg and not isRestricted then
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
