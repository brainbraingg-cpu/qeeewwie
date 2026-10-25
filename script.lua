-- QEEEWWIE SAFE TESTER
if game:GetService("CoreGui"):FindFirstChild("QeeewwieSafeUI") then
    game:GetService("CoreGui").QeeewwieSafeUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieSafeUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE AMAN"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local Btn = Instance.new("TextButton", MainFrame)
Btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
Btn.Position = UDim2.new(0.1, 0, 0.4, 0)
Btn.Size = UDim2.new(0.8, 0, 0, 40)
Btn.Font = Enum.Font.SourceSansBold
Btn.Text = "KLIK SAYA"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.TextSize = 13

Btn.Activated:Connect(function()
    Btn.Text = "BERHASIL DIKLIK!"
    task.wait(1.5)
    Btn.Text = "KLIK SAYA"
end)
