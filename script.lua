-- =========================================================
-- QEEEWWIE HUB: FIX AUTO TP & LOCK POSITION
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local autoTeleportEggActive = false
local autoCollectActive = false
local speedBoostActive = false
local customWalkSpeed = 50
local selectedRarity = "all"

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.03, 0)
Title.Size = UDim2.new(0.85, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Fix Teleport Base [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.10, 0)
SubTitle.Size = UDim2.new(0.85, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.18, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "EGG & RARITY"
TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarm.TextSize = 10
Instance.new("UICorner", TabFarm).CornerRadius = UDim.new(0, 6)

local TabPlayer = Instance.new("TextButton", TabContainer)
TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabPlayer.Position = UDim2.new(0.52, 0, 0, 0)
TabPlayer.Size = UDim2.new(0.48, 0, 1, 0)
TabPlayer.Font = Enum.Font.SourceSansBold
TabPlayer.Text = "PLAYER SPEED"
TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
TabPlayer.TextSize = 10
Instance.new("UICorner", TabPlayer).CornerRadius = UDim.new(0, 6)

local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.28, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.68, 0)

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.28, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.68, 0)
PagePlayer.Visible = false

local TeleportEggBtn = Instance.new("TextButton", PageFarm)
TeleportEggBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
TeleportEggBtn.Position = UDim2.new(0, 0, 0.02, 0)
TeleportEggBtn.Size = UDim2.new(1, 0, 0, 32)
TeleportEggBtn.Font = Enum.Font.SourceSansBold
TeleportEggBtn.Text = "AUTO TP TO EGG: OFF"
TeleportEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportEggBtn.TextSize = 11
Instance.new("UICorner", TeleportEggBtn).CornerRadius = UDim.new(0, 6)

local RarityBtn = Instance.new("TextButton", PageFarm)
RarityBtn.BackgroundColor3 = Color3.fromRGB(90, 60, 150)
RarityBtn.Position = UDim2.new(0, 0, 0.38, 0)
RarityBtn.Size = UDim2.new(1, 0, 0, 32)
RarityBtn.Font = Enum.Font.SourceSansBold
RarityBtn.Text = "RARITY FILTER: ALL"
RarityBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityBtn.TextSize = 11
Instance.new("UICorner", RarityBtn).CornerRadius = UDim.new(0, 6)

local CollectBtn = Instance.new("TextButton", PageFarm)
CollectBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CollectBtn.Position = UDim2.new(0, 0, 0.73, 0)
CollectBtn.Size = UDim2.new(1, 0, 0, 32)
CollectBtn.Font = Enum.Font.SourceSansBold
CollectBtn.Text = "AUTO COLLECT: OFF"
CollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectBtn.TextSize = 11
Instance.new("UICorner", CollectBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", PagePlayer)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0, 0, 0.02, 0)
SpeedBtn.Size = UDim2.new(1, 0, 0, 38)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

TabFarm.Activated:Connect(function()
    PageFarm.Visible = true
    PagePlayer.Visible = false
    TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

TabPlayer.Activated:Connect(function()
    PageFarm.Visible = false
    PagePlayer.Visible = true
    TabPlayer.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabFarm.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabFarm.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

RarityBtn.Activated:Connect(function()
    if selectedRarity == "all" then
        selectedRarity = "cherub"
        RarityBtn.Text = "RARITY: CHERUB / MYTHIC"
    elseif selectedRarity == "cherub" then
        selectedRarity = "legendary"
        RarityBtn.Text = "RARITY: LEGENDARY"
    elseif selectedRarity == "legendary" then
        selectedRarity = "epic"
        RarityBtn.Text = "RARITY: EPIC"
    elseif selectedRarity == "epic" then
        selectedRarity = "rare"
        RarityBtn.Text = "RARITY: RARE"
    else
        selectedRarity = "all"
        RarityBtn.Text = "RARITY FILTER: ALL"
    end
end)

TeleportEggBtn.Activated:Connect(function()
    autoTeleportEggActive = not autoTeleportEggActive
    TeleportEggBtn.Text = autoTeleportEggActive and "AUTO TP TO EGG: ON" or "AUTO TP TO EGG: OFF"
    TeleportEggBtn.BackgroundColor3 = autoTeleportEggActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 100, 50)
end)

CollectBtn.Activated:Connect(function()
    autoCollectActive = not autoCollectActive
    CollectBtn.Text = autoCollectActive and "AUTO COLLECT: ON" or "AUTO COLLECT: OFF"
    CollectBtn.BackgroundColor3 = autoCollectActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

SpeedBtn.Activated:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SPEED BOOST: ON" or "SPEED BOOST: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- Engine Anti-Pull Back ke Base
task.spawn(function()
    while true do
        task.wait(0.5)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if root then
            if autoTeleportEggActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if autoTeleportEggActive and (obj:IsA("Model") or obj:IsA("BasePart")) then
                        local nameLower = string.lower(obj.Name)
                        if nameLower:find("egg") or nameLower:find("telur") or nameLower:find("cherub") then
                            local matchRarity = (selectedRarity == "all") or nameLower:find(selectedRarity)

                            if matchRarity then
                                local partPos = obj:IsA("BasePart") and obj.Position or (obj.PrimaryPart and obj.PrimaryPart.Position)
                                if partPos then
                                    -- Kunci posisi di atas telur terus menerus agar tidak tertarik ke base
                                    root.CFrame = CFrame.new(partPos + Vector3.new(0, 3, 0))
                                    
                                    for _, prompt in pairs(obj:GetDescendants()) do
                                        if prompt:IsA("ProximityPrompt") then
                                            prompt.HoldDuration = 0
                                            if fireproximityprompt then fireproximityprompt(prompt) end
                                        end
                                    end
                                    task.wait(2) -- Diam sebentar di telur tersebut sebelum cari yang lain
                                    break
                                end
                            end
                        end
                    end
                end
            end

            if autoCollectActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local nameLower = string.lower(obj.Name)
                        if nameLower:find("coin") or nameLower:find("gem") or nameLower:find("cash") or nameLower:find("money") then
                            if (root.Position - obj.Position).Magnitude <= 100 then
                                if firetouchinterest then
                                    firetouchinterest(root, obj, 0)
                                    firetouchinterest(root, obj, 1)
                                end
                            end
                        end
                    end
                end
            end

            if speedBoostActive then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = customWalkSpeed end
            else
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 16 end
            end
        end
    end
end)
