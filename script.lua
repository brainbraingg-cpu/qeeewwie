-- =========================================================
-- QEEEWWIE HUB: DIRECT EXECUTE TESTER
-- =========================================================

if game:GetService("CoreGui"):FindFirstChild("QeeewwieHubUI") then
    game:GetService("CoreGui").QeeewwieHubUI:Destroy()
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "QeeewwieHubUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "QEEEWWIE TESTER"
Title.TextColor3 = Color3.fromRGB(255, 150, 200)
Title.Position = UDim2.new(0.08, 0, 0.08, 0)
Title.Size = UDim2.new(0.85, 0, 0, 25)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local ScanBtn = Instance.new("TextButton", MainFrame)
ScanBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ScanBtn.Position = UDim2.new(0.08, 0, 0.3, 0)
ScanBtn.Size = UDim2.new(0.84, 0, 0, 35)
ScanBtn.Font = Enum.Font.SourceSansBold
ScanBtn.Text = "SCAN OBJEK SEKARANG"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 6)

local ResultLabel = Instance.new("TextLabel", MainFrame)
ResultLabel.Text = "Tekan tombol di atas dekat telur..."
ResultLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
ResultLabel.Position = UDim2.new(0.08, 0, 0.6, 0)
ResultLabel.Size = UDim2.new(0.84, 0, 0, 70)
ResultLabel.Font = Enum.Font.SourceSans
ResultLabel.TextSize = 11
ResultLabel.BackgroundTransparency = 1
ResultLabel.TextWrapped = true
ResultLabel.TextYAlignment = Enum.TextYAlignment.Top

ScanBtn.Activated:Connect(function()
    ResultLabel.Text = "Mencari objek..."
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not root then
        ResultLabel.Text = "Karakter tidak ditemukan!"
        return
    end

    local foundName = "Tidak ada objek terdeteksi"
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local pos = obj:IsA("BasePart") and obj.Position or (obj.PrimaryPart and obj.PrimaryPart.Position)
            if pos and (root.Position - pos).Magnitude <= 20 then
                local nameLower = string.lower(obj.Name)
                if nameLower:find("egg") or nameLower:find("telur") or nameLower:find("cherub") or nameLower:find("box") then
                    foundName = "Ketemu: " .. obj.Name
                    break
                end
            end
        end
    end
    ResultLabel.Text = foundName
end)
