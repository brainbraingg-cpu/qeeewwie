-- ========================================================
-- Qeeewwie Hub v8.3 | Ultimate Audited & Instant-Terminate
-- Game: Steal an Egg (Production Ready & Fully Patched)
-- ========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Bersihkan UI lama jika ada
if CoreGui:FindFirstChild("QeeewwieMasterHub") then CoreGui.QeeewwieMasterHub:Destroy() end
if CoreGui:FindFirstChild("QeeewwieStatusHUD") then CoreGui.QeeewwieStatusHUD:Destroy() end

-- State Tracking Table untuk Toggle OFF Instan
local runningStates = {}

-- Helper untuk menghentikan loop secara instan saat OFF ditekan
local function smartWait(id, duration)
    local elapsed = 0
    while elapsed < duration do
        if not runningStates[id] then return false end
        task.wait(0.1)
        elapsed = elapsed + 0.1
    end
    return runningStates[id]
end

-- ================= UI UTAMA =================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "QeeewwieMasterHub"

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Position = UDim2.new(0, 20, 0, 120)
ToggleBtn.Size = UDim2.new(0, 130, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "👑 Qeeewwie Hub"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.TextSize = 13
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -170)
MainFrame.Size = UDim2.new(0, 380, 0, 360)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Header = Instance.new("Frame", MainFrame)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.Size = UDim2.new(1, 0, 0, 40)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Header)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Qeeewwie Hub | v8.3 Patched"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12

local CloseButton = Instance.new("TextButton", Header)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 8)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 11
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 12, 0, 50)
Container.Size = UDim2.new(1, -24, 1, -60)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Dynamic CanvasSize Auto-Resize (Menyesuaikan jumlah fitur otomatis)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local function createFeatureToggle(id, name, desc, callback)
    local Wrapper = Instance.new("Frame", Container)
    Wrapper.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Wrapper.Size = UDim2.new(1, 0, 0, 50)
    Instance.new("UICorner", Wrapper).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel", Wrapper)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 12, 0, 5)
    Label.Size = UDim2.new(0, 220, 0, 20)
    Label.Font = Enum.Font.GothamBold
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local DescLabel = Instance.new("TextLabel", Wrapper)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 12, 0, 25)
    DescLabel.Size = UDim2.new(0, 220, 0, 18)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    DescLabel.TextSize = 11
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ActionBtn = Instance.new("TextButton", Wrapper)
    ActionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    ActionBtn.Position = UDim2.new(1, -95, 0, 10)
    ActionBtn.Size = UDim2.new(0, 85, 0, 30)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.Text = "OFF"
    ActionBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ActionBtn.TextSize = 12
    Instance.new("UICorner", ActionBtn).CornerRadius = UDim.new(0, 6)

    local state = false
    ActionBtn.MouseButton1Click:Connect(function()
        state = not state
        runningStates[id] = state
        ActionBtn.Text = state and "ON" or "OFF"
        ActionBtn.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 100, 100)
        ActionBtn.BackgroundColor3 = state and Color3.fromRGB(20, 60, 40) or Color3.fromRGB(45, 45, 60)
        callback(state)
    end)
end

-- ================= LIVE HUD TRACKER =================
local StatusGui = Instance.new("ScreenGui", CoreGui)
StatusGui.Name = "QeeewwieStatusHUD"

