
-- QEEEWWIE HUB
-- Dark compact Roblox GUI
-- UI functions only; no public-game exploit actions.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")

local previous = playerGui:FindFirstChild("QeeewwieHub")
if previous then previous:Destroy() end

local C = {
    bg = Color3.fromRGB(15, 15, 20),
    panel = Color3.fromRGB(23, 23, 30),
    card = Color3.fromRGB(34, 34, 43),
    purple = Color3.fromRGB(155, 95, 255),
    green = Color3.fromRGB(50, 220, 135),
    white = Color3.fromRGB(245, 245, 250),
    muted = Color3.fromRGB(155, 155, 170),
    red = Color3.fromRGB(210, 65, 85)
}

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius or 8)
    }, obj)
end

local gui = make("ScreenGui", {
    Name = "QeeewwieHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999
}, playerGui)

-- Floating open button
local opener = make("TextButton", {
    Name = "OpenButton",
    Size = UDim2.fromOffset(48, 48),
    Position = UDim2.new(0, 12, 0.4, 0),
    BackgroundColor3 = C.purple,
    Text = "Q",
    TextColor3 = C.white,
    TextSize = 24,
    Font = Enum.Font.GothamBold
}, gui)
round(opener, 24)

-- Main window
local main = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.94, 0, 0, 390),
    Position = UDim2.new(0.03, 0, 0.24, 0),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
round(main, 12)

make("UISizeConstraint", {
    MinSize = Vector2.new(290, 340),
    MaxSize = Vector2.new(650, 500)
}, main)

make("UIStroke", {
    Color = C.purple,
    Thickness = 1
}, main)

-- Header
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 43),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, main)
round(header, 12)

