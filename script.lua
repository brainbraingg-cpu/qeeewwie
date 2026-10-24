
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "qeeewwie"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(230, 260)
frame.Position = UDim2.new(0.5, -115, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "qeeewwie"
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = frame

local function makeButton(name, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.fromOffset(10, y)
    button.Text = name
    button.TextScaled = true
    button.Parent = frame
    button.Activated:Connect(function()
        print(name .. " dipilih")
    end)
end

makeButton("Farm", 50)
makeButton("Teleport", 100)
makeButton("Speed", 150)
makeButton("Event", 200)

