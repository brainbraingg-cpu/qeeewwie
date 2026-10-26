-- =========================================================
-- QEEEWWIE HUB: FLY-OVER DELIVERY & FUSION SAFE [SC]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

local autoTpFarmActive = false
local speedBoostActive = false
local autoRideEnabled = true
local prioritizeRare = true
local customWalkSpeed = 95
local basePosition = nil
local collectedEggsMemory = {}

-- =========================================================
-- PEMBUATAN UI UTAMA
-- =========================================================
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

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
MainFrame.Size = UDim2.new(0, 260, 0, 480)
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
SubTitle.Text = "Fly-Over Fusion Delivery [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.06, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

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

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.11, 0)
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

local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.17, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.8, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.17, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.8, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

local AutoFarmBtn = Instance.new("TextButton", PageFarm)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 100)
AutoFarmBtn.Position = UDim2.new(0, 0, 0.02, 0)
AutoFarmBtn.Size = UDim2.new(1, 0, 0, 36)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.Text = "FLY-OVER FARM: OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 11
AutoFarmBtn.ZIndex = 12
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0, 6)

local RideToggleBtn = Instance.new("TextButton", PageFarm)
RideToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 100)
RideToggleBtn.Position = UDim2.new(0, 0, 0.23, 0)
RideToggleBtn.Size = UDim2.new(1, 0, 0, 32)
RideToggleBtn.Font = Enum.Font.SourceSansBold
RideToggleBtn.Text = "AUTO RIDE PET: ON"
RideToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RideToggleBtn.TextSize = 10
RideToggleBtn.ZIndex = 12
Instance.new("UICorner", RideToggleBtn).CornerRadius = UDim.new(0, 6)

local PriorityBtn = Instance.new("TextButton", PageFarm)
PriorityBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
PriorityBtn.Position = UDim2.new(0, 0, 0.42, 0)
PriorityBtn.Size = UDim2.new(1, 0, 0, 32)
PriorityBtn.Font = Enum.Font.SourceSansBold
PriorityBtn.Text = "TARGET: PRIORITAS EGG LANGKA / JAUH"
PriorityBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PriorityBtn.TextSize = 9
PriorityBtn.ZIndex = 12
Instance.new("UICorner", PriorityBtn).CornerRadius = UDim.new(0, 6)

local InfoLabel = Instance.new("TextLabel", PageFarm)
InfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
InfoLabel.Position = UDim2.new(0, 0, 0.62, 0)
InfoLabel.Size = UDim2.new(1, 0, 0, 65)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Text = "Status: TP ke Telur -> Steal -> Terbang ke Atas Fusion -> Melayang ke Base -> Landing."
InfoLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
InfoLabel.TextSize = 10
InfoLabel.TextWrapped = true
InfoLabel.ZIndex = 12
Instance.new("UICorner", InfoLabel).CornerRadius = UDim.new(0, 6)

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
-- KONEKSI UI
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
    AutoFarmBtn.Text = autoTpFarmActive and "FLY-OVER FARM: ON" or "FLY-OVER FARM: OFF"
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

RideToggleBtn.MouseButton1Click:Connect(function()
    autoRideEnabled = not autoRideEnabled
    if autoRideEnabled then
        RideToggleBtn.Text = "AUTO RIDE PET: ON"
        RideToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 100)
    else
        RideToggleBtn.Text = "AUTO RIDE PET: OFF"
        RideToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    end
end)

PriorityBtn.MouseButton1Click:Connect(function()
    prioritizeRare = not prioritizeRare
    if prioritizeRare then
        PriorityBtn.Text = "TARGET: PRIORITAS EGG LANGKA / JAUH"
        PriorityBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
    else
        PriorityBtn.Text = "TARGET: RANDOM ALL EGGS"
        PriorityBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoostActive = not speedBoostActive
    SpeedBtn.Text = speedBoostActive and "SUPREME SPEED: ON" or "SUPREME SPEED: OFF"
    SpeedBtn.BackgroundColor3 = speedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

-- =========================================================
-- FUNGSI SAFE AUTO-RIDE
-- =========================================================
local function safeAutoRide()
    if not autoRideEnabled then return end
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        
        if humanoid and humanoid.SeatPart then
            return
        end

        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local parent = obj.Parent
                if parent then
                    local nameStr = string.lower(parent.Name .. " " .. (obj.ActionText or "") .. " " .. (obj.ObjectText or ""))
                    if nameStr:find("ride") or nameStr:find("naik") or nameStr:find("mount") then
                        obj.HoldDuration = 0
                        if fireproximityprompt then
                            fireproximityprompt(obj)
                            task.wait(0.1)
                            break
                        end
                    end
                end
            end
        end
    end)
