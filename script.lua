
-- QEEEWWIE PANEL
-- Original-style compact GUI
-- UI demo for Roblox client

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("QeeewwiePanel")
if old then old:Destroy() end

local purple = Color3.fromRGB(150, 75, 255)
local dark = Color3.fromRGB(22, 20, 30)
local card = Color3.fromRGB(39, 34, 50)
local white = Color3.fromRGB(245, 240, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwiePanel"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = playerGui

-- Tombol untuk membuka panel
local open = Instance.new("TextButton")
open.Size = UDim2.fromOffset(48, 48)
open.Position = UDim2.new(0, 15, 0.4, 0)
open.BackgroundColor3 = purple
open.Text = "Q"
open.TextColor3 = white
open.TextSize = 24
open.Font = Enum.Font.GothamBold
open.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = open

-- Panel utama
local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(245, 260)
panel.Position = UDim2.new(0, 72, 0.35, 0)
panel.BackgroundColor3 = dark
panel.Visible = true
panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

local border = Instance.new("UIStroke")
border.Color = purple
border.Thickness = 1.5
border.Parent = panel

-- Header
local header = Instance.new("TextButton")
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundColor3 = card
header.Text = "QEEEWWIE PANEL"
header.TextColor3 = white
header.TextSize = 14
header.Font = Enum.Font.GothamBold
header.Parent = panel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 28)
close.Position = UDim2.new(1, -34, 0, 7)
close.BackgroundColor3 = Color3.fromRGB(190, 55, 90)
close.Text = "X"
close.TextColor3 = white
close.TextSize = 14
close.Font = Enum.Font.GothamBold
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = close

-- Isi panel
local body = Instance.new("Frame")
body.Size = UDim2.new(1, -16, 1, -54)
body.Position = UDim2.fromOffset(8, 48)
body.BackgroundTransparency = 1
body.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = body

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 28)
status.BackgroundTransparency = 1
status.Text = "Status: Ready"
status.TextColor3 = white
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.Parent = body

local function makeToggle(text)
    local enabled = false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = card
    button.TextColor3 = white
    button.TextSize = 12
    button.Font = Enum.Font.GothamMedium
    button.Parent = body

    local function update()
        button.Text = text .. ": " .. (enabled and "ON" or "OFF")
        button.BackgroundColor3 = enabled
            and purple or card
    end

    update()

    button.Activated:Connect(function()
        enabled = not enabled
        update()
        status.Text = text .. " " .. (enabled and "ON" or "OFF")
    end)

    return button
end

makeToggle("Farm UI")
makeToggle("Egg Tracker")
makeToggle("Event Alert")

-- Buka/tutup panel
open.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

close.Activated:Connect(function()
    panel.Visible = false
end)

-- Geser panel dengan mouse atau sentuhan
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("Qeeewwie Panel berhasil dibuat")