make("TextLabel", {
    Size = UDim2.new(0.48, 0, 1, 0),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    Text = "QEEEWWIE HUB",
    TextColor3 = C.white,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local topStatus = make("TextLabel", {
    Size = UDim2.new(0.32, 0, 1, 0),
    Position = UDim2.new(0.48, 0, 0, 0),
    BackgroundTransparency = 1,
    Text = "Ready",
    TextColor3 = C.green,
    TextSize = 11,
    Font = Enum.Font.Gotham
}, header)

local mini = make("TextButton", {
    Size = UDim2.fromOffset(28, 27),
    Position = UDim2.new(1, -64, 0, 8),
    BackgroundColor3 = C.card,
    Text = "—",
    TextColor3 = C.white,
    TextSize = 18
}, header)
round(mini, 6)

local close = make("TextButton", {
    Size = UDim2.fromOffset(28, 27),
    Position = UDim2.new(1, -32, 0, 8),
    BackgroundColor3 = C.red,
    Text = "×",
    TextColor3 = C.white,
    TextSize = 18
}, header)
round(close, 6)

-- Sidebar
local sidebar = make("ScrollingFrame", {
    Size = UDim2.new(0, 105, 1, -53),
    Position = UDim2.fromOffset(6, 48),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0, 0, 0, 280),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, main)
round(sidebar, 8)

make("UIPadding", {
    PaddingTop = UDim.new(0, 8),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 8)
}, sidebar)

local sideLayout = make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

-- Right content
local content = make("ScrollingFrame", {
    Name = "Content",
    Size = UDim2.new(1, -123, 1, -78),
    Position = UDim2.fromOffset(117, 52),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, main)
round(content, 8)

make("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 9),
    PaddingRight = UDim.new(0, 9),
    PaddingBottom = UDim.new(0, 10)
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

local footer = make("TextLabel", {
    Size = UDim2.new(1, -16, 0, 18),
    Position = UDim2.new(0, 8, 1, -21),
    BackgroundTransparency = 1,
    Text = "Qeeewwie • UI loaded",
    TextColor3 = C.muted,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, main)

local menus = {
    "Home",
    "Steal",
    "Eggs & Plot",
    "Pets",
    "Events",
    "Farm",
    "Settings"
}

local descriptions = {
    Home = "Dashboard and client status.",
    Steal = "Target tracking and notifications.",
    ["Eggs & Plot"] = "Egg notes and plot information.",
    Pets = "Pet notes and collection tracking.",
    Events = "Event status and reminders.",
    Farm = "Personal checklist and timer.",
    Settings = "Panel appearance and preferences."
}

local states = {}
local selected = "Home"
local searchText = ""
local minimized = false

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject")
            and not child:IsA("UIPadding")
            and not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function addTitle(text)
    make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 27),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.white,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

local function addInfo(text)
    local box = make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 43),
        BackgroundColor3 = C.card,
        Text = "  " .. text,
        TextColor3 = C.muted,
        TextSize = 11,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
    round(box, 7)
end

local function addToggle(name, initial, callback)
    local row = make("Frame", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = C.card
    }, content)
    round(row, 7)

    make("TextLabel", {
        Size = UDim2.new(1, -75, 1, 0),
        Position = UDim2.fromOffset(9, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = C.white,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    states[name] = states[name] == nil and (initial or false)
        or states[name]

    local button = make("TextButton", {
        Size = UDim2.fromOffset(55, 27),
        Position = UDim2.new(1, -62, 0.5, -13),
        TextColor3 = C.white,
        TextSize = 11,
        Font = Enum.Font.GothamBold
    }, row)
    round(button, 7)

    local function refresh()
        button.Text = states[name] and "ON" or "OFF"
        button.BackgroundColor3 = states[name] and C.green or C.bg
    end

    refresh()

    button.Activated:Connect(function()
        states[name] = not states[name]
        refresh()
        if callback then callback(states[name]) end
        footer.Text = name .. " : " .. button.Text
    end)
end

local function addAction(name, callback)
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = C.card,
        Text = name,
        TextColor3 = C.white,
        TextSize = 12,
        Font = Enum.Font.GothamMedium
    }, content)
    round(button, 7)

    button.Activated:Connect(function()
        callback()
    end)
end

local function renderPage()
    clearContent()
    addTitle(selected)
    addInfo(descriptions[selected] or "Qeeewwie settings.")

    if selected == "Home" then
        addInfo("Panel loaded. Select a menu on the left.")
        addAction("Refresh status", function()
            topStatus.Text = "Ready"
            footer.Text = "Status refreshed"
        end)
        addAction("Show current time", function()
            footer.Text = "Local device time: " .. os.date("%H:%M:%S")
        end)

    elseif selected == "Steal" then
        addInfo("Tools here are UI utilities, not gameplay exploits.")
        addToggle("Target notifications", false)
        addToggle("Show target notes", false)
        addAction("Add target note", function()
            footer.Text = "Target notes can be recorded here."
        end)

    elseif selected == "Eggs & Plot" then
        addToggle("Egg reminders", false)
        addToggle("Show egg notes", false)
        addAction("Record egg note", function()
            footer.Text = "Egg note recorded for this session."
        end)

    elseif selected == "Pets" then
        addToggle("Collection reminders", false)
        addAction("View collection notes", function()
            footer.Text = "Collection notes are ready."
        end)

    elseif selected == "Events" then
        addToggle("Event notifications", false)
        addToggle("Event timer", false)
        addAction("Check event status", function()
            footer.Text = "Event status must be supplied by an authorized source."
        end)

    elseif selected == "Farm" then
        addToggle("Session timer", false)
        addToggle("Session reminders", false)
        addAction("Start session timer", function()
            footer.Text = "Session started at " .. os.date("%H:%M:%S")
        end)

    elseif selected == "Settings" then
        addToggle("Compact layout", false, function(enabled)
            main.Size = enabled
                and UDim2.new(0.94, 0, 0, 330)
                or UDim2.new(0.94, 0, 0, 390)
        end)
        addAction("Reset panel position", function()
            main.Position = UDim2.new(0.03, 0, 0.24, 0)
            footer.Text = "Position reset"
        end)
    end
end

local function selectMenu(name)
    selected = name
    renderPage()

    for _, item in ipairs(sidebar:GetChildren()) do
        if item:IsA("TextButton") then
            item.BackgroundColor3 = item.Text == name and C.purple or C.card
        end
    end
end

for _, name in ipairs(menus) do
    local button = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = name == selected and C.purple or C.card,
        Text = name,
        TextColor3 = C.white,
        TextSize = 10,
        Font = Enum.Font.GothamMedium
    }, sidebar)
    round(button, 7)

    button.Activated:Connect(function()
        selectMenu(name)
    end)
end

opener.Activated:Connect(function()
    main.Visible = not main.Visible
end)

close.Activated:Connect(function()
    main.Visible = false
    opener.Visible = true
end)

mini.Activated:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    footer.Visible = not minimized
    main.Size = minimized
        and UDim2.new(0.94, 0, 0, 43)
        or UDim2.new(0.94, 0, 0, 390)
    mini.Text = minimized and "+" or "—"
end)

-- Drag with touch or mouse
local dragging = false
local dragStart
local startPosition
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input == dragInput
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local frames, elapsed, fps = 0, 0, 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fps = frames
        frames = 0
        elapsed = 0

        local ping = "--"
        pcall(function()
            ping = tostring(math.floor(
                Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            )) .. " ms"
        end)

        topStatus.Text = tostring(fps) .. " FPS"
        footer.Text = "Qeeewwie • Ping " .. ping
    end
end)

renderPage()
print("Qeeewwie Hub loaded")
