
--==================================================
-- QEEEWWIE PANEL V2 | GUI DEMO
-- Tabs: Farm, Egg, Event, Settings
-- Toggle gameplay hanya mengubah status UI.
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("QeeewwiePanel")
if old then old:Destroy() end

local COLORS = {
    bg = Color3.fromRGB(18, 20, 28),
    header = Color3.fromRGB(27, 25, 43),
    card = Color3.fromRGB(32, 35, 47),
    accent = Color3.fromRGB(130, 90, 255),
    text = Color3.fromRGB(245, 245, 255),
    muted = Color3.fromRGB(155, 160, 180),
    green = Color3.fromRGB(65, 210, 140),
    off = Color3.fromRGB(65, 68, 82)
}

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
    return c
end

local function stroke(obj, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = 1
    s.Parent = obj
    return s
end

local function animate(obj, duration, properties)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    t:Play()
    return t
end

local function make(className, props, parent)
    local obj = Instance.new(className)
    for key, value in pairs(props) do
        obj[key] = value
    end
    obj.Parent = parent
    return obj
end

local gui = make("ScreenGui", {
    Name = "QeeewwiePanel",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 50
}, playerGui)

-- Main panel
local main = make("Frame", {
    Name = "MainPanel",
    Size = UDim2.fromOffset(340, 460),
    Position = UDim2.new(0.5, -170, 0.5, -230),
    BackgroundColor3 = COLORS.bg,
    BorderSizePixel = 0
}, gui)
corner(main, 14)
stroke(main, COLORS.accent, 0.45)

-- Header
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = COLORS.header,
    BorderSizePixel = 0
}, main)
corner(header, 14)

make("Frame", {
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -14),
    BackgroundColor3 = COLORS.header,
    BorderSizePixel = 0
}, header)

