-- =========================================================
-- QEEEWWIE HUB: ULTRA-SPEED INSTANT STEAL & RETURN [SC]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

-- Variabel Status & Konfigurasi Ultra-Speed
local autoTpFarmActive = false
local speedBoostActive = false
local lowRarityOnly = false
local customWalkSpeed = 95
local basePosition = nil
local collectedEggsMemory = {}

-- =========================================================
-- PEMBUATAN UI UTAMA (ESTETIKA SUPREME & STABIL)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

-- Logo SC Mengambang (Glowing)
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
FloatingBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
FloatingBtn.Size = UDim2.new(0, 54, 0, 54)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "SC"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 100, 185)
FloatingBtn.TextSize = 22
FloatingBtn.Visible = false
FloatingBtn.Active = true
FloatingBtn.Draggable = true
FloatingBtn.ZIndex = 9999
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

local FloatingStroke = Instance.new("UIStroke", FloatingBtn)
FloatingStroke.Color = Color3.fromRGB(255, 100, 185)
FloatingStroke.Thickness = 3

-- Jendela Utama Hub
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 450)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 100, 185)
MainStroke.Thickness = 2

-- Header & Judul
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB [SC]"
Title.TextColor3 = Color3.fromRGB(255, 100, 185)
Title.Position = UDim2.new(0.08, 0, 0.02, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Ultra-Speed Instant Steal [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.065, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

-- Tombol Kontrol (Minimize & Close)
local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
MinimizeBtn.Position = UDim2.new(0.70, 0, 0.02, 0)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 11
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.85, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- Navigasi Tab Menu
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.12, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)
TabContainer.ZIndex = 11

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "AUTO FARM"
TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarm.TextSize = 10
TabFarm.ZIndex = 12
Instance.new("UICorner", TabFarm).CornerRadius = UDim.new(0, 6)

local TabPlayer = Instance.new("TextButton", TabContainer)
TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabPlayer.Position = UDim2.new(0.52, 0, 0, 0)
TabPlayer.Size = UDim2.new(0.48, 0, 1, 0)
TabPlayer.Font = Enum.Font.SourceSansBold
TabPlayer.Text = "PLAYER SPEED"
TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
TabPlayer.TextSize = 10
TabPlayer.ZIndex = 12
Instance.new("UICorner", TabPlayer).CornerRadius = UDim.new(0, 6)

-- Halaman Konten
local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.19, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.78, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.19, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.78, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

-- Tombol Fitur Ultra-Speed TP
local AutoFarmBtn = Instance.new("TextButton", PageFarm)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 100)
AutoFarmBtn.Position = UDim2.new(0, 0, 0.03, 0)
AutoFarmBtn.Size = UDim2.new(1, 0, 0, 38)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.Text = "ULTRA SPEED STEAL: OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 10
AutoFarmBtn.ZIndex = 12
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0, 6)

-- Tombol Filter Rarity
local RarityBtn = Instance.new("TextButton", PageFarm)
RarityBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
RarityBtn.Position = UDim2.new(0, 0, 0.28, 0)
RarityBtn.Size = UDim2.new(1, 0, 0, 34)
RarityBtn.Font = Enum.Font.SourceSansBold
RarityBtn.Text = "RARITY FILTER: ALL EGGS"
RarityBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
RarityBtn.TextSize = 10
RarityBtn.ZIndex = 12
Instance.new("UICorner", RarityBtn).CornerRadius = UDim.new(0, 6)

local InfoLabel = Instance.new("TextLabel", PageFarm)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
InfoLabel.Position = UDim2.new(0, 0, 0.53, 0)
InfoLabel.Size = UDim2.new(1, 0, 0, 75)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Text = "Status: Kecepatan TP & Instant Steal Dipercepat Maksimal.\nTanpa jeda lambat, langsung sedot & pulang."
InfoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
InfoLabel.TextSize = 10
InfoLabel.TextWrapped = true
InfoLabel.ZIndex = 12
Instance.new("UICorner", InfoLabel).CornerRadius = UDim.new(0, 6)

-- Tombol Halaman Player
local SpeedBtn = Instance.new("TextButton", PagePlayer)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0, 0, 0.05, 0)
SpeedBtn.Size = UDim2.new(1, 0, 0, 38)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SUPREME SPEED: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 11
SpeedBtn.ZIndex = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- =========================================================
-- KONEKSI INTERAKSI UI
-- =========================================================
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatingBtn.Visible = true
end)

FloatingBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FloatingBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

