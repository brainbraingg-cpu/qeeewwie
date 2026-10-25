
-- QEEEWWIE HUB - COMPLETE UI
-- Mobile-friendly Roblox GUI
-- Functional utilities; no public-game exploit actions.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("QeeewwieComplete")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(13, 14, 18),
    panel = Color3.fromRGB(22, 23, 29),
    card = Color3.fromRGB(32, 34, 42),
    purple = Color3.fromRGB(151, 91, 255),
    green = Color3.fromRGB(48, 220, 135),
    white = Color3.fromRGB(245, 245, 250),
    muted = Color3.fromRGB(155, 158, 173),
    red = Color3.fromRGB(220, 70, 85)
}

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(obj, n)
    make("UICorner", {CornerRadius = UDim.new(0, n or 8)}, obj)
end

local gui = make("ScreenGui", {
    Name = "QeeewwieComplete",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999
}, playerGui)

local opener = make("TextButton", {
    Size = UDim2.fromOffset(46, 46),
    Position = UDim2.new(0, 12, 0.42, 0),
    BackgroundColor3 = C.purple,
    Text = "Q",
    TextColor3 = C.white,
    TextSize = 24,
    Font = Enum.Font.GothamBold
}, gui)
round(opener, 23)

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.95, 0, 0, 405),
    Position = UDim2.new(0.025, 0, 0.22, 0),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
round(main, 12)
make("UIStroke", {Color = C.purple, Thickness = 1.2}, main)
make("UISizeConstraint", {
    MinSize = Vector2.new(285, 350),
    MaxSize = Vector2.new(620, 500)
}, main)

local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0
}, main)
round(header, 10)

