
-- Qeeewwie Hub
-- GUI lengkap + kontrol durasi
-- Auto Steal belum terhubung ke mekanik game.

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwieHub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(260, 245)
frame.Position = UDim2.new(0.5, -130, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(28, 20, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius =
    UDim.new(0, 12)

local function makeButton(text, y, height)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -24, 0, height)
    b.Position = UDim2.fromOffset(12, y)
    b.BackgroundColor3 = Color3.fromRGB(115, 60, 180)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 14
    b.Font = Enum.Font.GothamBold
    b.Text = text
    b.Parent = frame
    Instance.new("UICorner", b)
    return b
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(145, 75, 220)
title.Text = "Qeeewwie Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame
Instance.new("UICorner", title)

local state = Instance.new("TextLabel")
state.Position = UDim2.fromOffset(12, 45)
state.Size = UDim2.new(1, -24, 0, 25)
state.BackgroundTransparency = 1
state.Text = "Status: OFF"
state.TextColor3 = Color3.new(1, 1, 1)
state.TextSize = 14
state.Parent = frame

local duration = 3
local running = false

local start = makeButton("START AUTO STEAL", 75, 36)
local timer = makeButton("Hold Duration: 3s", 119, 36)
local close = makeButton("CLOSE HUB", 163, 36)

start.MouseButton1Click:Connect(function()
    running = not running
    state.Text = running and
        "Status: ON (preview)" or "Status: OFF"
    start.Text = running and "STOP AUTO STEAL"
        or "START AUTO STEAL"
end)

timer.MouseButton1Click:Connect(function()
    duration = duration == 3 and 4 or 3
    timer.Text = "Hold Duration: " .. duration .. "s"
end)

close.MouseButton1Click:Connect(function()
    running = false
    gui:Destroy()
end)

gui.Parent = player:WaitForChild("PlayerGui")
