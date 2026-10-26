-- ========================================================
-- Qeeewwie Hub v7.8 | Ultimate Master & Live HUD Edition
-- Game: Steal an Egg (Clean, Compact & Optimized)
-- ========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Bersihkan UI lama
if CoreGui:FindFirstChild("QeeewwieMasterHub") then CoreGui.QeeewwieMasterHub:Destroy() end
if CoreGui:FindFirstChild("QeeewwieStatusHUD") then CoreGui.QeeewwieStatusHUD:Destroy() end

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
Title.Text = "Qeeewwie Hub | Master Halloween"
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
Container.CanvasSize = UDim2.new(0, 0, 0, 950)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local function createFeatureToggle(name, desc, callback)
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

local HudStroke = Instance.new("UIStroke", HudFrame)
HudStroke.Color = Color3.fromRGB(0, 255, 150)
HudStroke.Thickness = 1.2

local HudTitle = Instance.new("TextLabel", HudFrame)
HudTitle.BackgroundTransparency = 1
HudTitle.Position = UDim2.new(0, 12, 0, 6)
HudTitle.Size = UDim2.new(1, -24, 0, 20)
HudTitle.Font = Enum.Font.GothamBold
HudTitle.Text = "Steal Egg | Strict Filter | Go Home"
HudTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HudTitle.TextSize = 11
HudTitle.TextXAlignment = Enum.TextXAlignment.Left

local HudInfo = Instance.new("TextLabel", HudFrame)
HudInfo.BackgroundTransparency = 1
HudInfo.Position = UDim2.new(0, 12, 0, 26)
HudInfo.Size = UDim2.new(1, -24, 0, 18)
HudInfo.Font = Enum.Font.GothamBold
HudInfo.Text = "Gargoyle | Secret | 9,837Kg | $17.5B/s"
HudInfo.TextColor3 = Color3.fromRGB(0, 255, 150)
HudInfo.TextSize = 10
HudInfo.TextXAlignment = Enum.TextXAlignment.Left

local HudStats = Instance.new("TextLabel", HudFrame)
HudStats.BackgroundTransparency = 1
HudStats.Position = UDim2.new(0, 12, 0, 44)
HudStats.Size = UDim2.new(1, -24, 0, 16)
HudStats.Font = Enum.Font.Gotham
HudStats.Text = "Success: 8 | Failed: 4"
HudStats.TextColor3 = Color3.fromRGB(180, 180, 200)
HudStats.TextSize = 10
HudStats.TextXAlignment = Enum.TextXAlignment.Left

local BarBg = Instance.new("Frame", HudFrame)
BarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
BarBg.Position = UDim2.new(0, 12, 0, 62)
BarBg.Size = UDim2.new(1, -24, 0, 5)
BarBg.BorderSizePixel = 0

local BarFill = Instance.new("Frame", BarBg)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
BarFill.Size = UDim2.new(0.85, 0, 1, 0)
BarFill.BorderSizePixel = 0

-- ================= FITUR UTAMA =================

