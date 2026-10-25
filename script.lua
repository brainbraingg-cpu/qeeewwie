
-- qeeewwie | GUI Update
-- GUI, FPS monitor, mode grafis, dan menu egg
-- Sistem pickup harus diimplementasikan di game milik sendiri.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("qeeewwie")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "qeeewwie"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(250, 340)
frame.Position = UDim2.new(0.5, -125, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 25, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 42)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "qeeewwie"
title.TextColor3 = Color3.fromRGB(130, 190, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local hide = Instance.new("TextButton")
hide.Size = UDim2.fromOffset(32, 32)
hide.Position = UDim2.new(1, -38, 0, 5)
hide.Text = "—"
hide.TextScaled = true
hide.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.fromOffset(10, 42)
status.BackgroundTransparency = 1
status.Text = "Status: Siap"
status.TextColor3 = Color3.new(1, 1, 1)
status.TextScaled = true
status.Parent = frame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, -20, 0, 25)
fpsLabel.Position = UDim2.fromOffset(10, 72)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: menghitung..."
fpsLabel.TextColor3 = Color3.fromRGB(120, 255, 160)
fpsLabel.TextScaled = true
fpsLabel.Parent = frame

local function makeButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 38)
    button.Position = UDim2.fromOffset(10, y)
    button.BackgroundColor3 = Color3.fromRGB(48, 53, 78)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = button

    button.Activated:Connect(callback)
    return button
end

makeButton("Farm Menu", 105, function()
    status.Text = "Farm: perlu integrasi game sendiri"
end)

makeButton("Egg Priority", 149, function()
    status.Text = "Prioritas: Divine > Eternal > Secret"
end)

makeButton("Mode Ringan", 193, function()
    status.Text = "Mode ringan dipilih"
    -- Tidak mengubah grafik game lain secara otomatis.
end)

makeButton("Mode Normal", 237, function()
    status.Text = "Mode normal dipilih"
end)

makeButton("Tutup GUI", 281, function()
    gui:Destroy()
end)

hide.Activated:Connect(function()
    frame.Visible = false

    local reopen = Instance.new("TextButton")
    reopen.Name = "ReopenQeeewwie"
    reopen.Size = UDim2.fromOffset(110, 38)
    reopen.Position = UDim2.new(0, 15, 0.5, 0)
    reopen.Text = "Buka qeeewwie"
    reopen.TextScaled = true
    reopen.Parent = gui

    reopen.Activated:Connect(function()
        frame.Visible = true
        reopen:Destroy()
    end)
end)

local frames = 0
local elapsed = 0

local connection
connection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent then
        connection:Disconnect()
        return
    end

    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fpsLabel.Text = "FPS: " .. math.floor(frames / elapsed)
        frames = 0
        elapsed = 0
    end
end)
