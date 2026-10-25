
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Bersihkan GUI lama jika ada
if playerGui:FindFirstChild("QeeewwiePanel") then
 playerGui.QeeewwiePanel:Destroy()
end

-- Buat ScreenGui utama
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QeeewwiePanel"
ScreenGui.Parent = playerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Panel utama dengan sudut melengkung dan bayangan
local MainPanel = Instance.new("Frame")
MainPanel.Size = UDim2.fromOffset(420, 480)
MainPanel.Position = UDim2.new(0.02, 0, 0.5, -240)
MainPanel.BackgroundColor3 = Color3.fromHex("#121217")
MainPanel.CornerRadius = UDim.new(0, 16)
MainPanel.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainPanel

local UIShadow = Instance.new("UIGradient")
UIShadow.Rotation = 90
UIShadow.Transparency = NumberSequence.new{0, 0.1}
UIShadow.Parent = MainPanel

-- Header yang bisa digeser
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = Color3.fromHex("#1a1a21")
Header.CornerRadius = UDim.new(0, 16)
Header.Parent = MainPanel
Header.Active = true
Header.Draggable = true

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.fromOffset(20, 0)
Title.BackgroundTransparency = 1
Title.Text = "qeeewwie • Control Panel"
Title.TextColor3 = Color3.fromHex("#e2e8f0")
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = Header

-- Tombol minimize
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.fromOffset(32, 32)
MinimizeBtn.Position = UDim2.new(1, -44, 0.5, -16)
MinimizeBtn.BackgroundColor3 = Color3.fromHex("#27272f")
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = Header

Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 8)

-- Bar status FPS & Waktu
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, -32, 0, 28)
StatusBar.Position = UDim2.fromOffset(16, 64)
StatusBar.BackgroundColor3 = Color3.fromHex("#1a1a21")
StatusBar.CornerRadius = UDim.new(0, 8)
StatusBar.Parent = MainPanel

Instance.new("UICorner", StatusBar).CornerRadius = UDim.new(0, 8)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.TextColor3 = Color3.fromHex("#94a3b8")
StatusText.Font = Enum.Font.Gotham
StatusText.TextSize = 12
StatusText.Parent = StatusBar

local StartTime = os.time()
RunService.RenderStepped:Connect(function()
 local fps = math.floor(1 / task.wait())
 local elapsed = os.difftime(os.time(), StartTime)
 local mins = math.floor(elapsed / 60)
 local secs = elapsed % 60
 StatusText.Text = string.format("  FPS: %d  •  Sesi: %02d:%02d", fps, mins, secs)
end)

-- Container tombol dengan desain kartu
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -32, 1, -116)
ButtonContainer.Position = UDim2.fromOffset(16, 100)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainPanel

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = ButtonContainer

-- Daftar fitur
local Features = {
    "Auto Farm", "Auto Steal", "Instant Grab", "No Knockback", "Anti AFK", "Event Automation"
}

local TweenOn = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TweenOff = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

for _, feature in Features do
 local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 44)
 Card.BackgroundColor3 = Color3.fromHex("#1e1e26")
 Card.Parent = ButtonContainer
 Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)

 local Label = Instance.new("TextLabel")
 Label.Size = UDim2.new(1, -60, 1, 0)
 Label.Position = UDim2.fromOffset(16, 0)
 Label.BackgroundTransparency = 1
 Label.Text = feature
    Label.TextColor3 = Color3.fromHex("#cbd5e1")
 Label.Font = Enum.Font.Gotham
 Label.TextSize = 14
    Label.Parent = Card

    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.fromOffset(44, 24)
 Toggle.Position = UDim2.new(1, -56, 0.5, -12)
 Toggle.BackgroundColor3 = Color3.fromHex("#333340")
 Toggle.CornerRadius = UDim.new(1, 0)
 Toggle.Parent = Card
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

 local Knob = Instance.new("Frame")
    Knob.Size = UDim2.fromOffset(18, 18)
 Knob.Position = UDim2.fromOffset(3, 3)
 Knob.BackgroundColor3 = Color3.fromHex("#666677")
 Knob.CornerRadius = UDim.new(1, 0)
 Knob.Parent = Toggle
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

 local Active = false
 Card.InputBegan:Connect(function(input)
 if input.UserInputType == Enum.UserInputType.MouseButton1 then
 Active = not Active
 if Active then
                TweenService:Tween(Toggle, TweenOn, {BackgroundColor3 = Color3.fromHex("#10b981")})
      TweenService:Tween(Knob, TweenOn, {Position = UDim2.fromOffset(23, 3), BackgroundColor3 = Color3.new(1,1,1)})
            else
                TweenService:Tween(Toggle, TweenOff, {BackgroundColor3 = Color3.fromHex("#333340")})
      TweenService:Tween(Knob, TweenOff, {Position = UDim2.fromOffset(3, 3), BackgroundColor3 = Color3.fromHex("#666677")})
  end
 end
 end)
end
```

---
