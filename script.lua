-- =========================================================
-- QEEEWWIE HUB: CLEAN TABBED EDITION [FOREST & STEAL]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihkan UI lama jika ada
if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

-- [1] VARIABEL PENGATURAN FITUR
local forestInstantStealActive = false
local speedBoostActive = false
local customWalkSpeed = 65
local maxInteractDistance = 45

-- [2] PEMBUATAN TAMPILAN UTAMA (UI)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- [3] HEADER & JUDUL MENU
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.Position = UDim2.new(0.08, 0, 0.03, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Forest & Steal Edition [🔥]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.09, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.80, 0, 0.03, 0)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- [4] NAVIGASI TAB MENU
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.17, 0)
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

-- [5] HALAMAN KONTEN (PAGES)
local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.27, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.68, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.27, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.68, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

-- Tombol Halaman Farm Hutan
local ForestStealBtn = Instance.new("TextButton", PageFarm)
ForestStealBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 100)
ForestStealBtn.Position = UDim2.new(0, 0, 0.05, 0)
ForestStealBtn.Size = UDim2.new(1, 0, 0, 38)
ForestStealBtn.Font = Enum.Font.SourceSansBold
ForestStealBtn.Text = "FOREST INSTANT STEAL: OFF"
ForestStealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ForestStealBtn.TextSize = 11
ForestStealBtn.ZIndex = 12
Instance.new("UICorner", ForestStealBtn).CornerRadius = UDim.new(0, 6)

local InfoLabel = Instance.new("TextLabel", PageFarm)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
InfoLabel.Position = UDim2.new(0, 0, 0.35, 0)
InfoLabel.Size = UDim2.new(1, 0, 0, 55)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Text = "Status: Aman dari Robux.\nFokus Instant Grab & Steal khusus Hutan / Map Umum."
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
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 11
SpeedBtn.ZIndex = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

-- [6] FONT & TOMBOL INTERAKSI UI
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
    ForestStealBtn.Text = forestInstantStealActive and "FOREST INSTANT STEAL: ON" or "FOREST INSTANT STEAL: OFF"
    ForestStealBtn.BackgroundColor3 = forestInstantStealActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(180, 40, 100)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SPEED BOOST: ON" or "SPEED BOOST: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- [7] MESIN UTAMA (ENGINE LOOP)
task.spawn(function()
    while true do
        task.wait(0.12)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        -- Fitur Forest Instant Steal & Grab
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

        -- Fitur Speed Boost
        if speedBoostActive and char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = customWalkSpeed end
        elseif char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 16 end
        end
    end
end)
