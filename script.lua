-- =========================================================
-- QEEEWWIE HUB V9: HYPER FARM EDITION (SENJU THEME)
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local autoEggFarmActive = false
local autoHalloweenActive = false
local autoCollectActive = false
local speedBoostActive = false
local customWalkSpeed = 10000000

-- 1. Membuat UI Utama
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.04, 0)
Title.Size = UDim2.new(0.85, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Hyper Farm Edition [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.13, 0)
SubTitle.Size = UDim2.new(0.85, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1

-- 2. Sistem Tab
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.22, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 30)

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "FARM & EVENT"
TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarm.TextSize = 11
Instance.new("UICorner", TabFarm).CornerRadius = UDim.new(0, 6)

local TabPlayer = Instance.new("TextButton", TabContainer)
TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabPlayer.Position = UDim2.new(0.52, 0, 0, 0)
TabPlayer.Size = UDim2.new(0.48, 0, 1, 0)
TabPlayer.Font = Enum.Font.SourceSansBold
TabPlayer.Text = "PLAYER SPEED"
TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
TabPlayer.TextSize = 11
Instance.new("UICorner", TabPlayer).CornerRadius = UDim.new(0, 6)

-- 3. Container Halaman
local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.34, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.62, 0)

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.34, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.62, 0)
PagePlayer.Visible = false

local EggFarmBtn = Instance.new("TextButton", PageFarm)
EggFarmBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
EggFarmBtn.Position = UDim2.new(0, 0, 0.02, 0)
EggFarmBtn.Size = UDim2.new(1, 0, 0, 32)
EggFarmBtn.Font = Enum.Font.SourceSansBold
EggFarmBtn.Text = "AUTO FARM EGG: OFF"
EggFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EggFarmBtn.TextSize = 11
Instance.new("UICorner", EggFarmBtn).CornerRadius = UDim.new(0, 6)

local HalloweenBtn = Instance.new("TextButton", PageFarm)
HalloweenBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
HalloweenBtn.Position = UDim2.new(0, 0, 0.35, 0)
HalloweenBtn.Size = UDim2.new(1, 0, 0, 32)
HalloweenBtn.Font = Enum.Font.SourceSansBold
HalloweenBtn.Text = "AUTO HALLOWEEN: OFF"
HalloweenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HalloweenBtn.TextSize = 11
Instance.new("UICorner", HalloweenBtn).CornerRadius = UDim.new(0, 6)

local CollectBtn = Instance.new("TextButton", PageFarm)
CollectBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CollectBtn.Position = UDim2.new(0, 0, 0.68, 0)
CollectBtn.Size = UDim2.new(1, 0, 0, 32)
CollectBtn.Font = Enum.Font.SourceSansBold
CollectBtn.Text = "AUTO COLLECT COIN: OFF"
CollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectBtn.TextSize = 11
Instance.new("UICorner", CollectBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", PagePlayer)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0, 0, 0.02, 0)
SpeedBtn.Size = UDim2.new(1, 0, 0, 40)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- 4. Logika Tab
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

-- 5. Event Tombol UI
EggFarmBtn.Activated:Connect(function()
    autoEggFarmActive = not autoEggFarmActive
    EggFarmBtn.Text = autoEggFarmActive and "AUTO FARM EGG: ON" or "AUTO FARM EGG: OFF"
    EggFarmBtn.BackgroundColor3 = autoEggFarmActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 100, 50)
end)

HalloweenBtn.Activated:Connect(function()
    autoHalloweenActive = not autoHalloweenActive
    HalloweenBtn.Text = autoHalloweenActive and "AUTO HALLOWEEN: ON" or "AUTO HALLOWEEN: OFF"
    HalloweenBtn.BackgroundColor3 = autoHalloweenActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(150, 50, 200)
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

-- 6. Engine Farming Serbaguna (Hyper Interaction Loop)
task.spawn(function()
    while true do
        task.wait(0.15)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if root then
            -- AUTO FARM EGG
            if autoEggFarmActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    local nameLower = string.lower(obj.Name)
                    if nameLower:find("egg") or nameLower:find("telur") or nameLower:find("cherub") then
                        -- Fire ProximityPrompt
                        if obj:IsA("ProximityPrompt") and obj.Enabled then
                            obj.HoldDuration = 0
                            if fireproximityprompt then fireproximityprompt(obj) end
                        -- Fire ClickDetector
                        elseif obj:IsA("ClickDetector") then
                            if fireclickdetector then fireclickdetector(obj) end
                        -- Fire TouchInterest jika berbentuk Part
                        elseif obj:IsA("BasePart") and obj:FindFirstChildOfClass("TouchTransmitter") then
                            if firetouchinterest then
                                firetouchinterest(root, obj, 0)
                                firetouchinterest(root, obj, 1)
                            end
                        end
                    end
                end
            end

            -- AUTO HALLOWEEN EVENT
            if autoHalloweenActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    local nameLower = string.lower(obj.Name)
                    if nameLower:find("halloween") or nameLower:find("candy") or nameLower:find("pumpkin") then
                        if obj:IsA("ProximityPrompt") and obj.Enabled then
                            obj.HoldDuration = 0
                            if fireproximityprompt then fireproximityprompt(obj) end
                        elseif obj:IsA("BasePart") and (root.Position - obj.Position).Magnitude <= 100 then
                            if firetouchinterest and obj:FindFirstChildOfClass("TouchTransmitter") then
                                firetouchinterest(root, obj, 0)
                                firetouchinterest(root, obj, 1)
                            else
                                root.CFrame = obj.CFrame
                            end
                        end
                    end
                end
            end

            -- AUTO COLLECT COIN & MONEY
            if autoCollectActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local nameLower = string.lower(obj.Name)
                        if nameLower:find("coin") or nameLower:find("gem") or nameLower:find("cash") or nameLower:find("money") or nameLower:find("star") or nameLower:find("drop") then
                            if (root.Position - obj.Position).Magnitude <= 120 then
                                if firetouchinterest and obj:FindFirstChildOfClass("TouchTransmitter") then
                                    firetouchinterest(root, obj, 0)
                                    firetouchinterest(root, obj, 1)
                                else
                                    obj.CFrame = root.CFrame
                                end
                            end
                        end
                    end
                end
            end

            -- SPEED BOOST
            if speedBoostActive then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = customWalkSpeed end
            else
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 10000000 end
            end
        end
    end
end)