make("TextLabel", {
    Size = UDim2.new(1, -100, 0, 27),
    Position = UDim2.fromOffset(14, 7),
    BackgroundTransparency = 1,
    Text = "QEEEWWIE PANEL",
    TextColor3 = COLORS.text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

make("TextLabel", {
    Size = UDim2.new(1, -100, 0, 17),
    Position = UDim2.fromOffset(14, 33),
    BackgroundTransparency = 1,
    Text = "CONTROL CENTER • V2",
    TextColor3 = COLORS.muted,
    Font = Enum.Font.Gotham,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local minimize = make("TextButton", {
    Size = UDim2.fromOffset(32, 32),
    Position = UDim2.new(1, -44, 0, 13),
    BackgroundColor3 = COLORS.card,
    Text = "—",
    TextColor3 = COLORS.text,
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    AutoButtonColor = false
}, header)
corner(minimize, 8)

-- Status bar
local statusBar = make("Frame", {
    Size = UDim2.new(1, -24, 0, 27),
    Position = UDim2.fromOffset(12, 66),
    BackgroundColor3 = COLORS.header,
    BorderSizePixel = 0
}, main)
corner(statusBar, 8)

local fpsLabel = make("TextLabel", {
    Size = UDim2.new(0.5, -8, 1, 0),
    Position = UDim2.fromOffset(8, 0),
    BackgroundTransparency = 1,
    Text = "FPS: --",
    TextColor3 = COLORS.green,
    Font = Enum.Font.GothamMedium,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
}, statusBar)

local timeLabel = make("TextLabel", {
    Size = UDim2.new(0.5, -8, 1, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    BackgroundTransparency = 1,
    Text = "Sesi: 00:00",
    TextColor3 = COLORS.muted,
    Font = Enum.Font.GothamMedium,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Right
}, statusBar)

-- Tab navigation
local tabBar = make("Frame", {
    Size = UDim2.new(1, -24, 0, 36),
    Position = UDim2.fromOffset(12, 103),
    BackgroundTransparency = 1
}, main)

local tabLayout = make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, tabBar)

local pageArea = make("Frame", {
    Size = UDim2.new(1, -24, 1, -185),
    Position = UDim2.fromOffset(12, 147),
    BackgroundTransparency = 1,
    ClipsDescendants = true
}, main)

local statusText = make("TextLabel", {
    Size = UDim2.new(1, -24, 0, 22),
    Position = UDim2.new(0, 12, 1, -30),
    BackgroundTransparency = 1,
    Text = "Status: GUI siap",
    TextColor3 = COLORS.muted,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
}, main)

local tabs = {"Farm", "Egg", "Event", "Pengaturan"}
local pages = {}
local tabButtons = {}
local currentTab = nil
local toggleStates = {}

local function createPage(name)
    local page = make("ScrollingFrame", {
        Name = name .. "Page",
        Size = UDim2.fromScale(1, 1),
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = COLORS.accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false
    }, pageArea)

    make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    make("UIPadding", {
        PaddingBottom = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 3)
    }, page)

    pages[name] = page
    return page
end

for i, name in ipairs(tabs) do
    local button = make("TextButton", {
        Name = name .. "Tab",
        Size = UDim2.new(0.25, -4, 1, 0),
        BackgroundColor3 = COLORS.card,
        Text = name,
        TextColor3 = COLORS.muted,
        Font = Enum.Font.GothamMedium,
        TextSize = 10,
        AutoButtonColor = false,
        LayoutOrder = i
    }, tabBar)

    corner(button, 8)
    tabButtons[name] = button
    createPage(name)
end

local function showTab(name)
    currentTab = name

    for tabName, page in pairs(pages) do
        page.Visible = tabName == name
        animate(tabButtons[tabName], 0.12, {
            BackgroundColor3 = tabName == name and COLORS.accent or COLORS.card,
            TextColor3 = tabName == name and COLORS.text or COLORS.muted
        })
    end

    statusText.Text = "Halaman: " .. name
end

for _, name in ipairs(tabs) do
    tabButtons[name].Activated:Connect(function()
        showTab(name)
    end)
end

local function addSection(page, text)
    local label = make("TextLabel", {
        Size = UDim2.new(1, -2, 0, 25),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, page)
    return label
end

local function addInfo(page, title, description)
    local card = make("Frame", {
        Size = UDim2.new(1, -2, 0, 58),
        BackgroundColor3 = COLORS.card,
        BorderSizePixel = 0
    }, page)
    corner(card, 9)

    make("TextLabel", {
        Size = UDim2.new(1, -18, 0, 23),
        Position = UDim2.fromOffset(9, 5),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = COLORS.text,
        Font = Enum.Font.GothamMedium,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    make("TextLabel", {
        Size = UDim2.new(1, -18, 0, 20),
        Position = UDim2.fromOffset(9, 29),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = COLORS.muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)
end

local function addToggle(page, name, initial)
    toggleStates[name] = initial or false

    local card = make("Frame", {
        Size = UDim2.new(1, -2, 0, 43),
        BackgroundColor3 = COLORS.card,
        BorderSizePixel = 0
    }, page)
    corner(card, 9)

    make("TextLabel", {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.fromOffset(11, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = COLORS.text,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    local button = make("TextButton", {
        Size = UDim2.fromOffset(44, 24),
        Position = UDim2.new(1, -55, 0.5, -12),
        BackgroundColor3 = COLORS.off,
        Text = "",
        AutoButtonColor = false
    }, card)
    corner(button, 12)

    local knob = make("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.fromOffset(3, 3),
        BackgroundColor3 = COLORS.text,
        BorderSizePixel = 0
    }, button)
    corner(knob, 9)

    local function update(animateIt)
        local enabled = toggleStates[name]
        local duration = animateIt and 0.15 or 0

        animate(button, duration, {
            BackgroundColor3 = enabled and COLORS.green or COLORS.off
        })

        animate(knob, duration, {
            Position = enabled and UDim2.new(1, -21, 0, 3)
                or UDim2.fromOffset(3, 3)
        })
    end

    update(false)

    button.Activated:Connect(function()
        toggleStates[name] = not toggleStates[name]
        update(true)
        statusText.Text = name .. (toggleStates[name] and ": ON (UI)" or ": OFF")
    end)
end

-- FARM TAB
addSection(pages.Farm, "FARM CONTROLS")
addInfo(pages.Farm, "Demo mode", "Tombol di halaman ini hanya mengubah tampilan.")
addToggle(pages.Farm, "Auto Farm", false)
addToggle(pages.Farm, "Anti AFK", false)

-- EGG TAB
addSection(pages.Egg, "EGG CONTROLS")
addInfo(pages.Egg, "Egg tools", "Kontrol demonstrasi; tidak mengambil item.")
addToggle(pages.Egg, "Auto Steal", false)
addToggle(pages.Egg, "Instant Grab", false)
addToggle(pages.Egg, "Prioritas Rare Egg", false)

-- EVENT TAB
addSection(pages.Event, "EVENT CONTROLS")
addInfo(pages.Event, "Event tools", "Status tombol tidak menjalankan event otomatis.")
addToggle(pages.Event, "Event Automation", false)
addToggle(pages.Event, "No Knockback", false)

-- SETTINGS TAB
addSection(pages.Pengaturan, "PENGATURAN")
addInfo(pages.Pengaturan, "Tema panel", "Pilih warna aksen panel.")
addToggle(pages.Pengaturan, "Animasi UI", true)

local themeButton = make("TextButton", {
    Size = UDim2.new(1, -2, 0, 42),
    BackgroundColor3 = COLORS.card,
    Text = "Ganti aksen warna",
    TextColor3 = COLORS.text,
    Font = Enum.Font.GothamMedium,
    TextSize = 12,
    AutoButtonColor = false
}, pages.Pengaturan)
corner(themeButton, 9)

local themes = {
    Color3.fromRGB(130, 90, 255),
    Color3.fromRGB(35, 175, 255),
    Color3.fromRGB(255, 100, 150),
    Color3.fromRGB(65, 210, 140)
}
local themeIndex = 1

themeButton.Activated:Connect(function()
    themeIndex = themeIndex % #themes + 1
    COLORS.accent = themes[themeIndex]

    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("UIStroke") then
            obj.Color = COLORS.accent
        end
    end

    for tabName, button in pairs(tabButtons) do
        button.BackgroundColor3 = tabName == currentTab and COLORS.accent or COLORS.card
    end

    statusText.Text = "Aksen tema diperbarui"
end)

-- Minimize / restore
local minimized = false
local expandedSize = UDim2.fromOffset(340, 460)

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        tabBar.Visible = false
        pageArea.Visible = false
        statusBar.Visible = false
        statusText.Visible = false
        minimize.Text = "+"
        animate(main, 0.18, {Size = UDim2.fromOffset(340, 58)})
    else
        minimize.Text = "−"
        animate(main, 0.18, {Size = expandedSize})
        task.delay(0.19, function()
            if gui.Parent and not minimized then
                tabBar.Visible = true
                pageArea.Visible = true
                statusBar.Visible = true
                statusText.Visible = true
            end
        end)
    end
end)

-- Drag header: mouse dan touch
local dragging = false
local dragStart
local startPos
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- FPS counter dan waktu sesi
local startClock = os.clock()
local frames = 0
local frameTime = 0

local renderConnection = RunService.RenderStepped:Connect(function(dt)
    frames += 1
    frameTime += dt

    if frameTime >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(math.floor(frames / frameTime))
        frames = 0
        frameTime = 0
    end

    local seconds = math.floor(os.clock() - startClock)
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    timeLabel.Text = string.format("Sesi: %02d:%02d", mins, secs)
end)

gui.Destroying:Connect(function()
    if renderConnection then
        renderConnection:Disconnect()
    end
end)

showTab("Farm")
print("Qeeewwie Panel V2 loaded.")
