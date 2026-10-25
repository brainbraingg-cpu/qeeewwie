-- =========================================================
-- QEEEWWIE HUB: GACOR EDITION [⚡ MAX PERFORMANCE]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

local instantGrabActive = false
local autoCollectActive = false
local speedBoostActive = false
local espEggActive = false
local customWalkSpeed = 65 -- Ditingkatkan biar makin ngebut!

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

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- Main Frame (Menu Utama)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.Position = UDim2.new(0.08, 0, 0.02, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Gacor Max Edition [🔥]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.08, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.80, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.14, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)
TabContainer.ZIndex = 11

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "EGG & FILTER"
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

local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.23, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.74, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.23, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.74, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

local InstantGrabBtn = Instance.new("TextButton", PageFarm)
InstantGrabBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
InstantGrabBtn.Position = UDim2.new(0, 0, 0.01, 0)
InstantGrabBtn.Size = UDim2.new(1, 0, 0, 30)
InstantGrabBtn.Font = Enum.Font.SourceSansBold
InstantGrabBtn.Text = "INSTANT GRAB EGG: OFF"
InstantGrabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantGrabBtn.TextSize = 11
InstantGrabBtn.ZIndex = 12
Instance.new("UICorner", InstantGrabBtn).CornerRadius = UDim.new(0, 6)

local EspEggBtn = Instance.new("TextButton", PageFarm)
EspEggBtn.BackgroundColor3 = Color3.fromRGB(120, 50, 180)
EspEggBtn.Position = UDim2.new(0, 0, 0.23, 0)
EspEggBtn.Size = UDim2.new(1, 0, 0, 28)
EspEggBtn.Font = Enum.Font.SourceSansBold
EspEggBtn.Text = "ESP EGG HIGHLIGHT: OFF"
EspEggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspEggBtn.TextSize = 11
EspEggBtn.ZIndex = 12
Instance.new("UICorner", EspEggBtn).CornerRadius = UDim.new(0, 6)

local ToggleFilterBtn = Instance.new("TextButton", PageFarm)
ToggleFilterBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 120)
ToggleFilterBtn.Position = UDim2.new(0, 0, 0.44, 0)
ToggleFilterBtn.Size = UDim2.new(0.68, 0, 0, 28)
ToggleFilterBtn.Font = Enum.Font.SourceSansBold
ToggleFilterBtn.Text = "SELECT: ALL"
ToggleFilterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFilterBtn.TextSize = 10
ToggleFilterBtn.ZIndex = 12
Instance.new("UICorner", ToggleFilterBtn).CornerRadius = UDim.new(0, 6)

local SwitchStatusBtn = Instance.new("TextButton", PageFarm)
SwitchStatusBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SwitchStatusBtn.Position = UDim2.new(0.71, 0, 0.44, 0)
SwitchStatusBtn.Size = UDim2.new(0.29, 0, 0, 28)
SwitchStatusBtn.Font = Enum.Font.SourceSansBold
SwitchStatusBtn.Text = "OFF [X]"
SwitchStatusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SwitchStatusBtn.TextSize = 10
SwitchStatusBtn.ZIndex = 12
Instance.new("UICorner", SwitchStatusBtn).CornerRadius = UDim.new(0, 6)

local ActiveInfoLabel = Instance.new("TextLabel", PageFarm)
ActiveInfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ActiveInfoLabel.Position = UDim2.new(0, 0, 0.56, 0)
ActiveInfoLabel.Size = UDim2.new(1, 0, 0, 34)
ActiveInfoLabel.Font = Enum.Font.SourceSans
ActiveInfoLabel.Text = "Active: ALL"
ActiveInfoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
ActiveInfoLabel.TextSize = 10
ActiveInfoLabel.TextWrapped = true
ActiveInfoLabel.ZIndex = 12
Instance.new("UICorner", ActiveInfoLabel).CornerRadius = UDim.new(0, 6)

