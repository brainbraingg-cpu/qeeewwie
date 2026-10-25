-- =========================================================
-- QEEEWWIE HUB: ULTRA SAFE ANTI-ROBUX V2 (RIDE A PET)
-- =========================================================

local Workspace = game:GetService("Workspace")

print("Ultra Safe Anti-Robux V2 Active!")

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
                    
                    -- Deteksi khusus telur utama
                    local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("blackhole") or fullStr:find("solaris")
                    
                    -- Proteksi Berlapis: Blokir jika ada unsur harga, angka robux, skip, atau beli
                    local hasPrice = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase") or promptText:find("lewat") or promptText:find("skip") or promptText:find("rs") or promptText:find("🪙") or promptText:find("💎")
                    local isShop = fullStr:find("shop") or fullStr:find("toko") or fullStr:find("store") or fullStr:find("incubator")
                    
                    -- Hanya jalankan jika murni telur dan TIDAK ADA unsur berbayar/shop sama sekali
                    if isEgg and not hasPrice and not isShop then
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