make("TextLabel", {
    Size = UDim2.new(0.52, 0, 1, 0),
    Position = UDim2.fromOffset(10, 0),
    BackgroundTransparency = 1,
    Text = "QEEEWWIE HUB",
    TextColor3 = C.white,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local topInfo = make("TextLabel", {
    Size = UDim2.new(0.25, 0, 1, 0),
    Position = UDim2.new(0.52, 0, 0, 0),
    BackgroundTransparency = 1,
    Text = "READY",
    TextColor3 = C.green,
    TextSize = 10,
    Font = Enum.Font.Gotham
}, header)

local minimize = make("TextButton", {
    Size = UDim2.fromOffset(27, 26),
    Position = UDim2.new(1, -60, 0, 8),
    BackgroundColor3 = C.card,
    Text = "—",
    TextColor3 = C.white,
    TextSize = 16
}, header)
round(minimize, 6)

local close = make("TextButton", {
    Size = UDim2.fromOffset(27, 26),
    Position = UDim2.new(1, -30, 0, 8),
    BackgroundColor3 = C.red,
    Text = "×",
    TextColor3 = C.white,
    TextSize = 16
}, header)
round(close, 6)

local sidebar = make("ScrollingFrame", {
    Size = UDim2.new(0, 100, 1, -72),
    Position = UDim2.fromOffset(6, 47),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
}, main)
round(sidebar, 8)

make("UIPadding", {
    PaddingTop = UDim.new(0, 7),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 7)
}, sidebar)

make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

local content = make("ScrollingFrame", {
    Name = "Content",
    Size = UDim2.new(1, -116, 1, -72),
    Position = UDim2.fromOffset(111, 47),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.purple,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
}, main)
round(content, 8)

make("UIPadding", {
    PaddingTop = UDim.new(0, 9),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 9)
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

local footer = make("TextLabel", {
    Size = UDim2.new(1, -14, 0, 17),
    Position = UDim2.new(0, 7, 1, -20),
    BackgroundTransparency = 1,
    Text = "Qeeewwie • Ready",
    TextColor3 = C.muted,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, main)

local menuNames = {
    "Home", "Steal", "Eggs & Plot", "Pets",
    "Events", "Farm", "Windows", "Server",
    "Visuals", "Settings"
}

local selected = "Home"
local states = {}
local minimized = false
local searchQuery = ""
local eggFilter = "All"
local notes = {}

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject")
            and not child:IsA("UIPadding")
            and not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local function title(text)
    make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 26),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.white,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
end

local function info(text)
    local label = make("TextLabel", {
        Size = UDim2.new(1, 0, 0, 39),
        BackgroundColor3 = C.card,
        Text = "  " .. text,
        TextColor3 = C.muted,
        TextSize = 11,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, content)
    round(label, 7)
end

local function action(text, callback)
    local b = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = C.card,
        Text = text,
        TextColor3 = C.white,
        TextSize = 11,
        Font = Enum.Font.GothamMedium
    }, content)
    round(b, 7)
    b.Activated:Connect(callback)
    return b
end

local function toggle(name, callback)
    if states[name] == nil then states[name] = false end

    local row = make("Frame", {
        Size = UDim2.new(1, 0, 0, 39),
        BackgroundColor3 = C.card
    }, content)
    round(row, 7)

    make("TextLabel", {
        Size = UDim2.new(1, -66, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = C.white,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    }, row)

    local b = make("TextButton", {
        Size = UDim2.fromOffset(48, 25),
        Position = UDim2.new(1, -54, 0.5, -12),
        TextColor3 = C.white,
        TextSize = 10,
        Font = Enum.Font.GothamBold
    }, row)
    round(b, 7)

    local function refresh()
        b.Text = states[name] and "ON" or "OFF"
        b.BackgroundColor3 = states[name] and C.green or C.bg
    end
    refresh()

    b.Activated:Connect(function()
        states[name] = not states[name]
        refresh()
        footer.Text = name .. " : " .. b.Text
        if callback then callback(states[name]) end
    end)
end

local function textInput(placeholder, callback)
    local input = make("TextBox", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = C.card,
        PlaceholderText = placeholder,
        PlaceholderColor3 = C.muted,
        Text = "",
        TextColor3 = C.white,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false
    }, content)
    round(input, 7)
    input.FocusLost:Connect(function(enterPressed)
        callback(input.Text, enterPressed)
    end)
    return input
end

local function render()
    clearContent()
    title(selected)

    if selected == "Home" then
        info("Welcome to Qeeewwie Hub.")
        info("Utility dashboard for your session.")
        action("Show current time", function()
            footer.Text = "Local time: " .. os.date("%H:%M:%S")
        end)
        action("Reset panel position", function()
            main.Position = UDim2.new(0.025, 0, 0.22, 0)
            footer.Text = "Position reset"
        end)

    elseif selected == "Steal" then
        info("Egg target tools and filters.")
        info("Auto-steal exploit actions are not included.")

        textInput("Search egg / target name...", function(value)
            searchQuery = value
            footer.Text = "Filter: " .. (value ~= "" and value or "All targets")
        end)

        action("Filter: All eggs", function()
            eggFilter = "All"
            footer.Text = "Egg filter set to All"
        end)
        action("Filter: Normal eggs", function()
            eggFilter = "Normal"
            footer.Text = "Egg filter set to Normal"
        end)
        action("Filter: Event eggs", function()
            eggFilter = "Event"
            footer.Text = "Egg filter set to Event"
        end)
        toggle("Target notifications")
        toggle("Show target labels")
        action("Save target note", function()
            table.insert(notes, searchQuery ~= "" and searchQuery or "Unnamed target")
            footer.Text = "Target note saved (" .. #notes .. ")"
        end)
        action("View saved target notes", function()
            footer.Text = #notes .. " target note(s) saved"
        end)

    elseif selected == "Eggs & Plot" then
        info("Keep notes about eggs and plot locations.")
        textInput("Enter egg or plot note...", function(value)
            if value ~= "" then
                table.insert(notes, value)
                footer.Text = "Note saved"
            end
        end)
        toggle("Egg reminders")
        toggle("Plot reminders")
        action("Show saved notes", function()
            footer.Text = #notes .. " note(s) saved this session"
        end)

    elseif selected == "Pets" then
        info("Personal pet collection checklist.")
        textInput("Enter pet name...", function(value)
            if value ~= "" then
                table.insert(notes, "Pet: " .. value)
                footer.Text = "Pet note saved"
            end
        end)
        toggle("Collection reminders")
        action("Count saved notes", function()
            footer.Text = "Saved entries: " .. #notes
        end)

    elseif selected == "Events" then
        info("Local event reminders; no live game data connected.")
        toggle("Event notifications")
        toggle("Event reminder timer")
        action("Record event reminder", function()
            table.insert(notes, "Event reminder " .. os.date("%H:%M:%S"))
            footer.Text = "Event reminder recorded"
        end)

    elseif selected == "Farm" then
        info("Session checklist and timer.")
        toggle("Session reminders")
        toggle("Show session clock")
        action("Start session timestamp", function()
            footer.Text = "Session started " .. os.date("%H:%M:%S")
        end)
        action("Stop / reset session", function()
            footer.Text = "Session timer reset"
        end)

    elseif selected == "Windows" then
        info("Panel display options.")
        toggle("Compact layout", function(on)
            main.Size = on
                and UDim2.new(0.95, 0, 0, 340)
                or UDim2.new(0.95, 0, 0, 405)
        end)
        toggle("Show floating Q button", function(on)
            opener.Visible = on
        end)

    elseif selected == "Server" then
        info("Connection information from Roblox client.")
        action("Refresh connection status", function()
            local ok, value = pcall(function()
                return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            footer.Text = ok and ("Ping: " .. math.floor(value) .. " ms")
                or "Ping unavailable"
        end)

    elseif selected == "Visuals" then
        info("Local interface display settings.")
        toggle("Purple accent", function(on)
            local stroke = main:FindFirstChildOfClass("UIStroke")
            if stroke then
                stroke.Color = on and C.purple or C.green
            end
        end)
        toggle("Show footer", function(on)
            footer.Visible = on
        end)

    elseif selected == "Settings" then
        info("Qeeewwie preferences.")
        action("Reset saved notes", function()
            table.clear(notes)
            footer.Text = "Notes cleared"
        end)
        action("Reset menu state", function()
            table.clear(states)
            footer.Text = "Toggle states reset"
            render()
        end)
        action("Hide panel", function()
            main.Visible = false
            opener.Visible = true
        end)
    end
end

local buttons = {}

for _, name in ipairs(menuNames) do
    local b = make("TextButton", {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = name == selected and C.purple or C.card,
        Text = name,
        TextColor3 = C.white,
        TextSize = 10,
        Font = Enum.Font.GothamMedium
    }, sidebar)
    round(b, 7)
    buttons[name] = b

    b.Activated:Connect(function()
        selected = name
        for n, btn in pairs(buttons) do
            btn.BackgroundColor3 = n == name and C.purple or C.card
        end
        render()
    end)
end

opener.Activated:Connect(function()
    main.Visible = not main.Visible
end)

close.Activated:Connect(function()
    main.Visible = false
    opener.Visible = true
end)

minimize.Activated:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    footer.Visible = not minimized
    main.Size = minimized
        and UDim2.new(0.95, 0, 0, 42)
        or UDim2.new(0.95, 0, 0, 405)
    minimize.Text = minimized and "+" or "—"
end)

-- Drag panel with touch or mouse
local dragging = false
local dragStart
local startPos
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
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
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local frames, elapsed = 0, 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt
    if elapsed >= 1 then
        topInfo.Text = frames .. " FPS"
        frames, elapsed = 0, 0
    end
end)

render()
opener.Visible = false
print("Qeeewwie Hub ready")
