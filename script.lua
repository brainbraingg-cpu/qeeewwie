-- ========================================================
-- Qeeewwie Hub v8.5 | DisplayOrder & Position Fix Edition
-- ========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihkan UI lama jika ada
if PlayerGui:FindFirstChild("QeeewwieMasterHub") then PlayerGui.QeeewwieMasterHub:Destroy() end
if PlayerGui:FindFirstChild("QeeewwieStatusHUD") then PlayerGui.QeeewwieStatusHUD:Destroy() end

task.wait(0.5) -- Jeda stabilisasi PlayerGui

local runningStates = {}

local function smartWait(id, duration)
    local elapsed = 0
    while elapsed < duration do
        if not runningStates[id] then return false end
        task.wait(0.1)
        elapsed = elapsed + 0.1
    end
    return runningStates[id]
end

-- ================= UI UTAMA (DIPAKSA DI LAYER PALING ATAS) =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwieMasterHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999 -- Pastikan tampil di atas segalanya (termasuk menu executor)
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Tombol dipindah ke atas (X: 160, Y: 15) agar tidak nabrak bar executor di kiri
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Position = UDim2.new(0, 160, 0, 15)
ToggleBtn.Size = UDim2.new(0, 140, 0, 42)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "👑 Qeeewwie Hub"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.TextSize = 13
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 255, 150)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -170)
MainFrame.Size = UDim2.new(0, 380, 0, 360)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 150)

local Header = Instance.new("Frame", MainFrame)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.Size = UDim2.new(1, 0, 0, 40)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Header)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Qeeewwie Hub | v8.5 Fixed"
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

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)

ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

CloseButton.MouseButton1Click:Connect(function() 
    MainFrame.Visible = false 
end)

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
local StatusGui = Instance.new("ScreenGui")
StatusGui.Name = "QeeewwieStatusHUD"
StatusGui.ResetOnSpawn = false
StatusGui.DisplayOrder = 999998
StatusGui.Parent = PlayerGui

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
HudTitle.Text = "Steal Egg | Layer-Fixed HUD Tracker"
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
HudStats.BackgroundTransparency, HudStats.Position, HudStats.Size = 1, UDim2.new(0, 12, 0, 44), UDim2.new(1, -24, 0, 16)
HudStats.Font = Enum.Font.Gotham
HudStats.Text = "Attempts: 0 | Touches: 0"
HudStats.TextColor3 = Color3.fromRGB(180, 180, 200)
HudStats.TextSize = 10

-- ================= FITUR UTAMA =================
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

createFeatureToggle("ManorKey", "Auto Manor Key", "Ambil kunci manor", function(state)
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

createFeatureToggle("FPS", "FPS Boost & Optimization", "Optimasi dinamis", function(state)
    if state then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic
                end
            end
        end)
    else
        Lighting.GlobalShadows = true
    end
end)

createFeatureToggle("AntiAFK", "Anti-AFK Bypass", "Bypass anti-AFK aman", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        end)
    end
end)

print("[Qeeewwie Hub v8.5] DisplayOrder Fixed Successfully!")
