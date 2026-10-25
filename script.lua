
-- qeeewwie FULL GUI
-- Menu utama + submenu + FPS monitor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("qeeewwie")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "qeeewwie"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
end

local function makeText(parent, text, size, pos)
    local t = Instance.new("TextLabel")
    t.Size = size
    t.Position = pos
    t.Text = text
    t.TextScaled = true
    t.TextColor3 = Color3.new(1, 1, 1)
    t.BackgroundTransparency = 1
    t.Parent = parent
    return t
end

local function makeButton(parent, text, size, pos, callback)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.Text = text
    b.TextScaled = true
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(48, 53, 78)
    b.Parent = parent
    round(b, 7)
    b.Activated:Connect(callback)
    return b
end

local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.fromOffset(250, 340)
main.Position = UDim2.new(0.5, -125, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 25, 40)
main.Parent = gui
round(main, 12)

makeText(main, "qeeewwie", UDim2.new(1, -45, 0, 40),
    UDim2.fromOffset(5, 0))

local status = makeText(main, "Status: Siap",
    UDim2.new(1, -16, 0, 26), UDim2.fromOffset(8, 40))

local fpsText = makeText(main, "FPS: menghitung...",
    UDim2.new(1, -16, 0, 24), UDim2.fromOffset(8, 66))

local reopen = makeButton(gui, "Buka qeeewwie",
    UDim2.fromOffset(125, 38), UDim2.new(0, 12, 0.5, 0),
    function()
        main.Visible = true
        reopen.Visible = false
    end)
reopen.Visible = false

makeButton(main, "Farm Menu", UDim2.new(1, -20, 0, 38),
    UDim2.fromOffset(10, 98), function()
        status.Text = "Membuka Farm Menu"
        farmMenu.Visible = true
        eggMenu.Visible = false
    end)

makeButton(main, "Egg Priority", UDim2.new(1, -20, 0, 38),
    UDim2.fromOffset(10, 142), function()
        status.Text = "Membuka Egg Priority"
        eggMenu.Visible = true
        farmMenu.Visible = false
    end)

makeButton(main, "Mode Ringan", UDim2.new(1, -20, 0, 38),
    UDim2.fromOffset(10, 186), function()
        status.Text = "Mode ringan dipilih"
    end)

makeButton(main, "Mode Normal", UDim2.new(1, -20, 0, 38),
    UDim2.fromOffset(10, 230), function()
        status.Text = "Mode normal dipilih"
    end)

makeButton(main, "Sembunyikan", UDim2.new(1, -20, 0, 32),
    UDim2.fromOffset(10, 276), function()
        main.Visible = false
        farmMenu.Visible = false
        eggMenu.Visible = false
        reopen.Visible = true
    end)

-- Farm submenu
farmMenu = Instance.new("Frame")
farmMenu.Name = "FarmMenu"
farmMenu.Size = UDim2.fromOffset(230, 160)
farmMenu.Position = UDim2.new(0.5, -115, 0.68, 0)
farmMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
farmMenu.Visible = false
farmMenu.Parent = gui
round(farmMenu, 10)

makeText(farmMenu, "Farm Menu",
    UDim2.new(1, 0, 0, 32), UDim2.fromOffset(0, 0))

local farmOn = false
makeButton(farmMenu, "Auto Farm: OFF",
    UDim2.new(1, -16, 0, 34), UDim2.fromOffset(8, 38),
    function()
        farmOn = not farmOn
        status.Text = farmOn and
            "Auto Farm: ON (status saja)" or "Auto Farm: OFF"
        farmButton.Text = farmOn and
            "Auto Farm: ON" or "Auto Farm: OFF"
    end)

local farmButton = farmMenu:FindFirstChildWhichIsA("TextButton")

makeButton(farmMenu, "Kembali",
    UDim2.new(1, -16, 0, 30), UDim2.fromOffset(8, 80),
    function()
        farmMenu.Visible = false
        status.Text = "Status: Siap"
    end)

-- Egg priority submenu
eggMenu = Instance.new("Frame")
eggMenu.Name = "EggPriorityMenu"
eggMenu.Size = UDim2.fromOffset(230, 205)
eggMenu.Position = UDim2.new(0.5, -115, 0.68, 0)
eggMenu.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
eggMenu.Visible = false
eggMenu.Parent = gui
round(eggMenu, 10)

makeText(eggMenu, "Pilih Egg Priority",
    UDim2.new(1, 0, 0, 32), UDim2.fromOffset(0, 0))

local selectedEgg = "Divine"

for i, rarity in ipairs({"Divine", "Eternal", "Secret"}) do
    makeButton(eggMenu, rarity,
        UDim2.new(1, -16, 0, 32),
        UDim2.fromOffset(8, 34 + (i - 1) * 36),
        function()
            selectedEgg = rarity
            status.Text = "Prioritas: " .. selectedEgg
        end)
end

makeButton(eggMenu, "Kembali",
    UDim2.new(1, -16, 0, 28), UDim2.fromOffset(8, 145),
    function()
        eggMenu.Visible = false
        status.Text = "Status: Siap"
    end)

local frames, elapsed = 0, 0
local connection
connection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent then
        connection:Disconnect()
        return
    end
    frames += 1
    elapsed += dt
    if elapsed >= 1 then
        fpsText.Text = "FPS: " .. math.floor(frames / elapsed)
        frames, elapsed = 0, 0
    end
end)
