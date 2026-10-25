
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

local function round(obj)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = obj
end

local function button(parent, text, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 36)
    b.Position = UDim2.fromOffset(10, y)
    b.Text = text
    b.TextScaled = true
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BackgroundColor3 = Color3.fromRGB(48, 55, 82)
    b.Parent = parent
    round(b)
    b.Activated:Connect(callback)
    return b
end

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(245, 330)
main.Position = UDim2.new(0.5, -122, 0.25, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 25, 40)
main.Parent = gui
round(main)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 36)
title.Text = "qeeewwie"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(125, 190, 255)
title.BackgroundTransparency = 1
title.Parent = main

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 28)
status.Position = UDim2.fromOffset(8, 36)
status.Text = "Status: Siap"
status.TextScaled = true
status.TextColor3 = Color3.new(1, 1, 1)
status.BackgroundTransparency = 1
status.Parent = main

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, -16, 0, 24)
fpsLabel.Position = UDim2.fromOffset(8, 62)
fpsLabel.Text = "FPS: menghitung..."
fpsLabel.TextScaled = true
fpsLabel.TextColor3 = Color3.fromRGB(120, 255, 160)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Parent = main

local farm = Instance.new("Frame")
farm.Size = UDim2.fromOffset(230, 145)
farm.Position = UDim2.new(0.5, -115, 0.65, 0)
farm.BackgroundColor3 = Color3.fromRGB(32, 34, 53)
farm.Visible = false
farm.Parent = gui
round(farm)

local egg = Instance.new("Frame")
egg.Size = UDim2.fromOffset(230, 185)
egg.Position = UDim2.new(0.5, -115, 0.65, 0)
egg.BackgroundColor3 = Color3.fromRGB(32, 34, 53)
egg.Visible = false
egg.Parent = gui
round(egg)

local running = false
local startedAt = 0
local selectedEgg = "Divine"

local farmTitle = Instance.new("TextLabel")
farmTitle.Size = UDim2.new(1, 0, 0, 30)
farmTitle.Text = "Farm Session"
farmTitle.TextScaled = true
farmTitle.TextColor3 = Color3.new(1, 1, 1)
farmTitle.BackgroundTransparency = 1
farmTitle.Parent = farm

local timer = Instance.new("TextLabel")
timer.Size = UDim2.new(1, 0, 0, 25)
timer.Position = UDim2.fromOffset(0, 30)
timer.Text = "Durasi: 00:00"
timer.TextScaled = true
timer.TextColor3 = Color3.new(1, 1, 1)
timer.BackgroundTransparency = 1
timer.Parent = farm

local startButton
startButton = button(farm, "Start Session", 60, function()
    if not running then
        running = true
        startedAt = os.clock()
        status.Text = "Farm session: ON"
        startButton.Text = "Stop Session"
    else
        running = false
        status.Text = "Farm session: OFF"
        startButton.Text = "Start Session"
    end
end)

button(farm, "Kembali", 102, function()
    farm.Visible = false
end)

button(main, "Farm Menu", 96, function()
    egg.Visible = false
    farm.Visible = not farm.Visible
end)

button(main, "Egg Priority", 138, function()
    farm.Visible = false
    egg.Visible = not egg.Visible
end)

button(main, "Mode Ringan", 180, function()
    status.Text = "Mode ringan GUI aktif"
    title.Visible = false
    fpsLabel.Visible = false
end)

button(main, "Mode Normal", 222, function()
    title.Visible = true
    fpsLabel.Visible = true
    status.Text = "Mode normal aktif"
end)

local priorityTitle = Instance.new("TextLabel")
priorityTitle.Size = UDim2.new(1, 0, 0, 30)
priorityTitle.Text = "Egg Priority"
priorityTitle.TextScaled = true
priorityTitle.TextColor3 = Color3.new(1, 1, 1)
priorityTitle.BackgroundTransparency = 1
priorityTitle.Parent = egg

local selectedLabel = Instance.new("TextLabel")
selectedLabel.Size = UDim2.new(1, 0, 0, 25)
selectedLabel.Position = UDim2.fromOffset(0, 30)
selectedLabel.Text = "Terpilih: Divine"
selectedLabel.TextScaled = true
selectedLabel.TextColor3 = Color3.new(1, 1, 1)
selectedLabel.BackgroundTransparency = 1
selectedLabel.Parent = egg

for i, rarity in ipairs({"Divine", "Eternal", "Secret"}) do
    button(egg, rarity, 58 + (i - 1) * 35, function()
        selectedEgg = rarity
        selectedLabel.Text = "Terpilih: " .. selectedEgg
        status.Text = "Prioritas dipilih: " .. selectedEgg
    end)
end

button(egg, "Kembali", 163, function()
    egg.Visible = false
end)

local reopen = button(gui, "Buka qeeewwie", 0, function()
    main.Visible = true
    reopen.Visible = false
end)
reopen.Position = UDim2.new(0, 12, 0.5, 0)
reopen.Visible = false

button(main, "Minimize", 264, function()
    main.Visible = false
    farm.Visible = false
    egg.Visible = false
    reopen.Visible = true
end)

local frames, elapsed = 0, 0
RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fpsLabel.Text = "FPS: " .. math.floor(frames / elapsed)
        frames, elapsed = 0, 0
    end

    if running then
        local seconds = math.floor(os.clock() - startedAt)
        timer.Text = string.format(
            "Durasi: %02d:%02d",
            math.floor(seconds / 60),
            seconds % 60
        )
    end
end)