end

-- =========================================================
-- VALIDASI EGG
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
    
    if fullStr:find("jalur") or fullStr:find("toko") or fullStr:find("shop") or fullStr:find("display") or fullStr:find("npc") or fullStr:find("bicara") or fullStr:find("talk") or fullStr:find("board") then
        return false
    end
    
    if fullStr:find("base") or fullStr:find("plot") or fullStr:find("claim") or fullStr:find("tycoon") or fullStr:find("pedestal") or fullStr:find("stand") or fullStr:find("placed") or fullStr:find("mybase") then
        return false
    end
    
    local isEgg = fullStr:find("egg") or fullStr:find("telur") or fullStr:find("hatch") or fullStr:find("halloween") or fullStr:find("event") or fullStr:find("forest")
    local isRestricted = fullStr:find("robux") or fullStr:find("buy") or fullStr:find("purchase") or fullStr:find("pass")
    
    if not (isEgg and not isRestricted) then
        return false
    end
    
    local isRare = fullStr:find("divine") or fullStr:find("cherub") or fullStr:find("ethereal") or fullStr:find("solaris") or fullStr:find("seraph") or fullStr:find("blackhole") or fullStr:find("mythic") or fullStr:find("legendary") or fullStr:find("halloween") or fullStr:find("lubang hitam")
    
    return true, isRare
end

-- =========================================================
-- MESIN UTAMA: TP -> STEAL -> TERBANG KE ATAS FUSION -> BASE -> LANDING
-- =========================================================
task.spawn(function()
    while true do
        task.wait(0.4)
        if autoTpFarmActive then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                
                if not basePosition then
                    basePosition = root.CFrame
                end
                
                -- 1. Pastikan naik pet
                safeAutoRide()
                
                local availableEggs = {}
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not autoTpFarmActive then break end
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        if parentPart and parentPart:IsA("BasePart") then
                            local valid, isRare = isValidEgg(prompt, parentPart)
                            if valid then
                                table.insert(availableEggs, {prompt = prompt, part = parentPart, isRare = isRare})
                            end
                        end
                    end
                end
                
                if #availableEggs > 0 then
                    table.sort(availableEggs, function(a, b)
                        if prioritizeRare then
                            if a.isRare and not b.isRare then
                                return true
                            elseif not a.isRare and b.isRare then
                                return false
                            end
                        end
                        return (root.Position - a.part.Position).Magnitude > (root.Position - b.part.Position).Magnitude
                    end)
                    
                    local target = availableEggs[1]
                    if target and autoTpFarmActive then
                        collectedEggsMemory[target.prompt] = true
                        
                        -- 2. Teleport ke Telur Target di Hutan
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        root.CFrame = target.part.CFrame + Vector3.new(0, 3.5, 0)
                        
                        task.wait(0.2)
                        
                        -- 3. Instant Steal Telur
                        target.prompt.HoldDuration = 0
                        if fireproximityprompt then
                            fireproximityprompt(target.prompt)
                        end
                        
                        task.wait(0.4) -- Jeda sukses klaim server
                        
                        -- 4. METODE BARU: TP ke Atas (Area Fusion) -> Terbang Melayang ke Base -> Landing
                        local fusionHeightOffset = Vector3.new(0, 80, 0) -- Ketinggian area atas/fusion
                        local targetPos = basePosition.Position
                        
                        -- Pindah ke atas (area fusion) secara instan membawa telur
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        root.CFrame = CFrame.new(targetPos + fusionHeightOffset)
                        
                        task.wait(0.3)
                        
                        -- Terbang melayang perlahan menuju tepat di atas base
                        local steps = 15
                        local startPos = root.Position
                        local endPos = targetPos + Vector3.new(0, 45, 0) -- Melayang di atas base
                        
                        for i = 1, steps do
                            if not autoTpFarmActive then break end
                            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            root.CFrame = CFrame.new(startPos:Lerp(endPos, i / steps))
                            task.wait(0.04)
                        end
                        
                        -- 5. Jatuh / Landing mulus ke dalam Base
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        root.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                        
                        task.wait(0.4)
                    end
                else
                    table.clear(collectedEggsMemory)
                    task.wait(1)
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