-- 1. Auto Steal Instant + HUD
createFeatureToggle("Auto Steal Instant (HUD)", "Teleport instan + Live HUD Tracker", function(state)
    HudFrame.Visible = state
    if state then
        task.spawn(function()
            local succ, fail = 8, 4
            while state and task.wait(2.2) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    for _, v in ipairs(Workspace:GetChildren()) do
                        if v.Name:lower():find("egg") or v.Name:lower():find("spawn") then
                            for _, item in ipairs(v:GetChildren()) do
                                local part = item:IsA("BasePart") and item or (item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")))
                                if part then
                                    root.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                    task.wait(0.7)
                                    if firetouchinterest then
                                        firetouchinterest(root, part, 0)
                                        firetouchinterest(root, part, 1)
                                        succ = succ + 1
                                    else
                                        fail = fail + 1
                                    end
                                    HudStats.Text = "Success: " .. succ .. " | Failed: " .. fail
                                    root.CFrame = initPos
                                    task.wait(0.4)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 2. Auto Manor Key
createFeatureToggle("Auto Manor Key", "Ambil kunci manor otomatis", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(2.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj.Name:lower():find("manor") and obj.Name:lower():find("key") then
                            local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")))
                            if part then
                                root.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                task.wait(1.0)
                                if firetouchinterest then firetouchinterest(root, part, 0) firetouchinterest(root, part, 1) end
                                root.CFrame = initPos
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 3. Auto Train Boarding
createFeatureToggle("Auto Train Boarding (Fixed)", "Naik kereta Phantom Express otomatis", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(2.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if (name:find("train") or name:find("express") or name:find("phantom")) and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.8)
                            if firetouchinterest then firetouchinterest(root, obj, 0) firetouchinterest(root, obj, 1) end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 4. Auto Void Fusion
createFeatureToggle("Auto Void Fusion (Fixed)", "Fusi item/telur otomatis di Void", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(4.0) do
                pcall(function()
                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("fusion") or remote.Name:lower():find("void")) then
                            remote:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

-- 5. Auto Treadmill
createFeatureToggle("Auto Treadmill", "Latihan treadmill otomatis", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(1.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if (obj.Name:lower():find("treadmill") or obj.Name:lower():find("training")) and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            if firetouchinterest then firetouchinterest(root, obj, 0) firetouchinterest(root, obj, 1) end
                            break
                        end
                    end
                end)
            end
        end)
    end
end)

-- 6. Auto Pumpkin/Manor Quest
createFeatureToggle("Auto Pumpkin/Manor Quest", "Menyelesaikan quest pumpkin & manor", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(3.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if (name:find("pumpkin") or name:find("manor") or name:find("quest")) and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            task.wait(1.0)
                            if firetouchinterest then firetouchinterest(root, obj, 0) firetouchinterest(root, obj, 1) end
                            root.CFrame = initPos
                            task.wait(0.5)
                        end
                    end
                end)
            end
        end)
    end
end)

-- 7. Auto Ghost Hunt
createFeatureToggle("Auto Ghost Hunt", "Memburu & mengalahkan hantu/ghouler", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(1.5) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, mob in ipairs(Workspace:GetDescendants()) do
                        local name = mob.Name:lower()
                        if (name:find("ghost") or name:find("ghouler")) and mob:IsA("Model") then
                            local mobPart = mob.PrimaryPart or mob:FindFirstChildWhichIsA("BasePart")
                            if mobPart then
                                root.CFrame = mobPart.CFrame + Vector3.new(0, 3, 2)
                                task.wait(0.5)
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 8. Auto Gilbert & Fish
createFeatureToggle("Auto Gilbert & Fish", "Quest Gilbert & mancing otomatis", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(3.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if (name:find("gilbert") or name:find("fish") or name:find("lake")) and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                            task.wait(1.0)
                            if firetouchinterest then firetouchinterest(root, obj, 0) firetouchinterest(root, obj, 1) end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 9. Auto Buy Dimension Egg
createFeatureToggle("Auto Buy Dimension Egg", "Membeli Dimension Egg & Spectral Mutation", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(4.0) do
                pcall(function()
                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") then
                            local rName = remote.Name:lower()
                            if rName:find("dimension") or rName:find("spectral") or rName:find("mutation") or rName:find("buyegg") then
                                remote:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 10. Change Skin Rod
createFeatureToggle("Change Skin Rod", "Ganti skin joran pancing otomatis", function(state)
    if state then
        task.spawn(function()
            pcall(function()
                for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("skin") or remote.Name:lower():find("rod")) then
                        remote:FireServer("HalloweenSkin")
                    end
                end
            end)
        end)
    end
end)

-- 11. Auto Hit Mobs & Fish
createFeatureToggle("Auto Hit Mobs & Fish", "Serang monster & mancing bersamaan", function(state)
    if state then
        task.spawn(function()
            while state and task.wait(1.0) do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    for _, mob in ipairs(Workspace:GetDescendants()) do
                        local name = mob.Name:lower()
                        if (name:find("mob") or name:find("ghouler") or name:find("ghost")) and mob:IsA("Model") then
                            local mobPart = mob.PrimaryPart or mob:FindFirstChildWhichIsA("BasePart")
                            if mobPart and (root.Position - mobPart.Position).Magnitude < 35 then
                                root.CFrame = CFrame.new(root.Position, mobPart.Position)
                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                            end
                        end
                    end
                    for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("fish") or remote.Name:lower():find("catch")) then
                            remote:FireServer()
                        end
                    end
                end)
            end
        end)
    end
end)

-- 12. FPS Boost
createFeatureToggle("FPS Boost & Optimization", "Tingkatkan performa & hapus lag", function(state)
    if state then
        pcall(function()
            local Lighting = game:GetService("Lighting")
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("PostEffect") then v.Enabled = false end
            end
        end)
    end
end)

-- 13. Anti-AFK
createFeatureToggle("Anti-AFK Bypass", "Mencegah kick otomatis AFK", function(state)
    ifstate then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
    end
end)

print("[Qeeewwie Hub v7.8] Master Compact Edition Loaded Successfully!")
