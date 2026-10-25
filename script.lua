-- =========================================================
-- QEEEWWIE HUB: MULTI-SELECT & MINIMIZE (SENJU KAWARAGI)
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local instantGrabActive = false
local autoCollectActive = false
local speedBoostActive = false
local customWalkSpeed = 50

-- Daftar raritinya beserta status aktif (true/false)
local rarityFilters = {
    {name = "ALL", active = true},
    {name = "Solaris Egg", active = false},
    {name = "Cherub Egg", active = false},
    {name = "Seraph Egg", active = false},
    {name = "Divine", active = false},
    {name = "Ethereal", active = false},
    {name = "Blackhole Egg", active = false}
}
local currentFilterIdx = 1

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

-- 1. Main Frame (Menu Utama)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.03, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Senju Kawaragi Edition [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.09, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1

-- 2. Tombol Minimize (-) di Pojok Kanan Atas MainFrame
local MinimizeBtn = Instance.new("TextButton", MainFrame)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 100)
MinimizeBtn.Position = UDim2.new(0.80, 0, 0.03, 0)
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(1, 0) -- Bentuk bulat

-- 3. Floating Icon (Logo Senju Kawaragi saat Minimized)
local FloatingIcon = Instance.new("ImageButton", ScreenGui)
FloatingIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
FloatingIcon.Position = UDim2.new(0.05, 0, 0.15, 0)
FloatingIcon.Size = UDim2.new(0, 50, 0, 50)
FloatingIcon.Visible = false
FloatingIcon.Active = true
FloatingIcon.Draggable = true
FloatingIcon.Image = "rbxassetid://10670351745" -- Asset ID gambar anime / Senju Kawaragi (bisa diganti ID decal lain jika mau)
Instance.new("UICorner", FloatingIcon).CornerRadius = UDim.new(1, 0) -- Bulat estetik

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.16, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "EGG & FILTER"
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
PageFarm.Position = UDim2.new(0.05, 0, 0.25, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.72, 0)

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.25, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.72, 0)
PagePlayer.Visible = false

local InstantGrabBtn = Instance.new("TextButton", PageFarm)
InstantGrabBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
InstantGrabBtn.Position = UDim2.new(0, 0, 0.02, 0)
InstantGrabBtn.Size = UDim2.new(1, 0, 0, 30)
InstantGrabBtn.Font = Enum.Font.SourceSansBold
InstantGrabBtn.Text = "INSTANT GRAB EGG: OFF"
InstantGrabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantGrabBtn.TextSize = 11
Instance.new("UICorner", InstantGrabBtn).CornerRadius = UDim.new(0, 6)

local ToggleFilterBtn = Instance.new("TextButton", PageFarm)
ToggleFilterBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
ToggleFilterBtn.Position = UDim2.new(0, 0, 0.32, 0)
ToggleFilterBtn.Size = UDim2.new(0.68, 0, 0, 28)
ToggleFilterBtn.Font = Enum.Font.SourceSansBold
ToggleFilterBtn.Text = "SELECT: ALL"
ToggleFilterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFilterBtn.TextSize = 10
Instance.new("UICorner", ToggleFilterBtn).CornerRadius = UDim.new(0, 6)

local SwitchStatusBtn = Instance.new("TextButton", PageFarm)
SwitchStatusBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SwitchStatusBtn.Position = UDim2.new(0.71, 0, 0.32, 0)
SwitchStatusBtn.Size = UDim2.new(0.29, 0, 0, 28)
SwitchStatusBtn.Font = Enum.Font.SourceSansBold
SwitchStatusBtn.Text = "OFF [X]"
SwitchStatusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SwitchStatusBtn.TextSize = 10
Instance.new("UICorner", SwitchStatusBtn).CornerRadius = UDim.new(0, 6)

