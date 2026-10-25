-- =========================================================
-- QEEEWWIE HUB: ULTRA LIGHTWEIGHT & STABLE
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("QeeewwieHubUI") then
    PlayerGui.QeeewwieHubUI:Destroy()
end

local instantGrabActive = false
local autoStealActive = false
local espEggActive = false

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE HUB: LITE"
Title.TextColor3 = Color3.fromRGB(255, 100, 180)
Title.Position = UDim2.new(0.05, 0, 0.05, 0)
Title.Size = UDim2.new(0.8, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.82, 0, 0.05, 0)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function createToggle(name, posY, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    btn.Position = UDim2.new(0.08, 0, posY, 0)
    btn.Size = UDim2.new(0.84, 0, 0, 32)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and ": ON" or ": OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(50, 50, 65)
        callback(state)
    end)
end

createToggle("INSTANT GRAB EGG", 0.22, function(v) instantGrabActive = v end)
createToggle("AUTO STEAL EGG", 0.44, function(v) autoStealActive = v end)
createToggle("ESP EGG HIGHLIGHT", 0.66, function(v) 
    espEggActive = v 
    if not v then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "QeeewwieESP" or obj.Name == "QeeewwieTag" then obj:Destroy() end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            if instantGrabActive or autoStealActive or espEggActive then
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        local parent = prompt.Parent
                        local fullStr = string.lower((parent and parent.Name or "") .. " " .. (parent and parent.Parent and parent.Parent.Name or ""))
                        local promptText = string.lower(prompt.ActionText .. " " .. prompt.ObjectText)
                        
                        if fullStr:find("egg") or fullStr:find("telur") or fullStr:find("blackhole") or fullStr:find("solaris") then
                            local isRanch = fullStr:find("ranch") or fullStr:find("'s") or fullStr:find("base")
                            local isRestricted = promptText:find("robux") or promptText:find("buy") or promptText:find("purchase")
                            
                            if not isRestricted then
                                if espEggActive and parent and not parent:FindFirstChild("QeeewwieESP") then
                                    local hl = Instance.new("Highlight", parent)
                                    hl.Name = "QeeewwieESP"
                                    hl.FillColor = fullStr:find("blackhole") and Color3.fromRGB(150, 0, 255) or Color3.fromRGB(255, 200, 0)
                                end
                                
                                local canExec = (instantGrabActive and not isRanch) or (autoStealActive and isRanch)
                                if canExec then
                                    prompt.HoldDuration = 0
                                    if fireproximityprompt then fireproximityprompt(prompt) end
                                end
                            end
                        end
                    end
                end
            end
        end)
            