TabFarm.MouseButton1Click:Connect(function()
    PageFarm.Visible = true
    PagePlayer.Visible = false
    TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

TabPlayer.MouseButton1Click:Connect(function()
    PageFarm.Visible = false
    PagePlayer.Visible = true
    TabPlayer.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabFarm.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabFarm.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

AutoFarmBtn.MouseButton1Click:Connect(function()
    autoTpFarmActive = not autoTpFarmActive
    AutoFarmBtn.Text = autoTpFarmActive and "ULTRA SPEED STEAL: ON" or "ULTRA SPEED STEAL: OFF"
    AutoFarmBtn.BackgroundColor3 = autoTpFarmActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(180, 40, 100)
    
    if autoTpFarmActive then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            basePosition = root.CFrame
        end
    else
        table.clear(collectedEggsMemory)
    end
end)

RarityBtn.MouseButton1Click:Connect(function()
    lowRarityOnly = not lowRarityOnly
    if lowRarityOnly then
        RarityBtn.Text = "RARITY: LOW / COMMON ONLY"
        RarityBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 40)
        RarityBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        RarityBtn.Text = "RARITY FILTER: ALL EGGS"
        RarityBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        RarityBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SUPREME SPEED: ON" or "SUPREME SPEED: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- =========================================================
-- FILTER VALIDASI TELUR (ANTI-BASE, ANTI-JALUR)
-- =========================================================
local function isValidEgg(prompt, parentPart)
    if collectedEggsMemory[prompt] then
        return false
    end

    local partName = string.lower(parentPart.Name)
    local parentObj = parentPart.Parent
    local grandParent = parentObj and parentObj.Parent
    local greatGrandParent = grandParent and grandParent.Parent
    
    local parentName = parentObj and string.lower(parentObj.Name) or ""
    local grandName = grandParent and string.lower(grandParent.Name) or ""
    local greatName = greatGrandParent and string.lower(greatGrandParent.Parent and greatGrandParent.Name or "") or ""
    local promptText = string.lower((prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
    
    local fullStr = partName .. " " .. parentName .. " " .. grandName .. " " .. greatName .. " " .. promptText
    
    -- Blacklist area Jalur, Display, Toko, NPC
    if fullStr:find("jalur") or fullStr:find("toko") or fullStr:find("shop") or fullStr:find("display") or fullStr:find("npc") or fullStr:find("bicara") or fullStr:find("talk") or fullStr:find("board") then
        return false
    end
    
    -- Blacklist area Base / Claimed / Tycoon
    if fullStr:find("base") or fullStr:find("plot") or fullStr:find("claim") or fullStr:find("tycoon") or fullStr:find("pedestal") or fullStr:find("stand") or fullStr:find("placed") or fullStr:find("mybase") then
        return false
    end
    
    local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("hatch") or fullStr:find("halloween") or fullStr:find("event") or fullStr:find("forest")
    local isRestricted = fullStr:find("robux") or fullStr:find("buy") or fullStr:find("purchase") or fullStr:find("pass")
    
    if not (isEgg and not isRestricted) then
        return false
    end
    
    if lowRarityOnly then
        local isHighRarity = fullStr:find("divine") or fullStr:find("cherub") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole") or fullStr:find("mythic") or fullStr:find("legendary")
        if isHighRarity then
            return false
        end
    end
    
    return true
end

-- =========================================================
-- MESIN UTAMA: ULTRA-SPEED TP & INSTANT STEAL
-- =========================================================
task.spawn(function()
    while true do
        task.wait(0.08) -- Loop dipercepat ekstrem (hampir tanpa jeda antar deteksi)
        if autoTpFarmActive then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                
                if not basePosition then
                    basePosition = root.CFrame
                end
                
                local availableEggs = {}
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not autoTpFarmActive then break end
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        if parentPart and parentPart:IsA("BasePart") then
                            if isValidEgg(prompt, parentPart) then
                                table.insert(availableEggs, {prompt = prompt, part = parentPart})
                            end
                        end
                    end
                end
                
                if #availableEggs > 0 then
                    table.sort(availableEggs, function(a, b)
                        return (root.Position - a.part.Position).Magnitude < (root.Position - b.part.Position).Magnitude
                    end)
                    
                    local target = availableEggs[1]
                    if target and autoTpFarmActive then
                        collectedEggsMemory[target.prompt] = true
                        
                        -- 1. Teleport kilat ke telur liar
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        root.CFrame = target.part.CFrame + Vector3.new(0, 3.5, 0)
                        
                        -- 2. INSTANT STEAL KILAT (Picu tembus beruntun tanpa delay)
                        target.prompt.HoldDuration = 0
                        if fireproximityprompt then
                            fireproximityprompt(target.prompt)
                            fireproximityprompt(target.prompt) -- Double trigger biar langsung tembus ke-steal
                        end
                        
                        task.wait(0.04) -- Jeda ultra singkat setelah ambil
                        
                        -- 3. Teleport balik kilat ke Base
                        if basePosition and autoTpFarmActive then
                            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            root.CFrame = basePosition
                        end
                        
                        task.wait(0.08) -- Jeda kilat sebelum lanjut ke telur berikutnya
                    end
                else
                    table.clear(collectedEggsMemory)
                    task.wait(0.5)
                end
            end)
        end

        local char = LocalPlayer.Character
        if speedBoostActive and char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = customWalkSpeed end
        elseif char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 16 end
        end
    end
end)
