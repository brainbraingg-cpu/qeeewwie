
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if not player then
    warn("LocalPlayer tidak ditemukan")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("QeeewwieCheck")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwieCheck"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
gui.Enabled = true

local frame = Instance.new("Frame")
frame.Name = "Panel"
frame.Size = UDim2.fromOffset(300, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 70)
label.Position = UDim2.fromOffset(10, 15)
label.BackgroundTransparency = 1
label.Text = "QEEEWWIE PANEL"
label.TextColor3 = Color3.new(1, 1, 1)
label.TextSize = 22
label.Font = Enum.Font.GothamBold
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -30, 0, 45)
button.Position = UDim2.fromOffset(15, 105)
button.BackgroundColor3 = Color3.fromRGB(157, 91, 255)
button.Text = "TES TOMBOL"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 16
button.Parent = frame

button.Activated:Connect(function()
    label.Text = "TOMBOL BERHASIL!"
end)

gui.Parent = playerGui
print("Panel test dibuat:", gui.Parent:GetFullName())
