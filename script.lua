-- =========================================================
-- QEEEWWIE HUB: DIRECT ULTRA-SAFE NO-UI ENGINE (RIDE A PET)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("Qeeewwie Direct Engine Activated!")

local maxInteractDistance = 35 -- Jarak aman maksimal (studs) dari karakter

task.spawn(function()
    while true do
        task.wait(0.15)
        pcall(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            
            if root then
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        local grandParent = parentPart and parentPart.Parent
                        
                        if parentPart and parentPart:IsA("BasePart") and (root.Position - parentPart.Position).Magnitude <= maxInteractDistance then
                            local partName = string.lower(parentPart.Name)
                            local parentName = grandParent and string.lower(grandParent.Name) or ""
                            local fullStr = partName .. " " .. parentName
                            local promptText = string.lower((prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
                            
                            -- Deteksi Telur
                            local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
                            
                            -- PENGAMAN MUTLAK: Blokir total jika ada unsur Robux, Beli, Lewat, atau Toko
                            local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase") or promptText:find("lewat") or promptText:find("skip") or fullStr:find("shop") or fullStr:find("toko")
                            
                            if isEgg and not isRestricted then
                                prompt.HoldDuration = 0
                                if fireproximityprompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
