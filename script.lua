-- ========================================================
-- Qeeewwie Hub | Fixed UI & Ultimate Edition
-- Game: Steal an Egg
-- ========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihkan UI lama secara total
if PlayerGui:FindFirstChild("QeeewwieMasterHub") then PlayerGui.QeeewwieMasterHub:Destroy() end
if PlayerGui:FindFirstChild("QeeewwieStatusHUD") then PlayerGui.QeeewwieStatusHUD:Destroy() end

task.wait(0.3)

local runningStates = {}
local config = { TweenSpeed = 450 }

-- ================= UI UTAMA (MASTER HUB) =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwieMasterHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

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
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -190)
MainFrame.Size = UDim2.new(0, 380, 0, 380)
MainFrame.Visible = true -- Langsung munculkan agar tidak kosong
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
Title.Text = "Qeeewwie Hub | Fixed Edition"
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

-- Menggunakan Frame biasa dengan UIListLayout agar aman di semua executor mobile (tanpa ScrollingFrame bug)
local Container = Instance.new("Frame", MainFrame)
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 12, 0, 50)
Container.Size = UDim2.new(1, -24, 1, -60)

local UIListLayout = Instance.new("UIListLayout", Container)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseButton.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

local function createFeatureToggle(id, name, desc, callback)
    local Wrapper = Instance.new("Frame", Container)
    Wrapper.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Wrapper.Size = UDim2.new(1, 0, 0, 60)
    Instance.new("UICorner", Wrapper).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel", Wrapper)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 12, 0, 8)
    Label.Size = UDim2.new(0, 220, 0, 20)
    Label.Font = Enum.Font.GothamBold
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local DescLabel = Instance.new("TextLabel", Wrapper)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 12, 0, 30)
    DescLabel.Size = UDim2.new(0, 220, 0, 18)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    DescLabel.TextSize = 11
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ActionBtn = Instance.new("TextButton", Wrapper)
    ActionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    ActionBtn.Position = UDim2.new(1, -95, 0, 15)
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
HudFrame.Size = UDim2.new(0, 340, 0, 60)
HudFrame.Visible = false
HudFrame.Active = true
HudFrame.Draggable = true
Instance.new("UICorner", HudFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", HudFrame).Color = Color3.fromRGB(0, 255, 150)

local HudInfo = Instance.new("TextLabel", HudFrame)
HudInfo.BackgroundTransparency = 1
HudInfo.Position = UDim2.new(0, 12, 0, 10)
HudInfo.Size = UDim2.new(1, -24, 0, 20)
HudInfo.Font = Enum.Font.GothamBold
HudInfo.Text = "Status: Qeeewwie Hub Active"
HudInfo.TextColor3 = Color3.fromRGB(0, 255, 150)
HudInfo.TextSize = 11

local HudStats = Instance.new("TextLabel", HudFrame)
HudStats.BackgroundTransparency = 1
HudStats.Position = UDim2.new(0, 12, 0, 32)
HudStats.Size = UDim2.new(1, -24, 0, 16)
HudStats.Font = Enum.Font.Gotham
HudStats.Text = "Ready to Steal & Boost"
HudStats.TextColor3 = Color3.fromRGB(180, 180, 200)
HudStats.TextSize = 10

-- ================= FITUR UTAMA =================

-- 1. Ultimate Auto Steal
createFeatureToggle("UltimateSteal", "Ultimate Auto Steal", "Curi telur cepat & aman dari kick", function(state)
    HudFrame.Visible = state
    if state then
        task.spawn(function()
            while runningStates["UltimateSteal"] do
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local root = char:WaitForChild("HumanoidRootPart")
                    local initPos = root.CFrame
                    
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if not runningStates["UltimateSteal"] then break end
                        local nameLower = obj.Name:lower()
                        if nameLower:find("egg") or nameLower:find("telur") then
                            local part = obj:IsA("BasePart") and obj or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")))
                            if part then
                                local distance = (root.Position - part.Position).Magnitude
                                local travelTime = math.clamp(distance / config.TweenSpeed, 0.2, 1.2)
                                
                                local tween = TweenService:Create(root, TweenInfo.new(travelTime, Enum.EasingStyle.Linear), {CFrame = part.CFrame + Vector3.new(0, 2.5, 0)})
                                tween:Play()
                                tween.Completed:Wait()
                                
                                if not runningStates["UltimateSteal"] then break end
                                task.wait(0.2)
                                
                                if firetouchinterest then
                                    firetouchinterest(root, part, 0)
                                    firetouchinterest(root, part, 1)
                                end
                                
                                task.wait(0.15)
                                local returnTween = TweenService:Create(root, TweenInfo.new(travelTime, Enum.EasingStyle.Linear), {CFrame = initPos})
                                returnTween:Play()
                                returnTween.Completed:Wait()
                                
                                if not runningStates["UltimateSteal"] then break end
                                task.wait(0.3)
                            end
                        end
                    end
                end)
                task.wait(1.5)
            end
        end)
    end
end)

