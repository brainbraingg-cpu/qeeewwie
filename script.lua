
-- ==========================================
-- Steal an Egg - Qeeewwie Hub Script
-- Work for Arceus X & Other Mobile Executors
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleStealBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")
local EspBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- Setup ScreenGui
ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Setup Frame Utama
MainFrame.Name = "StealEggHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa digeser di layar HP

-- Judul
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "STEAL AN EGG HUB"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 18.000

-- Tombol Close
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.85, -5, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14.000
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Variables & Toggles
local autoSteal = false
local speedBoost = false
local espEnabled = false

-- 1. Tombol Auto Steal
ToggleStealBtn.Name = "StealBtn"
ToggleStealBtn.Parent = MainFrame
ToggleStealBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleStealBtn.Position = UDim2.new(0.1, 0, 0.22, 0)
ToggleStealBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleStealBtn.Font = Enum.Font.SourceSansBold
ToggleStealBtn.Text = "Auto Steal Egg: OFF"
ToggleStealBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleStealBtn.TextSize = 16.000

ToggleStealBtn.MouseButton1Click:Connect(function()
    autoSteal = not autoSteal
    if autoSteal then
        ToggleStealBtn.Text = "Auto Steal Egg: ON"
        ToggleStealBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        ToggleStealBtn.Text = "Auto Steal Egg: OFF"
        ToggleStealBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- 2. Tombol Speed Boost
SpeedBtn.Name = "SpeedBtn"
SpeedBtn.Parent = MainFrame
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "Speed (35): OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
SpeedBtn.TextSize = 16.000

SpeedBtn.MouseButton1Click:Connect(function()
    speedBoost = not speedBoost
    local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if speedBoost then
        SpeedBtn.Text = "Speed (35): ON"
        SpeedBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        if hum then hum.WalkSpeed = 35 end
    else
        SpeedBtn.Text = "Speed (35): OFF"
        SpeedBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        if hum then hum.WalkSpeed = 16 end
    end
end)

-- 3. Tombol Highlight Players (ESP)
EspBtn.Name = "EspBtn"
EspBtn.Parent = MainFrame
EspBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
EspBtn.Position = UDim2.new(0.1, 0, 0.68, 0)
EspBtn.Size = UDim2.new(0.8, 0, 0, 40)
EspBtn.Font = Enum.Font.SourceSansBold
EspBtn.Text = "Player ESP: OFF"
EspBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
EspBtn.TextSize = 16.000

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        EspBtn.Text = "Player ESP: ON"
        EspBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character then
                local hl = Instance.new("Highlight")
                hl.Name = "ESPHighlight"
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.Parent = plr.Character
            end
        end
    else
        EspBtn.Text = "Player ESP: OFF"
        EspBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("ESPHighlight") then
                plr.Character.ESPHighlight:Destroy()
            end
        end
    end
end)

-- Loop Fungsi Auto Steal & Proximity Prompt
task.spawn(function()
    while task.wait(0.2) do
        if autoSteal then
            -- Memicu ProximityPrompt (Ambil Telur) Otomatis
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    fireproximityprompt(prompt)
                end
            end
        end
        
        -- Menjaga keaktifan Speed jika opsi ON
        if speedBoost and game.Players.LocalPlayer.Character then
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= 35 then
                hum.WalkSpeed = 35
            end
        end
    end
end)