local CollectBtn = Instance.new("TextButton", PageFarm)
CollectBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CollectBtn.Position = UDim2.new(0, 0, 0.82, 0)
CollectBtn.Size = UDim2.new(1, 0, 0, 30)
CollectBtn.Font = Enum.Font.SourceSansBold
CollectBtn.Text = "AUTO COLLECT: OFF"
CollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectBtn.TextSize = 11
CollectBtn.ZIndex = 12
Instance.new("UICorner", CollectBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", PagePlayer)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0, 0, 0.02, 0)
SpeedBtn.Size = UDim2.new(1, 0, 0, 38)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 12
SpeedBtn.ZIndex = 12
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

local function clearESP()
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:FindFirstChild("QeeewwieESP") then
            item.QeeewwieESP:Destroy()
        end
        if item:FindFirstChild("QeeewwieTag") then
            item.QeeewwieTag:Destroy()
        end
    end
end

CloseBtn.MouseButton1Click:Connect(function()
    clearESP()
    ScreenGui:Destroy()
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
    ActiveInfoLabel.Text = "Active: " .. table.concat(activeNames, ", ")
end

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

ToggleFilterBtn.MouseButton1Click:Connect(function()
    currentFilterIdx = currentFilterIdx + 1
    if currentFilterIdx > #rarityFilters then
        currentFilterIdx = 1
    end
    updateFilterUI()
end)

SwitchStatusBtn.MouseButton1Click:Connect(function()
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

InstantGrabBtn.MouseButton1Click:Connect(function()
    instantGrabActive = not instantGrabActive
    InstantGrabBtn.Text = instantGrabActive and "INSTANT GRAB EGG: ON" or "INSTANT GRAB EGG: OFF"
    InstantGrabBtn.BackgroundColor3 = instantGrabActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 100, 50)
end)

EspEggBtn.MouseButton1Click:Connect(function()
    espEggActive = not espEggActive
    EspEggBtn.Text = espEggActive and "ESP EGG HIGHLIGHT: ON" or "ESP EGG HIGHLIGHT: OFF"
    EspEggBtn.BackgroundColor3 = espEggActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(120, 50, 180)
    if not espEggActive then
        clearESP()
    end
end)

CollectBtn.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    CollectBtn.Text = autoCollectActive and "AUTO COLLECT: ON" or "AUTO COLLECT: OFF"
    CollectBtn.BackgroundColor3 = autoCollectActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SPEED BOOST: ON" or "SPEED BOOST: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- Main Engine Gacor (Super Cepat & Anti-Nyangkut)
task.spawn(function()
    while true do
        task.wait(0.2) -- Loop dipercepat biar makin responsif
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        -- 1. ESP EGG HIGHLIGHT & TAG
        if espEggActive then
            pcall(function()
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not espEggActive then break end
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        local grandParent = parentPart and parentPart.Parent
                        
                        if parentPart then
                            local partName = string.lower(parentPart.Name)
                            local parentName = grandParent and string.lower(grandParent.Name) or ""
                            local fullStr = partName .. " " .. parentName
                            local promptText = string.lower(prompt.ActionText .. " " .. prompt.ObjectText)

                            local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
                            local isRestricted = promptText:find("robux") or promptText:find("buy") or fullStr:find("shop") or fullStr:find("toko")

                            if isEgg and not isRestricted then
                                local targetObj = parentPart:IsA("Model") and parentPart or (grandParent:IsA("Model") and grandParent or parentPart)
                                
                                if not targetObj:FindFirstChild("QeeewwieESP") then
                                    local hl = Instance.new("Highlight")
                                    hl.Name = "QeeewwieESP"
                                    hl.Adornee = targetObj
                                    hl.FillTransparency = 0.3
                                    hl.OutlineTransparency = 0
                                    
                                    if fullStr:find("blackhole") then
                                        hl.FillColor = Color3.fromRGB(150, 0, 255)
                                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    elseif fullStr:find("solaris") then
                                        hl.FillColor = Color3.fromRGB(255, 215, 0)
                                    elseif fullStr:find("divine") then
                                        hl.FillColor = Color3.fromRGB(0, 191, 255)
                                    else
                                        hl.FillColor = Color3.fromRGB(255, 105, 180)
                                    end
                                    hl.Parent = targetObj
                                end

                                if not targetObj:FindFirstChild("QeeewwieTag") then
                                    local bg = Instance.new("BillboardGui")
                                    bg.Name = "QeeewwieTag"
                                    bg.Adornee = targetObj
                                    bg.Size = UDim2.new(0, 120, 0, 35)
                                    bg.StudsOffset = Vector3.new(0, 3.5, 0)
                                    bg.AlwaysOnTop = true

                                    local lbl = Instance.new("TextLabel", bg)
                                    lbl.Size = UDim2.new(1, 0, 1, 0)
                                    lbl.BackgroundTransparency = 1
                                    lbl.Font = Enum.Font.SourceSansBold
                                    lbl.TextSize = 13
                                    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    lbl.TextStrokeTransparency = 0
                                    lbl.Text = targetObj.Name
                                    bg.Parent = targetObj
                                end
                            end
                        end
                    end
                end
            end)
        end

        -- 2. INSTANT GRAB EGG (Gacor Anti-Menu Robux)
        if instantGrabActive then
            pcall(function()
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not instantGrabActive then break end
                    
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        local grandParent = parentPart and parentPart.Parent
                        
                        if parentPart then
                            local partName = string.lower(parentPart.Name)
                            local parentName = grandParent and string.lower(grandParent.Name) or ""
                            local fullStr = partName .. " " .. parentName
                            local promptText = string.lower(prompt.ActionText .. " " .. prompt.ObjectText)
                            
                            local isEggPrompt = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("cherub") or fullStr:find("divine") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole")
                            local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase") or promptText:find("lewat") or promptText:find("skip") or fullStr:find("shop") or fullStr:find("toko")
                            
                            if isEggPrompt and not isRestricted then
                                local shouldGrab = false
                                
                                if rarityFilters[1].active then
                                    shouldGrab = true
                                else
                                    for i = 2, #rarityFilters do
                                        local filt = rarityFilters[i]
                                        if filt.active then
                                            local targetKey = string.lower(filt.name)
                                            local keywordMain = targetKey:gsub(" egg", "")
                                            
                                            if fullStr:find(targetKey) or fullStr:find(keywordMain) or promptText:find(targetKey) then
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
            end)
        end

        -- 3. AUTO COLLECT (Jangkauan Diperluas jadi 150 Studs!)
        if autoCollectActive and root then
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local nameLower = string.lower(obj.Name)
                        if nameLower:find("coin") or nameLower:find("gem") or nameLower:find("cash") or nameLower:find("money") then
                            if (root.Position - obj.Position).Magnitude <= 150 then
                                if firetouchinterest then
                                    firetouchinterest(root, obj, 0)
                                    firetouchinterest(root, obj, 1)
                                end
                            end
                        end
                    end
                end
            end)
        end

        -- 4. SPEED BOOST GACOR
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
