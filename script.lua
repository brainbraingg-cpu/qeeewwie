-- ==========================================
-- Qeeewwie Hub v7 (Inspired by Sena Hub Style)
-- Game: Steal an Egg
-- Executor: Arceus X / Delta / Mobile
-- ==========================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Hapus UI lama jika ada agar tidak numpuk
if CoreGui:FindFirstChild("QeeewwieHubV7") then
    CoreGui.QeeewwieHubV7:Destroy()
end

-- Membuat ScreenGui Utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwieHubV7"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Tombol Mengambang (Floating Logo) untuk Buka/Tutup Menu di HP
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.Size = UDim2.new(0, 110, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Qeeewwie v7"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.TextSize = 13
ToggleBtn.Active = true
ToggleBtn.Draggable = true -- Bisa digeser pakai jempol

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- Main Window (Menu Utama ala Hub Premium)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.Size = UDim2.new(0, 350, 0, 260)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Top Bar / Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.Size = UDim2.new(1, 0, 0, 35)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Qeeewwie Hub v7 | Steal an Egg"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13

-- Tombol Close (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Header
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -30, 0, 7)
CloseButton.Size = UDim2.new(0, 21, 0, 21)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 11

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Container Menu (Isi Fitur)
local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 10, 0, 45)
Container.Size = UDim2.new(1, -20, 1, -55)
Container.CanvasSize = UDim2.new(0, 0, 0, 300)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Fungsi Toggle Buka Tutup Menu
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

---------------------------------------------------------
-- FUNGSI PEMBUAT TOMBOL FITUR (UI Components)
---------------------------------------------------------
local function createToggle(name, callback)
    D_Btn = Instance.new("TextButton")
    D_Btn.Parent = Container
    D_Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    D_Btn.Size = UDim2.new(1, 0, 0, 40)
    D_Btn.Font = Enum.Font.GothamBold
    D_Btn.Text = name .. ": OFF"
    D_Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    D_Btn.TextSize = 13
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = D_Btn
    
    local toggled = false
    D_Btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            D_Btn.Text = name .. ": ON"
            D_Btn.TextColor3 = Color3.fromRGB(0, 255, 128)
            D_Btn.BackgroundColor3 = Color3.fromRGB(20, 60, 40)
        else
            D_Btn.Text = name .. ": OFF"
            D_Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            D_Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
        end
        callback(toggled)
    end)
end

---------------------------------------------------------
-- FITUR-FITUR UTAMA (STEAL AN EGG)
---------------------------------------------------------

local autoStealActive = false
local instantCollectActive = false

-- 1. Fitur Auto Steal (Metode Diam + Delay 1 Detik Sesuai Permintaanmu)
createToggle("Auto Steal (Safe Delay)", function(state)
    autoStealActive = state
    
    if autoStealActive then
        task.spawn(function()
            while autoStealActive do
                task.wait(1)
                pcall(function()
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = char:WaitForChild("HumanoidRootPart")
                    local initialPos = rootPart.CFrame
                    
                    local eggsFolder = Workspace:FindFirstChild("Eggs")
                    if eggsFolder then
                        for _, egg in ipairs(eggsFolder:GetChildren()) do
                            if not autoStealActive then break end
                            
                            local targetPart = egg:IsA("BasePart") and egg or (egg:IsA("Model") and (egg.PrimaryPart or egg:FindFirstChildWhichIsA("BasePart")))
                            
                            if targetPart then
                                -- Teleport ke telur
                                rootPart.CFrame = targetPart.CFrame
                                -- Diam selama 1 detik biar nggak ke-detect anti-cheat
                                task.wait(1.0)
                                
                                if firetouchinterest then
                                    firetouchinterest(rootPart, targetPart, 0)
                                    firetouchinterest(rootPart, targetPart, 1)
                                end
                                
                                -- Balik ke posisi aman semula
                                rootPart.CFrame = initialPos
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- 2. Fitur Tambahan (Contoh: Anti AFK Biar Bisa Ditinggal Treo/Farm)
createToggle("Anti-AFK Bypass", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        print("[Qeeewwie v7] Anti-AFK Aktif!")
    end
end)

print("[Qeeewwie Hub v7] Berhasil dimuat dengan gaya Sena Hub!")
