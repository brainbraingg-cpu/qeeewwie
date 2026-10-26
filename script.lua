-- =========================================================
-- QEEEWWIE HUB: MASSIVE OVERHAUL UPDATE [SC EDITION]
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Bersihkan UI lama
pcall(function()
    if PlayerGui:FindFirstChild("QeeewwieHubUI") then PlayerGui.QeeewwieHubUI:Destroy() end
    if CoreGui:FindFirstChild("QeeewwieHubUI") then CoreGui.QeeewwieHubUI:Destroy() end
end)

local Config = {
    AutoFarmActive = false,
    StealMode = "Instant", -- Pilihan: "Instant" atau "Fly"
    MoveMode = "TP",       -- Pilihan: "TP" atau "Walk"
    EggEspActive = false,
    PetAntiClip = true,
    HalloweenEvent = true,
    YinYangEvent = true,
    MultiSpeed = 50,
    NormalWalkSpeed = 16
}

local startingBaseCFrame = nil
local collectedEggsMemory = {}
local espFolder = Instance.new("Folder", Workspace)
espFolder.Name = "QeeewwieESP_Container"

-- UI Container Setup
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

-- Floating Button
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

-- Main Frame (Diperbesar untuk menu update gede)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -140, 0.2, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 100, 185)
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB [MASSIVE UPDATE]"
Title.TextColor3 = Color3.fromRGB(255, 100, 185)
Title.Position = UDim2.new(0.05, 0, 0.03, 0)
Title.Size = UDim2.new(0.75, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.82, 0, 0.03, 0)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

-- Tombol-Tombol Fitur Utama
local function createButton(name, posY, color)
    local btn = Instance.new("TextButton", MainFrame)
    btn.BackgroundColor3 = color
    btn.Position = UDim2.new(0.08, 0, posY, 0)
    btn.Size = UDim2.new(0.84, 0, 0, 36)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local AutoFarmBtn = createButton("AUTO STEAL FARM: OFF", 0.12, Color3.fromRGB(180, 40, 100))
local StealModeBtn = createButton("STEAL MODE: INSTANT", 0.23, Color3.fromRGB(50, 100, 200))
local MoveModeBtn = createButton("MOVE MODE: TP", 0.34, Color3.fromRGB(100, 50, 200))
local EspBtn = createButton("EGG ESP: OFF", 0.45, Color3.fromRGB(50, 150, 150))
local AntiClipBtn = createButton("PET ANTI-CLIP: ON", 0.56, Color3.fromRGB(150, 100, 50))
local HalloweenBtn = createButton("EVENT HALLOWEEN: ON", 0.67, Color3.fromRGB(200, 100, 0))
local YinYangBtn = createButton("EVENT YIN-YANG STONE: ON", 0.78, Color3.fromRGB(80, 80, 80))

-- UI Event Handlers
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() espFolder:Destroy() end)
FloatingBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; FloatingBtn.Visible = false end)

AutoFarmBtn.MouseButton1Click:Connect(function()
    Config.AutoFarmActive = not Config.AutoFarmActive
    AutoFarmBtn.Text = Config.AutoFarmActive and "AUTO STEAL FARM: ON" or "AUTO STEAL FARM: OFF"
    AutoFarmBtn.BackgroundColor3 = Config.AutoFarmActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(180, 40, 100)
    if Config.AutoFarmActive then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then startingBaseCFrame = root.CFrame end
    else
        table.clear(collectedEggsMemory)
    end
end)

StealModeBtn.MouseButton1Click:Connect(function()
    if Config.StealMode == "Instant" then
        Config.StealMode = "Fly"
        StealModeBtn.Text = "STEAL MODE: FLY"
    else
        Config.StealMode = "Instant"
        StealModeBtn.Text = "STEAL MODE: INSTANT"
    end
end)

MoveModeBtn.MouseButton1Click:Connect(function()
    if Config.MoveMode == "TP" then
        Config.MoveMode = "Walk"
        MoveModeBtn.Text = "MOVE MODE: MULTI SPEED"
    else
        Config.MoveMode = "TP"
        MoveModeBtn.Text = "MOVE MODE: TP"
    end
end)

EspBtn.MouseButton1Click:Connect(function()
    Config.EggEspActive = not Config.EggEspActive
    EspBtn.Text = Config.EggEspActive and "EGG ESP: ON" or "EGG ESP: OFF"
    EspBtn.BackgroundColor3 = Config.EggEspActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 150, 150)
    if not Config.EggEspActive then espFolder:ClearAllChildren() end
end)

AntiClipBtn.MouseButton1Click:Connect(function()
    Config.PetAntiClip = not Config.PetAntiClip
    AntiClipBtn.Text = Config.PetAntiClip and "PET ANTI-CLIP: ON" or "PET ANTI-CLIP: OFF"
    AntiClipBtn.BackgroundColor3 = Config.PetAntiClip and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(150, 100, 50)
end)

