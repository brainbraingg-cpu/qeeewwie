-- =========================================================
-- QEEEWWIE HUB: FORCE VISIBLE UI EDITION [SC]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Pastikan PlayerGui siap
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihkan UI lama jika ada
pcall(function()
    if PlayerGui:FindFirstChild("QeeewwieHubUI") then PlayerGui.QeeewwieHubUI:Destroy() end
    if CoreGui:FindFirstChild("QeeewwieHubUI") then CoreGui.QeeewwieHubUI:Destroy() end
end)

local Config = {
    AutoFarmActive = false,
    SpeedBoostActive = false,
    AntiClipActive = false,
    CustomWalkSpeed = 95,
    NormalWalkSpeed = 16
}

local startingBaseCFrame = nil
local collectedEggsMemory = {}

-- 1. PEMBUATAN CONTAINER UI
local ParentTarget = PlayerGui
pcall(function()
    if gethui then ParentTarget = gethui()
    elseif CoreGui then ParentTarget = CoreGui end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = ParentTarget

-- Floating Button (Tombol Bulat SC)
local FloatingBtn = Instance.new("TextButton", ScreenGui)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
FloatingBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "SC"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 100, 185)
FloatingBtn.TextSize = 20
FloatingBtn.Visible = false
FloatingBtn.Active = true
FloatingBtn.Draggable = true
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

-- Main Frame (Tabel Utama di Tengah Layar)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -120, 0.25, 0) -- Posisi Tengah Presisi
MainFrame.Size = UDim2.new(0, 240, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 100, 185)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB [SC]"
Title.TextColor3 = Color3.fromRGB(255, 100, 185)
Title.Position = UDim2.new(0.05, 0, 0.04, 0)
Title.Size = UDim2.new(0.70, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.80, 0, 0.04, 0)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local AutoFarmBtn = Instance.new("TextButton", MainFrame)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 100)
AutoFarmBtn.Position = UDim2.new(0.08, 0, 0.22, 0)
AutoFarmBtn.Size = UDim2.new(0.84, 0, 0, 42)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.Text = "AUTO FARM: OFF"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 13
Instance.new("UICorner", AutoFarmBtn).CornerRadius = UDim.new(0, 6)

local SpeedBtn = Instance.new("TextButton", MainFrame)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SpeedBtn.Position = UDim2.new(0.08, 0, 0.45, 0)
SpeedBtn.Size = UDim2.new(0.84, 0, 0, 42)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "SPEED BOOST: OFF"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 13
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

local AntiClipBtn = Instance.new("TextButton", MainFrame)
AntiClipBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
AntiClipBtn.Position = UDim2.new(0.08, 0, 0.68, 0)
AntiClipBtn.Size = UDim2.new(0.84, 0, 0, 42)
AntiClipBtn.Font = Enum.Font.SourceSansBold
AntiClipBtn.Text = "ANTI CLIP: OFF"
AntiClipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiClipBtn.TextSize = 13
Instance.new("UICorner", AntiClipBtn).CornerRadius = UDim.new(0, 6)

-- 2. EVENT TOMBOL
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
FloatingBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; FloatingBtn.Visible = false end)

AutoFarmBtn.MouseButton1Click:Connect(function()
    Config.AutoFarmActive = not Config.AutoFarmActive
    AutoFarmBtn.Text = Config.AutoFarmActive and "AUTO FARM: ON" or "AUTO FARM: OFF"
    AutoFarmBtn.BackgroundColor3 = Config.AutoFarmActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(180, 40, 100)
    if Config.AutoFarmActive then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then startingBaseCFrame = root.CFrame end
    else
        table.clear(collectedEggsMemory)
    end
end)

SpeedBtn.MouseButton1Click:Connect(function()
    Config.SpeedBoostActive = not Config.SpeedBoostActive
    SpeedBtn.Text = Config.SpeedBoostActive and "SPEED BOOST: ON" or "SPEED BOOST: OFF"
    SpeedBtn.BackgroundColor3 = Config.SpeedBoostActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 255)
end)

AntiClipBtn.MouseButton1Click:Connect(function()
    Config.AntiClipActive = not Config.AntiClipActive
    AntiClipBtn.Text = Config.AntiClipActive and "ANTI CLIP: ON" or "ANTI CLIP: OFF"
    AntiClipBtn.BackgroundColor3 = Config.AntiClipActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(150, 100, 50)
end)

-- 3. FUNGSI UTILITY
local function findNearestFusion(currentPos)
    local nearestPos = currentPos + Vector3.new(0, 75, 0)
    local shortestDist = math.huge
    pcall(function()
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (string.lower(obj.Name):find("fusion") or string.lower(obj.Name):find("fuse")) then
                local dist = (obj.Position - currentPos).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    nearestPos = obj.Position + Vector3.new(0, 10, 0)
                end
            end
        end
    end)
    return nearestPos
end

-- 4. PLAYER MODS
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and Config.SpeedBoostActive then
        humanoid.WalkSpeed = Config.CustomWalkSpeed
    end
    if Config.AntiClipActive then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 5. AUTO FARM ENGINE
task.spawn(function()
    while true do
        task.wait(0.3)
        if Config.AutoFarmActive then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not root or not humanoid then return end
                
                if not startingBaseCFrame then startingBaseCFrame = root.CFrame end
                
                local availableEggs = {}
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not Config.AutoFarmActive then break end
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        if parentPart and parentPart:IsA("BasePart") then
                            if not collectedEggsMemory[prompt] then
                                local nameStr = string.lower(parentPart.Name .. " " .. (prompt.ActionText or ""))
                                if nameStr:find("egg") or nameStr:find("telur") then
                                    table.insert(availableEggs, {prompt = prompt, part = parentPart})
                                end
                            end
                        end
                    end
                end
                
                if #availableEggs > 0 then
                    local target = availableEggs[1]
                    if target and target.part and target.prompt and Config.AutoFarmActive then
                        collectedEggsMemory[target.prompt] = true
                        
                        root.CFrame = target.part.CFrame + Vector3.new(0, 3.5, 0)
                        task.wait(0.3)
                        
                        pcall(function()
                            target.prompt.HoldDuration = 0
                            if fireproximityprompt then fireproximityprompt(target.prompt) end
                            target.prompt:InputHoldBegin()
                            task.wait(0.05)
                            target.prompt:InputHoldEnd()
                        end)
                        task.wait(0.15)
                        
                        local fusionPos = findNearestFusion(root.Position)
                        root.CFrame = CFrame.new(fusionPos)
                        task.wait(0.2)
                        
                        if startingBaseCFrame and Config.AutoFarmActive then
                            humanoid.WalkSpeed = Config.CustomWalkSpeed
                            humanoid:MoveTo(startingBaseCFrame.Position)
                            local startTime = tick()
                            repeat
                                task.wait(0.1)
                                if not Config.AutoFarmActive then break end
                                if (tick() - startTime) > 2.5 then
                                    root.CFrame = startingBaseCFrame
                                    break
                                end
                            until (root.Position - startingBaseCFrame.Position).Magnitude < 6
                        end
                        humanoid.WalkSpeed = Config.NormalWalkSpeed
                    end
                else
                    table.clear(collectedEggsMemory)
                    task.wait(0.5)
                end
            end)
        end
    end
end)
