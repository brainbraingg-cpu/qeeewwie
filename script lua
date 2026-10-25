-- =========================================================
-- QEEEWWIE HUB: SENJU EDITION (MULTI-TAB + AUTO STEAL + HALLOWEEN)
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Variabel Fitur
local autoStealActive = false
local autoHalloweenActive = false
local selectedFilter = "ALL"
local stealSpeedMode = "NORMAL"

-- 1. Membuat Menu Utama & Tema Senju
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Header / Logo Senju Profile (Gambar dari Asset ID / Link Dekorasi)
local HeaderImage = Instance.new("ImageLabel", MainFrame)
HeaderImage.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
HeaderImage.Position = UDim2.new(0.05, 0, 0.04, 0)
HeaderImage.Size = UDim2.new(0, 45, 0, 45)
HeaderImage.Image = "rbxassetid://0" -- Placeholder, diganti sistem gambar Roblox atau warna tema
HeaderImage.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", HeaderImage).CornerRadius = UDim.new(1, 0)

-- Judul & Branding Senju
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.28, 0, 0.04, 0)
Title.Size = UDim2.new(0.65, 0, 0, 22)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel", MainFrame)
SubTitle.Text = "Senju Edition [⚡]"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Position = UDim2.new(0.28, 0, 0.20, 0)
SubTitle.Size = UDim2.new(0.65, 0, 0, 18)
SubTitle.Font = Enum.Font.SourceSans
SubTitle.TextSize = 12
SubTitle.BackgroundTransparency = 1
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- 2. Sistem Tab (Tombol Navigasi Menu)
local TabContainer = Instance.new("Frame", MainFrame)
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0.05, 0, 0.28, 0)
TabContainer.Size = UDim2.new(0.9, 0, 0, 30)

local TabSteal = Instance.new("TextButton", TabContainer)
TabSteal.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TabSteal.Size = UDim2.new(0.48, 0, 1, 0)
TabSteal.Font = Enum.Font.SourceSansBold
TabSteal.Text = "AUTO STEAL"
TabSteal.TextColor3 = Color3.fromRGB(255, 255, 255)
TabSteal.TextSize = 12
Instance.new("UICorner", TabSteal).CornerRadius = UDim.new(0, 6)

local TabEvent = Instance.new("TextButton", TabContainer)
TabEvent.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabEvent.Position = UDim2.new(0.52, 0, 0, 0)
TabEvent.Size = UDim2.new(0.48, 0, 1, 0)
TabEvent.Font = Enum.Font.SourceSansBold
TabEvent.Text = "EVENT HALLOWEEN"
TabEvent.TextColor3 = Color3.fromRGB(180, 180, 180)
TabEvent.TextSize = 11
Instance.new("UICorner", TabEvent).CornerRadius = UDim.new(0, 6)

-- 3. Container Halaman (Page Frame)
local PageSteal = Instance.new("Frame", MainFrame)
PageSteal.BackgroundTransparency = 1
PageSteal.Position = UDim2.new(0.05, 0, 0.42, 0)
PageSteal.Size = UDim2.new(0.9, 0, 0.53, 0)

local PageEvent = Instance.new("Frame", MainFrame)
PageEvent.BackgroundTransparency = 1
PageEvent.Position = UDim2.new(0.05, 0, 0.42, 0)
PageEvent.Size = UDim2.new(0.9, 0, 0.53, 0)
PageEvent.Visible = false

-- --- ISI HALAMAN 1: AUTO STEAL & FILTER & MODE ---
local FilterTextBox = Instance.new("TextBox", PageSteal)
FilterTextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
FilterTextBox.Position = UDim2.new(0, 0, 0.05, 0)
FilterTextBox.Size = UDim2.new(1, 0, 0, 30)
FilterTextBox.Font = Enum.Font.SourceSans
FilterTextBox.PlaceholderText = "Filter Telur (Cth: Gold / Halloween)"
FilterTextBox.Text = ""
FilterTextBox.TextColor3 = Color3.fromRGB(255, 255, 0)
FilterTextBox.TextSize = 12
Instance.new("UICorner", FilterTextBox).CornerRadius = UDim.new(0, 6)

local ModeBtn = Instance.new("TextButton", PageSteal)
ModeBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
ModeBtn.Position = UDim2.new(0, 0, 0.38, 0)
ModeBtn.Size = UDim2.new(1, 0, 0, 30)
ModeBtn.Font = Enum.Font.SourceSansBold
ModeBtn.Text = "MODE: NORMAL"
ModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeBtn.TextSize = 12
Instance.new("UICorner", ModeBtn).CornerRadius = UDim.new(0, 6)

local StealBtn = Instance.new("TextButton", PageSteal)
StealBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StealBtn.Position = UDim2.new(0, 0, 0.71, 0)
StealBtn.Size = UDim2.new(1, 0, 0, 35)
StealBtn.Font = Enum.Font.SourceSansBold
StealBtn.Text = "AUTO STEAL: OFF"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 13
Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 6)

