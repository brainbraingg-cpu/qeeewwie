-- =========================================================
-- QEEEWWIE HUB: RIDE PET + AUTO STEAL + FILTER + INSTANT/NORMAL
-- =========================================================

-- Hapus UI lama jika ada
if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Variabel Pengaturan
local autoStealActive = false
local selectedFilter = "ALL"
local stealSpeedMode = "NORMAL"

-- 1. Membuat Menu Utama di Layar
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 190, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.BackgroundTransparency = 1

-- Tombol 1: Ride Pet
local RideBtn = Instance.new("TextButton", MainFrame)
RideBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
RideBtn.Position = UDim2.new(0.1, 0, 0.18, 0)
RideBtn.Size = UDim2.new(0.8, 0, 0, 28)
RideBtn.Font = Enum.Font.SourceSansBold
RideBtn.Text = "RIDE PET"
RideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RideBtn.TextSize = 12
Instance.new("UICorner", RideBtn).CornerRadius = UDim.new(0, 6)

-- Input Box: Egg Filter
local FilterTextBox = Instance.new("TextBox", MainFrame)
FilterTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
FilterTextBox.Position = UDim2.new(0.1, 0, 0.35, 0)
FilterTextBox.Size = UDim2.new(0.8, 0, 0, 28)
FilterTextBox.Font = Enum.Font.SourceSans
FilterTextBox.PlaceholderText = "Filter (kosong = semua)"
FilterTextBox.Text = ""
FilterTextBox.TextColor3 = Color3.fromRGB(255, 255, 0)
FilterTextBox.TextSize = 11
Instance.new("UICorner", FilterTextBox).CornerRadius = UDim.new(0, 6)

-- Tombol 2: Mode Instant / Normal
local ModeBtn = Instance.new("TextButton", MainFrame)
ModeBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
ModeBtn.Position = UDim2.new(0.1, 0, 0.52, 0)
ModeBtn.Size = UDim2.new(0.8, 0, 0, 28)
ModeBtn.Font = Enum.Font.SourceSansBold
ModeBtn.Text = "MODE: NORMAL"
ModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeBtn.TextSize = 12
Instance.new("UICorner", ModeBtn).CornerRadius = UDim.new(0, 6)

-- Tombol 3: Steal Egg (Toggle ON/OFF)
local StealBtn = Instance.new("TextButton", MainFrame)
StealBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StealBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
StealBtn.Size = UDim2.new(0.8, 0, 0, 35)
StealBtn.Font = Enum.Font.SourceSansBold
StealBtn.Text = "AUTO STEAL: OFF"
StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StealBtn.TextSize = 13
Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 6)

-----------------------------------------------------------
-- 2. SETUP FILTER & MODE
-----------------------------------------------------------
FilterTextBox.FocusLost:Connect(function()
    if FilterTextBox.Text == "" then
        selectedFilter = "ALL"
    else
        selectedFilter = string.lower(FilterTextBox.Text)
    end
end)

ModeBtn.MouseButton1Click:Connect(function()
    if stealSpeedMode == "NORMAL" then
        stealSpeedMode = "INSTANT"
        ModeBtn.Text = "MODE: INSTANT"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    else
        stealSpeedMode = "NORMAL"
        ModeBtn.Text = "MODE: NORMAL"
        ModeBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
    end
end)

-----------------------------------------------------------
-- 3. FITUR RIDE PET
-----------------------------------------------------------
RideBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart

    local foundPet = nil
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.lower(obj.Name):find("pet") or string.lower(obj.Name):find(string.lower(LocalPlayer.Name))) then
            foundPet = obj
            break
        end
    end

    if foundPet then
        local petPart = foundPet.PrimaryPart or foundPet:FindFirstChildWhichIsA("BasePart")
        if petPart then
            root.CFrame = petPart.CFrame + Vector3.new(0, 3, 0)
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = root
            weld.Part1 = petPart
            weld.Parent = root
            RideBtn.Text = "TERTEMPEL!"
            task.wait(1)
            RideBtn.Text = "RIDE PET"
        end
    else
        RideBtn.Text = "PET TIDAK ADA"
        task.wait(1)
        RideBtn.Text = "RIDE PET"
    end
end)

-----------------------------------------------------------
-- 4. FITUR AUTO STEAL (DENGAN FILTER & SPEED)
-----------------------------------------------------------
StealBtn.MouseButton1Click:Connect(function()
    autoStealActive = not autoStealActive

    if autoStealActive then
        StealBtn.Text = "AUTO STEAL: ON"
        StealBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        StealBtn.Text = "AUTO STEAL: OFF"
        StealBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- Loop Auto Steal
task.spawn(function()
    while true do
        if stealSpeedMode == "INSTANT" then
            task.wait(0.05)
        else
            task.wait(0.4)
        end
        
        if autoStealActive then
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                    local action = string.lower(prompt.ActionText or "")
                    local object = string.lower(prompt.ObjectText or "")
                    local parentName = string.lower(prompt.Parent and prompt.Parent.Name or "")
                    
                    local isStore = action:find("beli") or action:find("buy") or action:find("toko") or action:find("shop")
                    local isSteal = action:find("curi") or action:find("mencuri") or action:find("steal") or action:find("take")
                    
                    if isSteal and not isStore then
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
end)
