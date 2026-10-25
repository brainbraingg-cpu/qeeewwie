-- =========================================================
-- QEEEWWIE HUB: SEPARATED FUNCTIONS (LITE EDITION)
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

-- Variabel dipisah masing-masing fitur
local instantGrabActive = false
local autoStealActive = false
local instantStealActive = false
local espEggActive = false

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 270)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB: SEPARATED"
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.Position = UDim2.new(0.05, 0, 0.04, 0)
Title.Size = UDim2.new(0.8, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 13
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.82, 0, 0.04, 0)
CloseBtn.Size = UDim2.new(0, 24, 0, 
    
