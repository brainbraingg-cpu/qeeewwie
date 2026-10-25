-- QEEWWWIE PANEL | GUI ONLY
-- Aman untuk demo UI; toggle tidak mengubah gameplay.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika ada
local oldGui = playerGui:FindFirstChild("QeeewwiePanel")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwiePanel"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- Warna
local BG = Color3.fromRGB(18, 20, 28)
local CARD = Color3.fromRGB(29, 32, 43)
local ACCENT = Color3.fromRGB(130, 90, 255)
local TEXT = Color3.fromRGB(245, 245, 255)
local MUTED = Color3.fromRGB(155, 160, 180)
local GREEN = Color3.fromRGB(65, 210, 140)

local function addCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
    return corner
end

local function addStroke(obj, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Transparency = transparency or 0
    stroke.Thickness = 1
    stroke.Parent = obj
    return stroke
end

local function tween(obj, duration, goals)
    local info = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    local animation = TweenService:Create(obj, info, goals)
    animation:Play()
    return animation
end

-- Panel utama
local main = Instance.new("Frame")
main.Name = "MainPanel"
main.Size = UDim2.fromOffset(310, 390)
main.Position = UDim2.new(0.5, -155, 0.5, -195)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui
addCorner(main, 14)
addStroke(main, ACCENT, 0.45)

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundColor3 = Color3.fromRGB(27, 25, 43)
header.BorderSizePixel = 0
header.Parent = main
addCorner(header, 14)

-- Tutup bagian bawah sudut header agar menyatu dengan panel
local headerFill = Instance.new("Frame")
headerFill.Size = UDim2.new(1, 0, 0, 14)
headerFill.Position = UDim2.new(0, 0, 1, -14)
headerFill.BackgroundColor3 = header.BackgroundColor3
headerFill.BorderSizePixel = 0
headerFill.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -85, 0, 28)
title.Position = UDim2.fromOffset(14, 7)
title.BackgroundTransparency = 1
title.Text = "QEEEWWIE PANEL"
title.TextColor3 = TEXT
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -85, 0, 18)
subtitle.Position = UDim2.fromOffset(14, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "UI CONTROL • DEMO MODE"
subtitle.TextColor3 = MUTED
subtitle.TextSize = 9
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(32, 32)
minimize.Position = UDim2.new(1, -43, 0, 13)
minimize.BackgroundColor3 = CARD
minimize.Text = "—"
minimize.TextColor3 = TEXT
minimize.TextSize = 18
minimize.Font = Enum.Font.GothamBold
minimize.AutoButtonColor = false
minimize.Parent = header
addCorner(minimize, 9)

-- Area isi
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -24, 1, -122)
content.Position = UDim2.fromOffset(12, 68)
content.BackgroundTransparency = 1
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local features = {
    "Auto Farm",
    "Auto Steal",
    "Instant Grab",
    "No Knockback",
    "Anti AFK",
    "Event Automation"
}

local toggleStates = {}
local toggleButtons = {}

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 20)
status.Position = UDim2.new(0, 12, 1, -48)
status.BackgroundTransparency = 1
status.Text = "Status: GUI siap"
status.TextColor3 = MUTED
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

for index, featureName in ipairs(features) do
    toggleStates[featureName] = false

    local card = Instance.new("Frame")
    card.Name = featureName:gsub("%s+", "") .. "Card"
    card.Size = UDim2.new(1, 0, 0, 38)
    card.BackgroundColor3 = CARD
    card.BorderSizePixel = 0
    card.LayoutOrder = index
    card.Parent = content
    addCorner(card, 9)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -85, 1, 0)
    label.Position = UDim2.fromOffset(11, 0)
    label.BackgroundTransparency = 1
    label.Text = featureName
    label.TextColor3 = TEXT
    label.TextSize = 12
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = card

    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Size = UDim2.fromOffset(48, 24)
    toggle.Position = UDim2.new(1, -59, 0.5, -12)
    toggle.BackgroundColor3 = Color3.fromRGB(65, 68, 82)
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = card
    addCorner(toggle, 12)

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Size = UDim2.fromOffset(18, 18)
    knob.Position = UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
    knob.BorderSizePixel = 0
    knob.Parent = toggle
    addCorner(knob, 9)

    toggleButtons[featureName] = {
        button = toggle,
        knob = knob
    }

    toggle.Activated:Connect(function()
        local newState = not toggleStates[featureName]
        toggleStates[featureName] = newState

        if newState then
            tween(toggle, 0.16, {BackgroundColor3 = ACCENT})
            tween(knob, 0.16, {
                Position = UDim2.new(1, -21, 0, 3)
            })
            status.Text = featureName .. ": ON (UI saja)"
        else
            tween(toggle, 0.16, {
                BackgroundColor3 = Color3.fromRGB(65, 68, 82)
            })
            tween(knob, 0.16, {
                Position = UDim2.fromOffset(3, 3)
            })
            status.Text = featureName .. ": OFF"
        end
    end)
end

-- Status bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, -24, 0, 24)
statusBar.Position = UDim2.new(0, 12, 1, -26)
statusBar.BackgroundColor3 = Color3.fromRGB(27, 30, 41)
statusBar.BorderSizePixel = 0
statusBar.Parent = main
addCorner(statusBar, 7)

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0.5, -8, 1, 0)
fpsLabel.Position = UDim2.fromOffset(8, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = GREEN
fpsLabel.TextSize = 10
fpsLabel.Font = Enum.Font.GothamMedium
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = statusBar

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0.5, -8, 1, 0)
timeLabel.Position = UDim2.new(0.5, 0, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Session: 00:00"
timeLabel.TextColor3 = MUTED
timeLabel.TextSize = 10
timeLabel.Font = Enum.Font.GothamMedium
timeLabel.TextXAlignment = Enum.TextXAlignment.Right
timeLabel.Parent = statusBar

-- FPS dan waktu sesi
local elapsed = 0
local frames = 0
local fpsElapsed = 0

local renderConnection
renderConnection = RunService.RenderStepped:Connect(function(dt)
    elapsed += dt
    frames += 1
    fpsElapsed += dt

    if fpsElapsed >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(math.floor(frames / fpsElapsed))
        frames = 0
        fpsElapsed = 0
    end

    local totalSeconds = math.floor(elapsed)
    local minutes = math.floor(totalSeconds / 60)
    local seconds = totalSeconds % 60
    timeLabel.Text = string.format("Session: %02d:%02d", minutes, seconds)
end)

-- Minimize / restore
local minimized = false
local fullSize = UDim2.fromOffset(310, 390)

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        content.Visible = false
        status.Visible = false
        statusBar.Visible = false
        minimize.Text = "+"
        tween(main, 0.2, {
            Size = UDim2.fromOffset(310, 58)
        })
    else
        minimize.Text = "—"
        tween(main, 0.2, {Size = fullSize})
        task.delay(0.2, function()
            if gui.Parent and not minimized then
                content.Visible = true
                status.Visible = true
                statusBar.Visible = true
            end
        end)
    end
end)

-- Drag panel: mouse dan layar sentuh
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Munculkan panel dengan animasi
main.Size = UDim2.fromOffset(0, 0)
tween(main, 0.3, {Size = fullSize})

print("Qeeewwie Panel loaded.")