local HudFrame = Instance.new("Frame", StatusGui)
HudFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
HudFrame.Position = UDim2.new(0.5, -170, 0, 15)
HudFrame.Size = UDim2.new(0, 340, 0, 75)
HudFrame.Visible = false
HudFrame.Active = true
HudFrame.Draggable = true
Instance.new("UICorner", HudFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", HudFrame).Color = Color3.fromRGB(0, 255, 150)

local HudTitle = Instance.new("TextLabel", HudFrame)
HudTitle.BackgroundTransparency = 1
HudTitle.Position = UDim2.new(0, 12, 0, 6)
HudTitle.Size = UDim2.new(1, -24, 0, 20)
HudTitle.Font = Enum.Font.GothamBold
HudTitle.Text = "Steal Egg | Patched HUD Tracker"
HudTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HudTitle.TextSize = 11

local HudInfo = Instance.new("TextLabel", HudFrame)
HudInfo.BackgroundTransparency = 1
HudInfo.Position = UDim2.new(0, 12, 0, 26)
HudInfo.Size = UDim2.new(1, -24, 0, 18)
HudInfo.Font = Enum.Font.GothamBold
HudInfo.Text = "Status: Idle"
HudInfo.TextColor3 = Color3.fromRGB(0, 255, 150)
HudInfo.TextSize = 10

local HudStats = Instance.new("TextLabel", HudFrame)
HudStats.BackgroundTransparency = 1
HudStats.Position = UDim2.new(0, 12, 0, 44)
HudStats.Size = UDim2.new(1, -24, 0, 16)
HudStats.Font = Enum.Font.Gotham
HudStats.Text = "Attempts: 0 | Touches: 0"
HudStats.TextColor3 = Color3.fromRGB(180, 180, 200)
HudStats.TextSize = 10

-- ================= FITUR UTAMA (DENGAN SMART-WAIT INSTANT STOP) =================

-- 1. Auto Steal Instant
createFeatureToggle("AutoSteal", "Auto Steal Instant (HUD)", "Teleport instan aman", function(state)
    HudFrame.Visible = state
    if state then
        task.spawn(function()
            local attempts, touches = 0, 0
            while runningStates["AutoSteal"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    local folder = Workspace:FindFirstChild("Eggs") or Workspace
                    for _, item in ipairs(folder:GetChildren()) do
                        if not runningStates["AutoSteal"] then break end
                        if item.Name:lower():find("egg") then
                            local part = item:IsA("BasePart") and item or (item:IsA("Model") and item.PrimaryPart)
                            if part then
                                attempts = attempts + 1
                                HudInfo.Text = "Target: " .. item.Name
                                root.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                
                                if not smartWait("AutoSteal", 0.8) then break end
                                
                                if firetouchinterest then
                                    firetouchinterest(root, part, 0)
                                    firetouchinterest(root, part, 1)
                                    touches = touches + 1
                                end
                                HudStats.Text = "Attempts: " .. attempts .. " | Touches: " .. touches
                                root.CFrame = initPos
                                
                                if not smartWait("AutoSteal", 0.5) then break end
                            end
                        end
                    end
                end)
                if not smartWait("AutoSteal", 2.5) then break end
            end
        end)
    end
end)

-- 2. Auto Manor Key
createFeatureToggle("ManorKey", "Auto Manor Key", "Ambil kunci manor tervalidasi", function(state)
    if state then
        task.spawn(function()
            while runningStates["ManorKey"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["ManorKey"] then break end
                        if obj.Name == "ManorKey" or obj.Name:lower():find("manorkey") then
                            local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj.PrimaryPart)
                            if part then
                                root.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                if not smartWait("ManorKey", 1.0) then break end
                                if firetouchinterest then firetouchinterest(root, part, 0) firetouchinterest(root, part, 1) end
                                root.CFrame = initPos
                                if not smartWait("ManorKey", 0.5) then break end
                            end
                        end
                    end
                end)
                if not smartWait("ManorKey", 2.0) then break end
            end
        end)
    end
end)

-- 3. Auto Train Boarding
createFeatureToggle("TrainBoard", "Auto Train Boarding", "Naik Phantom Express resmi", function(state)
    if state then
        task.spawn(function()
            while runningStates["TrainBoard"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["TrainBoard"] then break end
                        if obj.Name:lower():find("phantomexpress") then
                            local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj.PrimaryPart)
                            if part then
                                root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                                if not smartWait("TrainBoard", 0.8) then break end
                                if firetouchinterest then firetouchinterest(root, part, 0) firetouchinterest(root, part, 1) end
                            end
                        end
                    end
                end)
                if not smartWait("TrainBoard", 2.0) then break end
            end
        end)
    end
end)

-- 4. Auto Void Fusion
createFeatureToggle("VoidFusion", "Auto Void Fusion", "Fusi item Void dengan remote", function(state)
    if state then
        task.spawn(function()
            while runningStates["VoidFusion"] do
                pcall(function()
                    local rem = ReplicatedStorage:FindFirstChild("VoidFusionEvent", true)
                    if rem and rem:IsA("RemoteEvent") then rem:FireServer() end
                end)
                if not smartWait("VoidFusion", 4.0) then break end
            end
        end)
    end
end)

-- 5. Auto Treadmill
createFeatureToggle("Treadmill", "Auto Treadmill", "Latihan treadmill spesifik", function(state)
    if state then
        task.spawn(function()
            while runningStates["Treadmill"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["Treadmill"] then break end
                        if obj.Name:lower() == "treadmill" and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            if firetouchinterest then firetouchinterest(root, obj, 0) firetouchinterest(root, obj, 1) end
                            break
                        end
                    end
                end)
                if not smartWait("Treadmill", 1.0) then break end
            end
        end)
    end
end)

-- 6. Auto Pumpkin/Manor Quest
createFeatureToggle("Quest", "Auto Pumpkin/Manor Quest", "Quest target resmi", function(state)
    if state then
        task.spawn(function()
            while runningStates["Quest"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["Quest"] then break end
                        if obj.Name == "PumpkinQuestTarget" or obj.Name == "ManorQuestTarget" then
                            local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and obj.PrimaryPart)
                            if part then
                                root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                                if not smartWait("Quest", 1.0) then break end
                                if firetouchinterest then firetouchinterest(root, part, 0) firetouchinterest(root, part, 1) end
                                root.CFrame = initPos
                                if not smartWait("Quest", 0.5) then break end
                            end
                        end
                    end
                end)
                if not smartWait("Quest", 3.0) then break end
            end
        end)
    end
end)

