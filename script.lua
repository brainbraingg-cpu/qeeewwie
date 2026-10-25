-- =========================================================
-- QEEEWWIE HUB: ABSOLUTE MINIMIZE FIX (TELEPORT METHOD)
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

local instantGrabActive = false
local autoCollectActive = false
local speedBoostActive = false
local customWalkSpeed = 50

local rarityFilters = {
    {name = "ALL", active = true},
    {name = "Solaris Egg", active = false},
    {name = "Cherub Egg", active = false},
    {name = "Seraph Egg", active = false},
    {name = "Divine", active = false},
    {name = "Ethereal", active = false},
    {name = "Blackhole Egg", active = false}
}
local currentFilterIdx = 1

-- Simpan posisi awal GUI
local defaultMainPos = UDim2.new(0.05, 0, 0.15, 0)
local hiddenPos = UDim2.new(-2, 0, -2, 0) -- Posisi dilempar keluar layar
local isMinimized = false

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- 1. Main Frame (Menu Utama)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = defaultMainPos
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.03, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Teleport Minimize Fix [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.09, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.
