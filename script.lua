-- =========================================================
-- QEEEWWIE HUB: GACOR EDITION + AUTO INSTANT STEAL [🔥]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

local instantGrabActive = false
local autoInstantStealActive = false -- Fitur Baru Ditambahkan
local autoCollectActive = false
local speedBoostActive = false
local espEggActive = false
local customWalkSpeed = 65

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

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 420) -- Ukuran ditinggikan sedikit buat nampung tombol baru
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.Position = UDim2.new(0.08, 0, 0.02, 0)
Title.Size = UDim2.new(0.70, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.ZIndex = 11

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Gacor + Auto Steal Edition [🔥]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.08, 0, 0.07, 0)
SubTitle.Size = UDim2.new(0.70, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1
SubTitle.ZIndex = 11

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.80, 0, 0.02, 0)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.13, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 28)
TabContainer.ZIndex = 11

local TabFarm = Instance.new("TextButton", TabContainer)
TabFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabFarm.Size = UDim2.new(0.48, 0, 1, 0)
TabFarm.Font = Enum.Font.SourceSansBold
TabFarm.Text = "EGG & FILTER"
TabFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
TabFarm.TextSize = 10
TabFarm.ZIndex = 12
Instance.new("UICorner", TabFarm).CornerRadius = UDim.new(0, 6)

local TabPlayer = Instance.new("TextButton", TabContainer)
TabPlayer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabPlayer.Position = UDim2.new(0.52, 0, 0, 0)
TabPlayer.Size = UDim2.new(0.48, 0, 1, 0)
TabPlayer.Font = Enum.Font.SourceSansBold
TabPlayer.Text = "PLAYER SPEED"
TabPlayer.TextColor3 = Color3.fromRGB(180, 180, 180)
TabPlayer.TextSize = 10
TabPlayer.ZIndex = 12
Instance.new("UICorner", TabPlayer).CornerRadius = UDim.new(0, 6)

local PageFarm = Instance.new("Frame", MainFrame)
PageFarm.BackgroundTransparency = 1
PageFarm.Position = UDim2.new(0.05, 0, 0.21, 0)
PageFarm.Size = UDim2.new(0.9, 0, 0.76, 0)
PageFarm.ZIndex = 11

local PagePlayer = Instance.new("Frame", MainFrame)
PagePlayer.BackgroundTransparency = 1
PagePlayer.Position = UDim2.new(0.05, 0, 0.21, 0)
PagePlayer.Size = UDim2.new(0.9, 0, 0.76, 0)
PagePlayer.Visible = false
PagePlayer.ZIndex = 11

local InstantGrabBtn = Instance.new("TextButton", PageFarm)
InstantGrabBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
InstantGrabBtn.Position = UDim2.new(0, 0, 0.01, 0)
InstantGrabBtn.Size = UDim2.new(1, 0, 0, 26)
InstantGrabBtn.Font = Enum.Font.SourceSansBold
InstantGrabBtn.Text = "
