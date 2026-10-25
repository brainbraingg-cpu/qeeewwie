
-- QEEEWWIE PANEL V3.1
-- GUI demo: mobile-friendly

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then
    warn("Qeeewwie: LocalPlayer tidak tersedia")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("QeeewwieV31")
if old then old:Destroy() end

local PURPLE = Color3.fromRGB(157, 91, 255)
local BG = Color3.fromRGB(24, 22, 34)
local CARD = Color3.fromRGB(39, 35, 53)
local WHITE = Color3.fromRGB(245, 242, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwieV31"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.88, 0, 0, 370)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui

local limit = Instance.new("UISizeConstraint")
limit.MinSize = Vector2.new(270, 330)
limit.MaxSize = Vector2.new(390, 420)
limit.Parent = main

local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

addCorner(main, 14)

local header = Instance.new("TextButton")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = CARD
header.BorderSizePixel = 0
header.Text = "  QEEEWWIE PANEL  V3.1"
header.TextColor3 = WHITE
header.TextSize = 15
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main
addCorner(header, 14)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 30)
close.Position = UDim2.new(1, -40, 0, 9)
close.BackgroundColor3 = Color3.fromRGB(190, 55, 90)
close.Text = "X"
close.TextColor3 = WHITE
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.Parent = header
addCorner(close, 8)

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(34, 30)
minimize.Position = UDim2.new(1, -80, 0, 9)
minimize.BackgroundColor3 = PURPLE
minimize.Text = "-"
minimize.TextColor3 = WHITE
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
minimize.Parent = header
addCorner(minimize, 8)

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, 38)
tabBar.Position = UDim2.fromOffset(8, 56)
tabBar.BackgroundTransparency = 1
tabBar.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabBar

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Size = UDim2.new(1, -16, 0, 210)
content.Position = UDim2.fromOffset(8, 102)
content.BackgroundColor3 = CARD
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = PURPLE
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new()
content.Parent = main
addCorner(content, 10)

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 8)
contentPadding.PaddingLeft = UDim.new(0, 8)
contentPadding.PaddingRight = UDim.new(0, 8)
contentPadding.PaddingBottom = UDim.new(0, 8)
contentPadding.Parent = content

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 7)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -16, 0, 25)
footer.Position = UDim2.new(0, 8, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "Qeeewwie • Siap"
footer.TextColor3 = Color3.fromRGB(190, 180, 210)
footer.TextSize = 11
footer.Font = Enum.Font.Gotham
footer.Parent = main

local states = {}
local currentPage = "Farm"

local pages = {
    Farm = {"Auto Farm (demo UI)", "Farm Notifications"},
    Egg = {"Egg Tracker (demo UI)", "Show Egg Information"},
    Event = {"Event Notifications", "Event Status"},
    Settings = {"Show Clock", "Show FPS"}
}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child ~= contentPadding and child ~= contentLayout then
            child:Destroy()
        end
    end
end

local function addInfo(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 32)
    label.BackgroundColor3 = BG
    label.Text = "  " .. text
    label.TextColor3 = WHITE
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.Parent = content
    addCorner(label, 7)
end

local function addToggle(name)
    if states[name] == nil then
        states[name] = false
    end

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = BG
    row.Parent = content
    addCorner(row, 7)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -90, 1, 0)
    label.Position = UDim2.fromOffset(9, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = WHITE
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = row

    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(60, 27)
    button.Position = UDim2.new(1, -68, 0.5, -13)
    button.TextColor3 = WHITE
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = row
    addCorner(button, 7)

    local function refresh()
        button.Text = states[name] and "ON" or "OFF"
        button.BackgroundColor3 = states[name]
            and PURPLE or Color3.fromRGB(76, 70, 91)
    end

    refresh()

    button.Activated:Connect(function()
        states[name] = not states[name]
        refresh()
        footer.Text = name .. ": " .. button.Text
    end)
end

local function showPage(page)
    currentPage = page
    clearContent()
    addInfo("MENU  /  " .. string.upper(page))

    for _, name in ipairs(pages[page]) do
        addToggle(name)
    end

    footer.Text = "Qeeewwie • " .. page
end

for _, page in ipairs({"Farm", "Egg", "Event", "Settings"}) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.25, -5, 1, 0)
    button.BackgroundColor3 = CARD
    button.Text = page
    button.TextColor3 = WHITE
    button.TextSize = 10
    button.Font = Enum.Font.GothamBold
    button.Parent = tabBar
    addCorner(button, 7)

    button.Activated:Connect(function()
        showPage(page)
    end)
end

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized
    tabBar.Visible = not minimized
    content.Visible = not minimized
    footer.Visible = not minimized

    main.Size = minimized
        and UDim2.new(0.88, 0, 0, 48)
        or UDim2.new(0.88, 0, 0, 370)

    minimize.Text = minimized and "+" or "-"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- Drag panel menggunakan sentuhan atau mouse.
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local inputChanged
header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement then
        inputChanged = input
    end
end)

local UserInputService = game:GetService("UserInputService")
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == inputChanged
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

showPage("Farm")
gui.Parent = playerGui

print("Qeeewwie V3.1: GUI dipasang ke PlayerGui")