-- 7. Auto Ghost Hunt
createFeatureToggle("GhostHunt", "Auto Ghost Hunt", "Berburu hantu tervalidasi", function(state)
    if state then
        task.spawn(function()
            while runningStates["GhostHunt"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, mob in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["GhostHunt"] then break end
                        if mob:IsA("Model") and mob.Name:lower():find("ghost") then
                            local hum = mob:FindFirstChildOfClass("Humanoid")
                            local part = mob.PrimaryPart
                            if hum and hum.Health > 0 and part and (root.Position - part.Position).Magnitude < 40 then
                                root.CFrame = part.CFrame + Vector3.new(0, 3, 2)
                                if not smartWait("GhostHunt", 0.5) then break end
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                end)
                if not smartWait("GhostHunt", 1.5) then break end
            end
        end)
    end
end)

-- 8. Auto Gilbert & Fish
createFeatureToggle("Gilbert", "Auto Gilbert & Fish", "Quest Gilbert aman", function(state)
    if state then
        task.spawn(function()
            while runningStates["Gilbert"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local npc = Workspace:FindFirstChild("FishermanGilbert", true)
                    if npc and npc:IsA("BasePart") then
                        root.CFrame = npc.CFrame + Vector3.new(0, 3, 0)
                        if not smartWait("Gilbert", 1.0) then break end
                        if firetouchinterest then firetouchinterest(root, npc, 0) firetouchinterest(root, npc, 1) end
                    end
                end)
                if not smartWait("Gilbert", 3.0) then break end
            end
        end)
    end
end)

-- 9. Auto Buy Dimension Egg
createFeatureToggle("BuyEgg", "Auto Buy Dimension Egg", "Beli Dimension Egg", function(state)
    if state then
        task.spawn(function()
            while runningStates["BuyEgg"] do
                pcall(function()
                    local rem = ReplicatedStorage:FindFirstChild("BuyDimensionEgg", true)
                    if rem and rem:IsA("RemoteEvent") then rem:FireServer("DimensionEgg") end
                end)
                if not smartWait("BuyEgg", 4.0) then break end
            end
        end)
    end
end)

-- 10. Change Skin Rod
createFeatureToggle("SkinRod", "Change Skin Rod", "Ganti skin pancing", function(state)
    if state then
        task.spawn(function()
            pcall(function()
                local rem = ReplicatedStorage:FindFirstChild("ChangeRodSkin", true)
                if rem and rem:IsA("RemoteEvent") then rem:FireServer("HalloweenSkin") end
            end)
        end)
    end
end)

-- 11. Auto Hit Mobs & Fish
createFeatureToggle("HitFish", "Auto Hit Mobs & Fish", "Serang & mancing terpisah", function(state)
    if state then
        task.spawn(function()
            while runningStates["HitFish"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, mob in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["HitFish"] then break end
                        if mob:IsA("Model") and mob.Name:lower():find("mob") then
                            local hum = mob:FindFirstChildOfClass("Humanoid")
                            local part = mob.PrimaryPart
                            if hum and hum.Health > 0 and part and (root.Position - part.Position).Magnitude < 30 then
                                root.CFrame = CFrame.new(root.Position, part.Position)
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                    local fishRem = ReplicatedStorage:FindFirstChild("FishEvent", true)
                    if fishRem and fishRem:IsA("RemoteEvent") then fishRem:FireServer() end
                end)
                if not smartWait("HitFish", 1.0) then break end
            end
        end)
    end
end)

-- 12. Dynamic FPS Boost (With ChildAdded Listener & Complete Restore)
local origLighting = {GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd}
local origMaterials = {}
local fpsConn = nil

createFeatureToggle("FPS", "FPS Boost & Optimization", "Optimasi dinamis dengan pemulih", function(state)
    if state then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    origMaterials[v] = v.Material
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
            -- Menangkap part baru yang spawn saat fitur aktif
            fpsConn = Workspace.DescendantAdded:Connect(function(v)
                if runningStates["FPS"] and (v:IsA("Part") or v:IsA("MeshPart")) then
                    origMaterials[v] = v.Material
                    v.Material = Enum.Material.SmoothPlastic
                end
            end)
        end)
    else
        pcall(function()
            if fpsConn then
                fpsConn:Disconnect()
                fpsConn = nil
            end
            Lighting.GlobalShadows = origLighting.GlobalShadows
            Lighting.FogEnd = origLighting.FogEnd
            for v, mat in pairs(origMaterials) do
                if v and v.Parent then
                    v.Material = mat
                end
            end
            origMaterials = {}
        end)
    end
end)

-- 13. Anti-AFK (Syntax Fixed & Fully Closed)
local afkConn = nil
createFeatureToggle("AntiAFK", "Anti-AFK Bypass", "Bypass anti-AFK aman", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        afkConn = LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        end)
    else
        if afkConn then
            afkConn:Disconnect()
            afkConn = nil
        end
    end
end)

print("[Qeeewwie Hub v8.3] Enterprise Patched Edition Loaded Successfully!")
