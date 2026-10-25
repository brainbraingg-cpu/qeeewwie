
print("QEEEWWIE TEST: script mulai")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("Player:", player and player.Name or "nil")

if not player then
    warn("LocalPlayer tidak tersedia")
    return
end

local playerGui = player:FindFirstChildOfClass("PlayerGui")

if not playerGui then
    warn("PlayerGui belum ditemukan")
    return
end

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwieDebug"
gui.ResetOnSpawn = false

local label = Instance.new("TextLabel")
label.Size = UDim2.fromOffset(280, 70)
label.Position = UDim2.new(0.5, -140, 0.3, 0)
label.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Text = "QEEEWWIE TEST BERHASIL"
label.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = label

gui.Parent = playerGui

print("QEEEWWIE TEST: GUI dibuat")