-- --- ISI HALAMAN 2: AUTO EVENT HALLOWEEN ---
local HalloweenBtn = Instance.new("TextButton", PageEvent)
HalloweenBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
HalloweenBtn.Position = UDim2.new(0, 0, 0.2, 0)
HalloweenBtn.Size = UDim2.new(1, 0, 0, 45)
HalloweenBtn.Font = Enum.Font.SourceSansBold
HalloweenBtn.Text = "AUTO EVENT HALLOWEEN: OFF"
HalloweenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HalloweenBtn.TextSize = 12
Instance.new("UICorner", HalloweenBtn).CornerRadius = UDim.new(0, 6)

local HalloweenInfo = Instance.new("TextLabel", PageEvent)
HalloweenInfo.Text = "Otomatis mengumpulkan item/candy event Halloween di sekitar map."
HalloweenInfo.TextColor3 = Color3.fromRGB(170, 170, 170)
HalloweenInfo.Position = UDim2.new(0, 0, 0.6, 0)
HalloweenInfo.Size = UDim2.new(1, 0, 0, 35)
HalloweenInfo.Font = Enum.Font.SourceSans
HalloweenInfo.TextSize = 11
HalloweenInfo.BackgroundTransparency = 1
HalloweenInfo.TextWrapped = true

-- 4. Logika Perpindahan Tab
TabSteal.Activated:Connect(function()
    PageSteal.Visible = true
    PageEvent.Visible = false
    TabSteal.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabSteal.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabEvent.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabEvent.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

TabEvent.Activated:Connect(function()
    PageSteal.Visible = false
    PageEvent.Visible = true
    TabEvent.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    TabEvent.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabSteal.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TabSteal.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

-- 5. Pengaturan Filter & Mode Kecepatan
FilterTextBox.FocusLost:Connect(function()
    if FilterTextBox.Text == "" then
        selectedFilter = "ALL"
    else
        selectedFilter = string.lower(FilterTextBox.Text)
    end
end)

ModeBtn.Activated:Connect(function()
    if stealSpeedMode == "NORMAL" then
        stealSpeedMode = "INSTANT"
        ModeBtn.Text = "MODE: INSTANT"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    else
        stealSpeedMode = "NORMAL"
        ModeBtn.Text = "MODE: NORMAL"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
    end
end)

-- 6. Toggle Auto Steal (Improved Version)
StealBtn.Activated:Connect(function()
    autoStealActive = not autoStealActive
    if autoStealActive then
        StealBtn.Text = "AUTO STEAL: ON"
        StealBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        StealBtn.Text = "AUTO STEAL: OFF"
        StealBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- 7. Toggle Auto Event Halloween
HalloweenBtn.Activated:Connect(function()
    autoHalloweenActive = not autoHalloweenActive
    if autoHalloweenActive then
        HalloweenBtn.Text = "AUTO EVENT HALLOWEEN: ON"
        HalloweenBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        HalloweenBtn.Text = "AUTO EVENT HALLOWEEN: OFF"
        HalloweenBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    end
end)

-- 8. Background Loop (Auto Steal & Halloween Event Executor)
task.spawn(function()
    while true do
        if stealSpeedMode == "INSTANT" then
            task.wait(0.04)
        else
            task.wait(0.35)
        end
        
        -- Eksekusi Auto Steal Telur
        if autoStealActive then
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local parentPart = prompt.Parent
                    local partPos = parentPart and (parentPart:IsA("BasePart") and parentPart.Position or (parentPart:IsA("Model") and parentPart.PrimaryPart and parentPart.PrimaryPart.Position))
                    
                    if not root or not partPos or (root.Position - partPos).Magnitude <= 60 then
                        local action = string.lower(prompt.ActionText or "")
                        local object = string.lower(prompt.ObjectText or "")
                        local parentName = string.lower(parentPart and parentPart.Name or "")
                        
                        -- Filter anti-toko/robux
                        local isStore = action:find("beli") or action:find("buy") or action:find("toko") or action:find("shop") or object:find("gamepass")
                        
                        if not isStore then
                            local matchesFilter = false
                            if selectedFilter == "ALL" then
                                matchesFilter = true
                            else
                                if object:find(selectedFilter) or parentName:find(selectedFilter) or action:find(selectedFilter) then
                                    matchesFilter = true
                                end
                            end
                            
                            if matchesFilter then
                                prompt.HoldDuration = 0
                                if fireproximityprompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
            end
        end
        
        -- Eksekusi Auto Event Halloween (Mencari prompt/item bertuliskan halloween/candy/pumpkin)
        if autoHalloweenActive then
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local action = string.lower(prompt.ActionText or "")
                    local object = string.lower(prompt.ObjectText or "")
                    local parentName = string.lower(prompt.Parent and prompt.Parent.Name or "")
                    
                    if object:find("halloween") or object:find("candy") or object:find("pumpkin") or object:find("labu") or 
                       parentName:find("halloween") or parentName:find("candy") or parentName:find("pumpkin") or parentName:find("labu") or
                       action:find("collect") or action:find("ambil") then
                        prompt.HoldDuration = 0
                        if fireproximityprompt then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end
    end
end)