-- 2. Mode Fly
local flyConn = nil
createFeatureToggle("FlyMode", "Mode Fly (Terbang)", "Terbang bebas melayang di udara", function(state)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    if state then
        local bg = Instance.new("BodyGyro", root)
        bg.Name = "QeeewwieFlyGyro"
        bg.MaxTorque = Vector3.new(90000, 90000, 90000)
        bg.CFrame = root.CFrame

        local bv = Instance.new("BodyVelocity", root)
        bv.Name = "QeeewwieFlyVelocity"
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.MaxForce = Vector3.new(90000, 90000, 90000)

        flyConn = RunService.RenderStepped:Connect(function()
            if not runningStates["FlyMode"] then return end
            pcall(function()
                bg.CFrame = Workspace.CurrentCamera.CFrame
                bv.Velocity = Workspace.CurrentCamera.CFrame.LookVector * 50
            end)
        end)
    else
        if flyConn then flyConn:Disconnect() flyConn = nil end
        if root:FindFirstChild("QeeewwieFlyGyro") then root.QeeewwieFlyGyro:Destroy() end
        if root:FindFirstChild("QeeewwieFlyVelocity") then root.QeeewwieFlyVelocity:Destroy() end
    end
end)

-- 3. Ultra FPS Boost
local origLighting = {GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd, Brightness = Lighting.Brightness}
local origMaterials = {}
local fpsConn = nil

createFeatureToggle("FPS", "Sena-Style Ultra FPS Boost", "Anti-lag maksimal & mulus total", function(state)
    if state then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.Brightness = 2
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    origMaterials[v] = v.Material
                    v.Material = Enum.Material.SmoothPlastic
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end
            fpsConn = Workspace.DescendantAdded:Connect(function(v)
                if runningStates["FPS"] then
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        origMaterials[v] = v.Material
                        v.Material = Enum.Material.SmoothPlastic
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Enabled = false
                    end
                end
            end)
        end)
    else
        pcall(function()
            if fpsConn then fpsConn:Disconnect() fpsConn = nil end
            Lighting.GlobalShadows = origLighting.GlobalShadows
            Lighting.FogEnd = origLighting.FogEnd
            Lighting.Brightness = origLighting.Brightness
            for v, mat in pairs(origMaterials) do
                if v and v.Parent then v.Material = mat end
            end
            origMaterials = {}
        end)
    end
end)

-- 4. Anti-AFK
local afkConn = nil
createFeatureToggle("AntiAFK", "Anti-AFK Bypass", "Mencegah kick AFK otomatis", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        afkConn = LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        end)
    else
        if afkConn then afkConn:Disconnect() afkConn = nil end
    end
end)

print("[Qeeewwie Hub] Fixed UI Edition Loaded Successfully!")
