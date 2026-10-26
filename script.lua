-- =========================================================
-- QEEEWWIE HUB: ULTIMATE SUPREME POWER [SC MAX EDITION]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

-- Variabel Supreme Power
local forestInstantStealActive = false
local speedBoostActive = false
local customWalkSpeed = 95 -- Kecepatan Super Kilat!
local maxInteractDistance = 70 -- Jangkauan Super Luas!

-- Pembuatan UI Utama (Lapisan Tertinggi)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

-- =========================================================
-- [SUPREME] FLOATING ICON SC (MENYALA & ELEGAN)
-- =========================================================
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

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 100, 185)
MainStroke.Thickness = 2

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
SubTitle.Text = "Ultimate Supreme [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.07, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

-- Tombol Minimize (-)
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

-- Tombol Close (X)
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
TabContainer.Position = UDim2.new(0.05, 0, 0.13, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)
TabContainer.ZIndex = 11

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "FOREST FARM"
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

-- Halaman Konten (Pages)
local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.21, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.76, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.21, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.76, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

-- Tombol Auto Instant Steal Supreme
local ForestStealBtn = Instance.new("TextButton", PageFarm)
ForestStealBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 100)
ForestStealBtn.Position = UDim2.new(0, 0, 0.02, 0)
ForestStealBtn.Size = UDim2.new(1, 0, 0, 36)
ForestStealBtn.Font = Enum.Font.SourceSansBold
ForestStealBtn.Text = "AUTO INSTANT STEAL: OFF"
ForestStealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ForestStealBtn.TextSize = 11
ForestStealBtn.ZIndex = 12
Instance.new("UICorner", ForestStealBtn).CornerRadius = UDim.new(0, 6)

-- Tombol TP to Nearest Egg Supreme
local TpToEggBtn = Instance.new("TextButton", PageFarm)
TpToEggBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
TpToEggBtn.Position = UDim2.new(0, 0, 0.28, 0)
TpToEggBtn.Size = UDim2.new(1, 0, 0, 36)
TpToEggBtn.Font = Enum.Font.SourceSansBold
TpToEggBtn.Text = "TP TO NEAREST EGG [SUPREME]"
TpToEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpToEggBtn.TextSize = 11
TpToEggBtn.ZIndex = 12
Instance.new("UICorner", TpToEggBtn).CornerRadius = UDim.new(0, 6)

local InfoLabel = Instance.new("TextLabel", PageFarm)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
InfoLabel.Position = UDim2.new(0, 0, 0.54, 0)
InfoLabel.Size = UDim2.new(1, 0, 0, 52)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Text = "Status: Supreme Power Active (0.03s Loop).\nAnti-Robux Lock + Logo SC Supreme Ready."
InfoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
InfoLabel.TextSize = 10
InfoLabel.TextWrapped = true
InfoLabel.ZIndex = 12
Instance.new("UICorner", InfoLabel).CornerRadius = UDim.new(0, 6)

-- Tombol Halaman Player
local SpeedBtn = Instance.new("TextButton", PagePlayer)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0, 0, 0.02, 0)
SpeedBtn.Size = UDim2.new(1, 0, 0, 38)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SUPREME SPEED: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 11
SpeedBtn.ZIndex = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- Fungsi Minimize & Floating Logo SC
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

ForestStealBtn.MouseButton1Click:Connect(function()
    forestInstantStealActive = not forestInstantStealActive
    ForestStealBtn.Text = forestInstantStealActive and "AUTO INSTANT STEAL: ON" or "AUTO INSTANT STEAL: OFF"
    ForestStealBtn.BackgroundColor3 = forestInstantStealActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(180, 40, 100)
end)

-- TP To Egg Supreme Power
TpToEggBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local closestEgg = nil
        local shortestDist = math.huge
        
        for _, prompt in pairs(Workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                local parentPart = prompt.Parent
                local grandParent = parentPart and parentPart.Parent
                
                if parentPart and parentPart:IsA("BasePart") then
                    local dist = (root.Position - parentPart.Position).Magnitude
                    if dist <= maxInteractDistance then
                        local partName = string.lower(parentPart.Name)
                        local parentName = grandParent and string.lower(grandParent.Name) or ""
                        local fullStr = partName .. " " .. parentName
                        local promptText = string.lower((prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
                        
                        local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
                        local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase") or promptText:find("lewat") or promptText:find("skip") or fullStr:find("shop") or fullStr:find("toko")
                        
                        if isEgg and not isRestricted then
                            if dist < shortestDist then
                                shortestDist = dist
                                closestEgg = parentPart
                            end
                        end
                    end
                end
            end
        end
        
        if closestEgg then
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.CFrame = closestEgg.CFrame + Vector3.new(0, 3.5, 0)
        end
    end)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SUPREME SPEED: ON" or "SUPREME SPEED: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- =========================================================
-- MESIN UTAMA SUPREME (LOOP 0.03s: ULTRA INSTANT STEAL)
-- =========================================================
task.spawn(function()
    while true do
        task.wait(0.03) -- Kecepatan super kilat dewa!
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if forestInstantStealActive and root then
            pcall(function()
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not forestInstantStealActive then break end
                    
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        local grandParent = parentPart and parentPart.Parent
                        
                        if parentPart and parentPart:IsA("BasePart") and (root.Position - parentPart.Position).Magnitude <= maxInteractDistance then
                            local partName = string.lower(parentPart.Name)
                            local parentName = grandParent and string.lower(grandParent.Name) or ""
                            local fullStr = partName .. " " .. parentName
                            local promptText = string.lower((prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
                            
                            local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
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
            end)
        end

        if speedBoostActive and char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = customWalkSpeed end
        elseif char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 16 end
        end
    end
end)
