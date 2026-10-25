-- =========================================================
-- QEEEWWIE HUB: FULL ULTIMATE EDITION (SENJU THEME)
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
local customWalkSpeed = 50

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
SubTitle.Text = "Ride a Pet Edition [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.13, 0)
SubTitle.Size = UDim2.new(0.85, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1

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

EggFarmBtn.Activated:Connect(function()
    autoEggFarmActive = not autoEggFarmActive
    if autoEggFarmActive then
        EggFarmBtn.Text = "AUTO FARM EGG: ON"
        EggFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        EggFarmBtn.Text = "AUTO FARM EGG: OFF"
        EggFarmBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
    end
end)

HalloweenBtn.Activated:Connect(function()
    autoHalloweenActive = not autoHalloweenActive
    if autoHalloweenActive then
        HalloweenBtn.Text = "AUTO HALLOWEEN: ON"
        HalloweenBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        HalloweenBtn.Text = "AUTO HALLOWEEN: OFF"
        HalloweenBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
    end
end)

CollectBtn.Activated:Connect(function()
    autoCollectActive = not autoCollectActive
    if autoCollectActive then
        CollectBtn.Text = "AUTO COLLECT: ON"
        CollectBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        CollectBtn.Text = "AUTO COLLECT: OFF"
        CollectBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

SpeedBtn.Activated:Connect(function()
    speedBoostActive = not speedBoostActive
    if speedBoostActive then
        SpeedBtn.Text = "SPEED BOOST: ON"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        SpeedBtn.Text = "SPEED BOOST: OFF"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        
        if autoEggFarmActive then
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local parentPart = prompt.Parent
                    local partPos = parentPart and (parentPart:IsA("BasePart") and parentPart.Position or (parentPart:IsA("Model") and parentPart.PrimaryPart and parentPart.PrimaryPart.Position))
                    if root and partPos and (root.Position - partPos).Magnitude <= 70 then
                        local object = string.lower(prompt.ObjectText or "")
                        local parentName = string.lower(parentPart and parentPart.Name or "")
                        if object:find("egg") or object:find("telur") or parentName:find("egg") or parentName:find("telur") then
                            prompt.HoldDuration = 0
                            if fireproximityprompt then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end
            end
        end
        
        if autoHalloweenActive then
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local parentPart = prompt.Parent
                    local partPos = parentPart and (parentPart:IsA("BasePart") and parentPart.Position or (parentPart:IsA("Model") and parentPart.PrimaryPart and parentPart.PrimaryPart.Position))
                    if root and partPos and (root.Position - partPos).Magnitude <= 70 then
                        local object = string.lower(prompt.ObjectText or "")
                        local parentName = string.lower(parentPart and parentPart.Name or "")
                        if object:find("halloween") or object:find("candy") or object:find("pumpkin") or parentName:find("halloween") or parentName:find("candy") then
                            prompt.HoldDuration = 0
                            if fireproximityprompt then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end
            end
        end
        
        if autoCollectActive then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = string.lower(obj.Name)
                    if name:find("coin") or name:find("gem") or name:find("star") or name:find("reward") then
                        if root and (root.Position - obj.Position).Magnitude < 90 then
                            root.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                        end
                    end
                end
            end
        end
        
        if speedBoostActive then
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = customWalkSpeed
            end
        else
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed == customWalkSpeed then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)
