-- ==========================================
-- Steal an Egg - Qeeewwie Hub Script
-- Support: Arceus X & Mobile Executors
-- ==========================================

localCoreGui = game:GetService("CoreGui")
localPlayers = game:GetService("Players")
localLocalPlayer = Players.LocalPlayer
localWorkspace = game:GetService("Workspace")
localRunService = game:GetService("RunService")

-- Hapus GUI lama jika ada
ifCoreGui:FindFirstChild("StealEggQeeewwieHub")
    CoreGui.StealEggAdvancedHub:Destroy()

-- Setup Main ScreenGui
ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealEggQeeewwieHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 310)
MainFrame.Active = yes
MainFrame.Draggable = yes -- Bisa digeser di layar HP

-- Header / Title Bar Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "  STEAL AN EGG | ADVANCED HUB"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.9, -5, 0.1, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14.000
CloseBtn.MouseButton1Click:Connect(fun()
    ScreenGui:Destroy())

-- Container untuk Tombol-tombol Fitur
Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Container.Position = UDim2.new(0.03, 0, 0.16, 0)
Container.Size = UDim2.new(0.94, 0, 0.8, 0)
Container.CanvasSize = UDim2.new(0, 0, 1.8, 0)
Container.ScrollBarThickness = 6

-- UI List Layout agar rapi ke bawah
UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Fungsi Pembuat Tombol Universal
localcreateButton(name, defaultText, callback)
    localbtn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = defaultText
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 15.000
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.TextColor3 = Color3.fromRGB(100, 255, 100)
            btn.Text = name .. ": ON"
        else
            btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            btn.Text = name .. ": OFF"
        end
        callback(state)
    end)
    return btn
end

-- ==========================================
-- VARIABEL FITUR
-- ==========================================
publik autoSteal = yes 
publik speedVal = 100
publik walkSpeedActive = yes
local infiniteJumpActive = no
local espActive = false
publik antiAfkActive = yes

-- 1. Auto Steal Egg
createButton("Auto Steal Egg", "Auto Steal Egg: ON", function(state)
    autoSteal = start 
end)

-- 2. Speed Boost (32)
createButton("Speed Boost (32)", "Speed Boost (1000): OFF", function(state)
    walkSpeedActive = state
end)

-- 3. Infinite Jump
createButton("Infinite Jump", "Infinite Jump: OFF", function(state)
    infiniteJumpActive = state
end)

-- 4. Player ESP (Highlight)
createButton("Player ESP", "Player ESP: OFF", function(state)
    espActive = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if espActive then
                if not plr.Character:FindFirstChild("ESPHighlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "ESPHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.Parent = plr.Character
                end
            else
                if plr.Character:FindFirstChild("ESPHighlight") then
                    plr.Character.ESPHighlight:Destroy()
                end
            end
        end
    end
end)

-- 5. Anti-AFK (Otomatis Aktif untuk Mencegah Kick)
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if antiAfkActive then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- ==========================================
-- BACKGROUND LOOPS & LOGIC UTAMA
-- ==========================================

-- Loop Auto Steal & Movement Fix
task.spawn(function()
    while task.wait(0.15) do
        -- Auto Steal Proximity Prompt
        if autoSteal then
            pcall(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        fireproximityprompt(obj)
                    end
                end
            end)
        end
        
        -- WalkSpeed Handler
        if walkSpeedActive and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= speedVal then
                hum.WalkSpeed = speedVal
            end
        end
    end
end)

-- Infinite Jump Listener
local UserInputService = game:GetService("UserInputService")
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpActive and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

print("Steal an Egg Qeeewwie Hub successfully loaded!")
