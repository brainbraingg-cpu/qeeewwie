-- ==========================================
-- Qeeewwie Hub v7 | Instant Steal + Auto Treadmill
-- Game: Steal an Egg / Simulator
-- Executor: Arceus X / Delta
-- ==========================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Bersihkan UI lama
if CoreGui:FindFirstChild("QeeewwieTreadmillHub") then
    CoreGui.QeeewwieTreadmillHub:Destroy()
end

-- ================= UI SETUP =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwieTreadmillHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Position = UDim2.new(0, 20, 0, 120)
ToggleBtn.Size = UDim2.new(0, 130, 0, 45)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "👑 Qeeewwie Hub"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.TextSize = 13
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleBtn

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -150)
MainFrame.Size = UDim2.new(0, 360, 0, 320)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.Size = UDim2.new(1, 0, 0, 40)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 280, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Qeeewwie Hub | Steal & Treadmill"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Header
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 8)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 11

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 12, 0, 50)
Container.Size = UDim2.new(1, -24, 1, -60)
Container.CanvasSize = UDim2.new(0, 0, 0, 420)
Container.ScrollBarThickness = 3

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local function createFeatureToggle(name, desc, callback)
    local Wrapper = Instance.new("Frame")
    Wrapper.Parent = Container
    Wrapper.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Wrapper.Size = UDim2.new(1, 0, 0, 50)
    
    local WrapCorner = Instance.new("UICorner")
    WrapCorner.CornerRadius = UDim.new(0, 8)
    WrapCorner.Parent = Wrapper
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Wrapper
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 12, 0, 5)
    Label.Size = UDim2.new(0, 200, 0, 20)
    Label.Font = Enum.Font.GothamBold
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Parent = Wrapper
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 12, 0, 25)
    DescLabel.Size = UDim2.new(0, 200, 0, 18)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    DescLabel.TextSize = 11
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Parent = Wrapper
    ActionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    ActionBtn.Position = UDim2.new(1, -95, 0, 10)
    ActionBtn.Size = UDim2.new(0, 85, 0, 30)
    ActionBtn.Font = Enum.Font.GothamBold
    ActionBtn.Text = "OFF"
    ActionBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ActionBtn.TextSize = 12

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = ActionBtn

    local state = false
    ActionBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            ActionBtn.Text = "ON"
            ActionBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
            ActionBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
        else
            ActionBtn.Text = "OFF"
            ActionBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
            ActionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        end
        callback(state)
    end)
end

-- ================= FITUR-FITUR QEEEWWIE HUB =================

-- 1. Auto Steal Instant
local instantStealActive = false
createFeatureToggle("Auto Steal Instant", "Teleport instan ke telur & delay 1 detik", function(state)
    instantStealActive = state
    if instantStealActive then
        task.spawn(function()
            print("[Qeeewwie Hub] Auto Steal Instant Berjalan!")
            while instantStealActive do
                task.wait(0.5)
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = char:WaitForChild("HumanoidRootPart")
                    local initialPos = rootPart.CFrame
                    
                    local targetFolder = nil
                    for _, v in ipairs(Workspace:GetChildren()) do
                        local name = v.Name:lower()
                        if name:find("egg") or name:find("spawn") or name:find("drop") or name:find("item") then
                            targetFolder = v
                            break
                        end
                    end
                    
                    if targetFolder then
                        for _, item in ipairs(targetFolder:GetChildren()) do
                            if not instantStealActive then break end
                            local part = item:IsA("BasePart") and item or (item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")))
                            
                            if part and rootPart then
                                rootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                                task.wait(1.0) -- Delay 1 detik aman anti-cheat
                                
                                if firetouchinterest then
                                    firetouchinterest(rootPart, part, 0)
                                    firetouchinterest(rootPart, part, 1)
                                end
                                
                                rootPart.CFrame = initialPos
                                task.wait(0.3)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 2. Auto Treadmill (Otomatis latihan di Treadmill / Alat Lari)
local autoTreadmillActive = false
createFeatureToggle("Auto Treadmill", "Otomatis lari/latihan di treadmill map", function(state)
    autoTreadmillActive = state
    if autoTreadmillActive then
        task.spawn(function()
            print("[Qeeewwie Hub] Auto Treadmill Berjalan!")
            while autoTreadmillActive do
                task.wait(1)
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = char:WaitForChild("HumanoidRootPart")
                    
                    -- Cari objek treadmill secara otomatis di Workspace
                    local treadmillPart = nil
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        local name = obj.Name:lower()
                        if (name:find("treadmill") or name:find("run") or name:find("training") or name:find("gym")) and obj:IsA("BasePart") then
                            treadmillPart = obj
                            break
                        end
                    end
                    
                    if treadmillPart and rootPart then
                        -- Teleport langsung ke atas treadmill
                        rootPart.CFrame = treadmillPart.CFrame + Vector3.new(0, 3, 0)
                        
                        -- Simulasi sentuhan/interaksi latihan
                        if firetouchinterest then
                            firetouchinterest(rootPart, treadmillPart, 0)
                            firetouchinterest(rootPart, treadmillPart, 1)
                        end
                    else
                        warn("[Qeeewwie Hub] Treadmill tidak ditemukan di map ini!")
                    end
                end)
            end
        end)
    end
end)

-- 3. Anti-AFK
createFeatureToggle("Anti-AFK Bypass", "Mencegah kick otomatis", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        end)
        print("[Qeeewwie Hub] Anti-AFK Aktif!")
    end
end)

print("[Qeeewwie Hub v7] Full Features Loaded Successfully!")
