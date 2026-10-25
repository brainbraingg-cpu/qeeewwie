-- =========================================================
-- QEEEWWIE HUB: ON-SCREEN VISUAL SCANNER
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Membuat UI Scanner dengan Teks Layar
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE VISUAL SCANNER"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.05, 0)
Title.Size = UDim2.new(0.85, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize:ge = 13
Title.BackgroundTransparency = 1

local ScanBtn = Instance.new("TextButton", MainFrame)
ScanBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ScanBtn.Position = UDim2.new(0.08, 0, 0.22, 0)
ScanBtn.Size = UDim2.new(0.84, 0, 0, 35)
ScanBtn.Font = Enum.Font.SourceSansBold
ScanBtn.Text = "SCAN OBJEK SEKARANG"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 6)

-- Kotak Hasil Scan di Layar
local ResultLabel = Instance.new("TextLabel", MainFrame)
ResultLabel.Text = "Hasil scan akan muncul di sini..."
ResultLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
ResultLabel.Position = UDim2.new(0.08, 0, 0.62, 0)
ResultLabel.Size = UDim2.new(0.84, 0, 0, 75)
ResultLabel.Font = Enum.Font.SourceSans
ResultLabel.TextSize = 11
ResultLabel.BackgroundTransparency = 1
ResultLabel.TextWrapped = true
ResultLabel.TextYAlignment = Enum.TextYAlignment.Top

-- Tombol Aksi Scan
ScanBtn.Activated:Connect(function()
    ResultLabel.Text = "Mencari objek di sekitar..."
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not root then
        ResultLabel.Text = "Error: Karakter tidak ada!"
        return
    end

    local foundName = "Tidak ada objek terdeteksi"
    
    -- Cek ProximityPrompt di sekitar player (radius 50 meter)
    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local parent = prompt.Parent
            local pos = parent and (parent:IsA("BasePart") and parent.Position or (parent:IsA("Model") and parent.PrimaryPart and parent.PrimaryPart.Position))
            if pos and (root.Position - pos).Magnitude <= 50 then
                foundName = "Prompt: " .. tostring(prompt.ObjectText) .. " | " .. tostring(prompt.ActionText)
                break
            end
        end
    end
    
    -- Jika tidak ada prompt, cek Part/Model terdekat
    if foundName == "Tidak ada objek terdeteksi" then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local pos = obj:IsA("BasePart") and obj.Position or (obj.PrimaryPart and obj.PrimaryPart.Position)
                if pos and (root.Position - pos).Magnitude <= 20 then
                    local nameLower = string.lower(obj.Name)
                    if nameLower:find("egg") or nameLower:find("telur") or nameLower:find("coin") or nameLower:find("box") or nameLower:find("store") then
                        foundName = "Objek: " .. obj.Name
                        break
                    end
                end
            end
        end
    end

    ResultLabel.Text = foundName
end)
