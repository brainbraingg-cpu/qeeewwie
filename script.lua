-- =========================================================
-- QEEEWWIE HUB: FIXED DIAGNOSTIC & SCANNER MODE
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Membuat UI Scanner
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE SCANNER"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.08, 0)
Title.Size = UDim2.new(0.85, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.BackgroundTransparency = 1

local ScanBtn = Instance.new("TextButton", MainFrame)
ScanBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ScanBtn.Position = UDim2.new(0.08, 0, 0.35, 0)
ScanBtn.Size = UDim2.new(0.84, 0, 0, 40)
ScanBtn.Font = Enum.Font.SourceSansBold
ScanBtn.Text = "KLIK UNTUK SCAN OBJEK"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 6)

local InfoLabel = Instance.new("TextLabel", MainFrame)
InfoLabel.Text = "Cek Console executor setelah diklik!"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.Position = UDim2.new(0.08, 0, 0.75, 0)
InfoLabel.Size = UDim2.new(0.84, 0, 0, 25)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.TextSize = 11
InfoLabel.BackgroundTransparency = 1

-- Tombol Aksi Scan yang sudah diperbaiki
ScanBtn.Activated:Connect(function()
    print("===== MULAI SCANNING OBJEK DI SEKITAR =====")
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not root then
        print("Karakter tidak ditemukan!")
        return
    end

    local promptCount = 0
    
    -- 1. Scan ProximityPrompt di sekitar player (radius 60 meter)
    for _, prompt in pairs(Workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local parent = prompt.Parent
            local pos = parent and (parent:IsA("BasePart") and parent.Position or (parent:IsA("Model") and parent.PrimaryPart and parent.PrimaryPart.Position))
            if pos and (root.Position - pos).Magnitude <= 60 then
                promptCount = promptCount + 1
                print("[PROMPT] Action: " .. tostring(prompt.ActionText) .. " | Object: " .. tostring(prompt.ObjectText) .. " | Parent: " .. tostring(parent.Name))
            end
        end
    end

    -- 2. Scan Model/Part untuk mendeteksi telur, koin, atau item game
    local itemCounts = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local nameLower = string.lower(obj.Name)
            local pos = obj:IsA("BasePart") and obj.Position or (obj.PrimaryPart and obj.PrimaryPart.Position)
            if pos and (root.Position - pos).Magnitude <= 40 then
                if nameLower:find("egg") or nameLower:find("telur") or nameLower:find("coin") or nameLower:find("gem") or nameLower:find("box") or nameLower:find("farm") then
                    itemCounts = itemCounts + 1
                    print("[OBJEK MAP] Nama: " .. obj.Name .. " | Tipe: " .. obj.ClassName)
                end
            end
        end
    end
    
    print("===== SELESAI SCAN (" .. promptCount .. " Prompt, " .. itemCounts .. " Objek ditemukan) =====")
    ScanBtn.Text = "SELESAI! CEK CONSOLE"
    task.wait(2)
    ScanBtn.Text = "KLIK UNTUK SCAN OBJEK"
end)