local ActiveInfoLabel = Instance.new("TextLabel", PageFarm)
ActiveInfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ActiveInfoLabel.Position = UDim2.new(0, 0, 0.46, 0)
ActiveInfoLabel.Size = UDim2.new(1, 0, 0, 38)
ActiveInfoLabel.Font = Enum.Font.SourceSans
ActiveInfoLabel.Text = "Active: ALL"
ActiveInfoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
ActiveInfoLabel.TextSize = 10
ActiveInfoLabel.TextWrapped = true
Instance.new("UICorner", ActiveInfoLabel).CornerRadius = UDim.new(0, 6)

local CollectBtn = Instance.new("TextButton", PageFarm)
CollectBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CollectBtn.Position = UDim2.new(0, 0, 0.78, 0)
CollectBtn.Size = UDim2.new(1, 0, 0, 30)
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

-- 4. Fungsi Minimize & Restore GUI
MinimizeBtn.Activated:Connect(function()
    MainFrame.Visible = false
    FloatingIcon.Position = MainFrame.Position -- Samakan posisi saat diminimize
    FloatingIcon.Visible = true
end)

FloatingIcon.Activated:Connect(function()
    MainFrame.Position = FloatingIcon.Position -- Kembalikan posisi
    MainFrame.Visible = true
    FloatingIcon.Visible = false
end)

local function updateFilterUI()
    local current = rarityFilters[currentFilterIdx]
    ToggleFilterBtn.Text = "SEL: " .. current.name
    if current.active then
        SwitchStatusBtn.Text = "ON [✓]"
        SwitchStatusBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        SwitchStatusBtn.Text = "OFF [X]"
        SwitchStatusBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end

    local activeNames = {}
    for _, item in ipairs(rarityFilters) do
        if item.active then
            table.insert(activeNames, item.name)
        end
    end
    ActiveInfoLabel.Text = "Active Filters: " .. table.concat(activeNames, ", ")
end

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

ToggleFilterBtn.Activated:Connect(function()
    currentFilterIdx = currentFilterIdx + 1
    if currentFilterIdx > #rarityFilters then
        currentFilterIdx = 1
    end
    updateFilterUI()
end)

SwitchStatusBtn.Activated:Connect(function()
    local current = rarityFilters[currentFilterIdx]
    if current.name == "ALL" then
        current.active = not current.active
    else
        current.active = not current.active
        if current.active then
            rarityFilters[1].active = false
        end
    end
    updateFilterUI()
end)

InstantGrabBtn.Activated:Connect(function()
    instantGrabActive = not instantGrabActive
    InstantGrabBtn.Text = instantGrabActive and "INSTANT GRAB EGG: ON" or "INSTANT GRAB EGG: OFF"
    InstantGrabBtn.BackgroundColor3 = instantGrabActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 100, 50)
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

-- Engine Instant Grab dengan Multi-Select Filter
task.spawn(function()
    while true do
        task.wait(0.5)
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        if instantGrabActive then
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if not instantGrabActive then break end
                
                if prompt:IsA("ProximityPrompt") then
                    local parentPart = prompt.Parent
                    local grandParent = parentPart and parentPart.Parent
                    
                    if parentPart then
                        local partName = string.lower(parentPart.Name)
                        local parentName = grandParent and string.lower(grandParent.Name) or ""
                        local fullStr = partName .. " " .. parentName
                        
                        local isEggPrompt = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
                        local isShop = fullStr:find("shop") or fullStr:find("toko")
                        
                        if isEggPrompt and not isShop then
                            local shouldGrab = false
                            
                            if rarityFilters[1].active then
                                shouldGrab = true
                            else
                                for i = 2, #rarityFilters do
                                    local filt = rarityFilters[i]
                                    if filt.active then
                                        local keywordMain = string.lower(filt.name):gsub(" egg", "")
                                        if fullStr:find(string.lower(filt.name)) or fullStr:find(keywordMain) then
                                            shouldGrab = true
                                            break
                                        end
                                    end
                                end
                            end

                            if shouldGrab then
                                prompt.HoldDuration = 0
                                if fireproximityprompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
            end
        end

        if autoCollectActive and root then
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

        if speedBoostActive and char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = customWalkSpeed end
        elseif char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed == customWalkSpeed then humanoid.WalkSpeed = 16 end
        end
    end
end)

updateFilterUI()