HalloweenBtn.MouseButton1Click:Connect(function()
    Config.HalloweenEvent = not Config.HalloweenEvent
    HalloweenBtn.Text = Config.HalloweenEvent and "EVENT HALLOWEEN: ON" or "EVENT HALLOWEEN: OFF"
end)

YinYangBtn.MouseButton1Click:Connect(function()
    Config.YinYangEvent = not Config.YinYangEvent
    YinYangBtn.Text = Config.YinYangEvent and "EVENT YIN-YANG STONE: ON" or "EVENT YIN-YANG STONE: OFF"
end)

-- Utility Functions
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

local function isValidTarget(prompt, parentPart)
    if collectedEggsMemory[prompt] then return false end
    local nameStr = string.lower(parentPart.Name .. " " .. (prompt.ActionText or "") .. " " .. (prompt.ObjectText or ""))
    
    -- Filter Event Halloween / Yin-Yang / Telur Biasa
    local isEgg = nameStr:find("egg") or nameStr:find("telur")
    local isHalloween = Config.HalloweenEvent and (nameStr:find("halloween") or nameStr:find("pumpkin") or nameStr:find("hallow"))
    local isYinYang = Config.YinYangEvent and (nameStr:find("yin") or nameStr:find("yang") or nameStr:find("batu") or nameStr:find("stone"))
    
    if isEgg or isHalloween or isYinYang then
        if not nameStr:find("robux") and not nameStr:find("shop") and not nameStr:find("toko") then
            return true
        end
    end
    return false
end

-- ESP SYSTEM UPDATE
RunService.RenderStepped:Connect(function()
    if Config.EggEspActive then
        pcall(function()
            for _, child in pairs(espFolder:GetChildren()) do child:Destroy() end
            for _, prompt in pairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("BasePart") then
                    if isValidTarget(prompt, prompt.Parent) then
                        local part = prompt.Parent
                        local bill = Instance.new("BillboardGui", espFolder)
                        bill.Size = UDim2.new(0, 50, 0, 25)
                        bill.AlwaysOnTop = true
                        bill.Adornee = part
                        
                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = "🎯 TARGET"
                        txt.TextColor3 = Color3.fromRGB(255, 255, 0)
                        txt.TextSize = 12
                        txt.Font = Enum.Font.GothamBold
                    end
                end
            end
        end)
    end
    
    -- PET & HEWAN ANTI-CLIP
    if Config.PetAntiClip then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                for _, obj in pairs(char:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                        obj.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- MESIN UTAMA AUTO STEAL & EVENT FARM
task.spawn(function()
    while true do
        task.wait(0.2)
        if Config.AutoFarmActive then
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if not root or not humanoid then return end
                
                if not startingBaseCFrame then startingBaseCFrame = root.CFrame end
                
                local targets = {}
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if not Config.AutoFarmActive then break end
                    if prompt:IsA("ProximityPrompt") then
                        local parentPart = prompt.Parent
                        if parentPart and parentPart:IsA("BasePart") then
                            if isValidTarget(prompt, parentPart) then
                                table.insert(targets, {prompt = prompt, part = parentPart})
                            end
                        end
                    end
                end
                
                if #targets > 0 then
                    local target = targets[1]
                    if target and target.part and target.prompt and Config.AutoFarmActive then
                        collectedEggsMemory[target.prompt] = true
                        
                        -- STEAL MODE: FLY vs INSTANT
                        if Config.StealMode == "Fly" then
                            -- Simulasi terbang mulus ke target
                            local steps = 10
                            local currentPos = root.CFrame
                            for i = 1, steps do
                                if not Config.AutoFarmActive then break end
                                root.CFrame = currentPos:Lerp(target.part.CFrame + Vector3.new(0, 3.5, 0), i / steps)
                                task.wait(0.02)
                            end
                        else
                            -- INSTANT TP MODE
                            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            root.CFrame = target.part.CFrame + Vector3.new(0, 3.5, 0)
                            task.wait(0.2)
                        end
                        
                        -- Eksekusi Pengambilan (Steal)
                        pcall(function()
                            target.prompt.HoldDuration = 0
                            if fireproximityprompt then fireproximityprompt(target.prompt) end
                            target.prompt:InputHoldBegin()
                            task.wait(0.05)
                            target.prompt:InputHoldEnd()
                        end)
                        task.wait(0.15)
                        
                        -- Pindah ke Fusion Atas
                        local fusionPos = findNearestFusion(root.Position)
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        root.CFrame = CFrame.new(fusionPos)
                        task.wait(0.2)
                        
                        -- MOVE MODE: TP vs MULTI SPEED
                        if startingBaseCFrame and Config.AutoFarmActive then
                            if Config.MoveMode == "TP" then
                                root.CFrame = startingBaseCFrame
                            else
                                humanoid.WalkSpeed = Config.MultiSpeed
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
