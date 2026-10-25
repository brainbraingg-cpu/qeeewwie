

-- QEEEWWIE PANEL V3
-- GUI ONLY | Mobile-friendly
-- Jalankan dalam konteks client yang mendukung LocalPlayer.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not player then
    warn("Qeeewwie: LocalPlayer tidak ditemukan.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("QeeewwieV3")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "QeeewwieV3"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = playerGui

local purple = Color3.fromRGB(157, 91, 255)
local bg = Color3.fromRGB(19, 18, 27)
local cardBg = Color3.fromRGB(31, 29, 43)
local white = Color3.fromRGB(245, 242, 255)
local muted = Color3.fromRGB(165, 159, 185)

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
end

local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or purple
    s.Thickness = thickness or 1
    s.Parent = obj
end

local function makeLabel(parent, text, size, pos, textSize)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text = text
    l.Size = size
    l.Position = pos
    l.Font = Enum.Font.GothamMedium
    l.TextSize = textSize or 14
    l.TextColor3 = white
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0.84, 0, 0.62, 0)
main.Position = UDim2.new(0.08, 0, 0.19, 0)
main.BackgroundColor3 = bg
main.Parent = gui
corner(main, 14)
stroke(main, purple, 1.5)

local sizeLimit = Instance.new("UISizeConstraint")
sizeLimit.MinSize = Vector2.new(280, 300)
sizeLimit.MaxSize = Vector2.new(430, 520)
sizeLimit.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = cardBg
header.Parent = main
corner(header, 14)

makeLabel(header, "QEEEWWIE  /  V3", UDim2.new(1, -105, 1, 0),
    UDim2.fromOffset(14, 0), 16)

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(34, 32)
minimize.Position = UDim2.new(1, -78, 0, 8)
minimize.Text = "—"
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.TextColor3 = white
minimize.BackgroundColor3 = purple
minimize.Parent = header
corner(minimize, 8)

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 32)
close.Position = UDim2.new(1, -38, 0, 8)
close.Text = "×"
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.TextColor3 = white
close.BackgroundColor3 = Color3.fromRGB(190, 55, 90)
close.Parent = header
corner(close, 8)

local tabs = Instance.new("Frame")
tabs.Position = UDim2.fromOffset(10, 58)
tabs.Size = UDim2.new(1, -20, 0, 38)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabs

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Position = UDim2.fromOffset(10, 104)
content.Size = UDim2.new(1, -20, 1, -145)
content.BackgroundColor3 = cardBg
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = purple
content.CanvasSize = UDim2.fromOffset(0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main
corner(content, 10)

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = content

local footer = makeLabel(main, "Qeeewwie • Ready",
    UDim2.new(1, -20, 0, 24), UDim2.new(0, 10, 1, -29), 11)
footer.TextColor3 = muted

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= list and child ~= padding then
            child:Destroy()
        end
    end
end

local function addInfo(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -2, 0, 34)
    label.BackgroundColor3 = bg
    label.TextColor3 = white
    label.Text = "  " .. text
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    corner(label, 8)
end

local toggleStates = {}

local function addToggle(name)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -2, 0, 44)
    row.BackgroundColor3 = bg
    row.Parent = content
    corner(row, 8)

    makeLabel(row, name, UDim2.new(1, -90, 1, 0),
        UDim2.fromOffset(10, 0), 13)

    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(66, 28)
    button.Position = UDim2.new(1, -76, 0.5, -14)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.TextColor3 = white
    button.Parent = row
    corner(button, 8)

    toggleStates[name] = false

    local function refresh()
        button.Text = toggleStates[name] and "ON" or "OFF"
        button.BackgroundColor3 = toggleStates[name]
            and purple or Color3.fromRGB(70, 65, 82)
    end

    refresh()

    button.Activated:Connect(function()
        toggleStates[name] = not toggleStates[name]
        refresh()
        footer.Text = name .. ": " ..
            (toggleStates[name] and "ON" or "OFF")
    end)
end

local pages = {
    Farm = {"Farm UI toggle", "Auto Farm (UI demo)"},
    Egg = {"Egg Tracker (UI demo)", "Show Egg Info"},
    Event = {"Event Notifications", "Event Status"},
    Settings = {"Dark Theme", "Show FPS", "Show Clock"}
}

local function showPage(page)
    clearContent()
    addInfo("TAB  /  " .. string.upper(page))

    for _, name in ipairs(pages[page]) do
        addToggle(name)
    end

    footer.Text = "Qeeewwie • " .. page
end

local function makeTab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.25, -5, 1, 0)
    button.BackgroundColor3 = cardBg
    button.Text = name
    button.TextColor3 = white
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = tabs
    corner(button, 8)

    button.Activated:Connect(function()
        showPage(name)
    end)
end

for _, name in ipairs({"Farm", "Egg", "Event", "Settings"}) do
    makeTab(name)
end

local minimized = false
minimize.Activated:Connect(function()
    minimized = not minimized
    tabs.Visible = not minimized
    content.Visible = not minimized
    footer.Visible = not minimized
    main.Size = minimized
        and UDim2.new(0.84, 0, 0, 48)
        or UDim2.new(0.84, 0, 0.62, 0)
    minimize.Text = minimized and "+" or "—"
end)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- Geser panel dengan mouse atau sentuhan.
local dragging = false
local dragInput
local dragStart
local startPos

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
    if dragging and (input == dragInput
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- FPS dan jam diperbarui berkala.
local showFPS = true
local frames = 0
local elapsed = 0
local fpsValue = 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fpsValue = frames
        frames = 0
        elapsed = 0

        if not gui.Parent then return end

        if showFPS and not minimized then
            footer.Text = string.format(
                "Qeeewwie • %d FPS • %s",
                fpsValue,
                os.date("%H:%M:%S")
            )
        end
    end
end)

showPage("Farm")
print("Qeeewwie V3 berhasil dibuat.")
