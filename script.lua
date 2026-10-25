--[=[ qeeewwie - GUI refresh - Main menu stays available - Draggable header and floating minimize logo - Farm / Egg Priority / Event / Settings pages - FPS counter and local session timer IMPORTANT: This is a GUI/control-panel template. Buttons for auto-farm, auto-steal, instant-steal, instant-grab, no-knockback, anti-AFK, and event automation only change the GUI's displayed state. They do not manipulate gameplay. Use gameplay automation only in a Roblox experience you own or are authorized to develop, with server-side validation. ]=]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui")

-- Optional: set this to a Roblox image asset ID that you own or are allowed to use.
-- Example: "rbxassetid://1234567890"
local LOGO_IMAGE = ""

local oldGui = playerGui:FindFirstChild("qeeewwie")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "qeeewwie"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local palette = {
    background = Color3.fromRGB(13, 14, 27),
    panel = Color3.fromRGB(24, 25, 43),
    panel2 = Color3.fromRGB(33, 34, 57),
    button = Color3.fromRGB(48, 50, 80),
    buttonOn = Color3.fromRGB(105, 64, 190),
    accent = Color3.fromRGB(173, 125, 255),
    text = Color3.fromRGB(245, 242, 255),
    muted = Color3.fromRGB(173, 170, 198),
    good = Color3.fromRGB(106, 235, 171),
}

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 9)
    corner.Parent = object
    return corner
end

local function addStroke(object, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or palette.accent
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.35
    stroke.Parent = object
    return stroke
end

local function makeLabel(parent, text, size, position, textSize)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = size
    label.Position = position
    label.Text = text
    label.TextColor3 = palette.text
    label.TextSize = textSize or 14
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function makeButton(parent, text, size, position, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = palette.button
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = palette.text
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    button.TextWrapped = true
    button.AutoButtonColor = true
    button.Parent = parent
    addCorner(button, 7)
    button.Activated:Connect(callback)
    return button
end

-- Generic touch/mouse dragging helper. Returns state.moved so taps can be
-- distinguished from dragging on the floating logo.
local function makeDraggable(handle, target)
    local state = {
        dragging = false,
        moved = false,
        dragInput = nil,
        dragStart = nil,
        startPosition = nil,
    }

    handle.InputBegan:Connect(function(input)
        local typeIsDrag = input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch
        if not typeIsDrag then return end

        state.dragging = true
        state.moved = false
        state.dragStart = input.Position
        state.startPosition = target.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                state.dragging = false
            end
        end)
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            state.dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not state.dragging then return end
        local isRelevant = input == state.dragInput
            or input.UserInputType == Enum.UserInputType.Touch
        if not isRelevant then return end

        local delta = input.Position - state.dragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            state.moved = true
        end

        target.Position = UDim2.new(
            state.startPosition.X.Scale,
            state.startPosition.X.Offset + delta.X,
            state.startPosition.Y.Scale,
            state.startPosition.Y.Offset + delta.Y
        )
    end)

    return state
end

-- Main window
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.Size = UDim2.fromOffset(340, 455)
main.Position = UDim2.new(0.5, -170, 0.5, -227)
main.BackgroundColor3 = palette.background
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui
addCorner(main, 13)
local mainStroke = addStroke(main, palette.accent, 1.4, 0.22)

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 42)
header.BackgroundColor3 = palette.panel
header.BorderSizePixel = 0
header.Parent = main
addCorner(header, 12)

local brandIcon = Instance.new("Frame")
brandIcon.Size = UDim2.fromOffset(28, 28)
brandIcon.Position = UDim2.fromOffset(9, 7)
brandIcon.BackgroundColor3 = palette.buttonOn
brandIcon.Parent = header
addCorner(brandIcon, 9)
local brandQ = makeLabel(brandIcon, "Q", UDim2.fromScale(1, 1), UDim2.fromOffset(0, 0), 18)
brandQ.Font = Enum.Font.GothamBold
brandQ.TextXAlignment = Enum.TextXAlignment.Center

local title = makeLabel(header, "qeeewwie", UDim2.new(1, -105, 0, 21), UDim2.fromOffset(45, 4), 16)
title.Font = Enum.Font.GothamBold
local subtitle = makeLabel(header, "GUI • local controls", UDim2.new(1, -105, 0, 14), UDim2.fromOffset(46, 24), 9)
subtitle.TextColor3 = palette.muted

local minimizeButton = makeButton(header, "—", UDim2.fromOffset(30, 27), UDim2.new(1, -39, 0, 7), function() end)
minimizeButton.TextSize = 16
minimizeButton.BackgroundColor3 = palette.panel2
makeDraggable(header, main)

-- Navigation
local nav = Instance.new("Frame")
nav.Name = "Navigation"
nav.Size = UDim2.new(1, -16, 0, 33)
nav.Position = UDim2.fromOffset(8, 47)
nav.BackgroundTransparency = 1
nav.Parent = main

-- Page body
local pageHolder = Instance.new("Frame")
pageHolder.Name = "PageHolder"
pageHolder.Size = UDim2.new(1, -20, 0, 294)
pageHolder.Position = UDim2.fromOffset(10, 84)
pageHolder.BackgroundColor3 = palette.panel
pageHolder.BorderSizePixel = 0
pageHolder.ClipsDescendants = true
pageHolder.Parent = main
addCorner(pageHolder, 9)

local pages = {}
local function createPage(name)
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = pageHolder
    pages[name] = page
    return page
end

local homePage = createPage("Home")
local farmPage = createPage("Farm")
local eggPage = createPage("Eggs")
local eventPage = createPage("Events")
local settingsPage = createPage("Settings")

local statusLabel = makeLabel(main, "Status: siap", UDim2.new(1, -20, 0, 20), UDim2.fromOffset(10, 383), 11)
statusLabel.TextColor3 = palette.good
local fpsLabel = makeLabel(main, "FPS: menghitung...", UDim2.new(1, -20, 0, 18), UDim2.fromOffset(10, 407), 10)
fpsLabel.TextColor3 = palette.muted
local footnote = makeLabel(main, "Kontrol GUI saja • bukan automasi gameplay", UDim2.new(1, -20, 0, 15), UDim2.fromOffset(10, 430), 8)
footnote.TextColor3 = palette.muted

local function setStatus(text)
    statusLabel.Text = "Status: " .. text
end

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    setStatus("menu " .. name .. " terbuka")
end

local tabNames = { "Home", "Farm", "Eggs", "Events", "Settings" }
for i, name in ipairs(tabNames) do
    local tab = makeButton(nav, name, UDim2.fromOffset(60, 31), UDim2.fromOffset((i - 1) * 64, 0), function()
        showPage(name)
    end)
    tab.TextSize = 10
    tab.Name = name .. "Tab"
end

-- Home page
makeLabel(homePage, "Selamat datang di qeeewwie", UDim2.new(1, -20, 0, 28), UDim2.fromOffset(10, 10), 15).Font = Enum.Font.GothamBold
makeLabel(homePage,
    "Menu utama, kontrol tampilan, dan pemantau FPS ada di sini. Logo kecil dapat digeser dan diketuk untuk membuka GUI kembali.",
    UDim2.new(1, -20, 0, 70), UDim2.fromOffset(10, 43), 12).TextColor3 = palette.muted
makeLabel(homePage,
    "Catatan: Auto Farm, Auto Steal, Instant Steal/Grab, No Knockback, Anti-AFK, dan event otomatis pada template ini hanya mengubah status UI. Tidak ada aksi pada game.",
    UDim2.new(1, -20, 0, 105), UDim2.fromOffset(10, 125), 11).TextColor3 = palette.muted

-- State is deliberately UI-only: no gameplay calls/remotes are made.
local toggleState = {}
local function addToggle(parent, key, label, y)
    toggleState[key] = false
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -18, 0, 31)
    row.Position = UDim2.fromOffset(9, y)
    row.BackgroundColor3 = palette.panel2
    row.BorderSizePixel = 0
    row.Parent = parent
    addCorner(row, 7)

    local text = makeLabel(row, label, UDim2.new(1, -91, 1, 0), UDim2.fromOffset(9, 0), 11)
    local toggle = makeButton(row, "OFF", UDim2.fromOffset(63, 23), UDim2.new(1, -70, 0.5, -11), function() end)
    toggle.TextSize = 10
    toggleState[key .. "Button"] = toggle
    toggle.Activated:Connect(function()
        toggleState[key] = not toggleState[key]
        toggle.Text = toggleState[key] and "ON" or "OFF"
        toggle.BackgroundColor3 = toggleState[key] and palette.buttonOn or palette.button
        setStatus(label .. ": " .. (toggleState[key] and "ON (UI saja)" or "OFF"))
    end)
    return row
end

-- Farm page
makeLabel(farmPage, "FARM CONTROLS", UDim2.new(1, -18, 0, 22), UDim2.fromOffset(9, 5), 13).Font = Enum.Font.GothamBold
addToggle(farmPage, "AutoFarm", "Auto Farm", 31)
addToggle(farmPage, "AutoSteal", "Auto Steal", 67)
addToggle(farmPage, "InstantSteal", "Instant Steal", 103)
addToggle(farmPage, "InstantGrab", "Instant Grab", 139)
addToggle(farmPage, "NoKnockback", "No Knockback", 175)

local sessionRunning = false
local sessionElapsed = 0
local sessionButton
sessionButton = makeButton(farmPage, "Start Session Timer", UDim2.new(1, -18, 0, 30), UDim2.fromOffset(9, 216), function()
    sessionRunning = not sessionRunning
    if sessionRunning then
        sessionButton.Text = "Stop Session Timer"
        setStatus("timer sesi dimulai")
    else
        sessionButton.Text = "Start Session Timer"
        setStatus("timer sesi dihentikan")
    end
end)
local sessionLabel = makeLabel(farmPage, "Durasi sesi: 00:00", UDim2.new(1, -18, 0, 18), UDim2.fromOffset(9, 251), 10)
sessionLabel.TextColor3 = palette.muted

-- Egg priority page: multi-select list, with no interaction with game data.
makeLabel(eggPage, "EGG PRIORITY • PILIH RARITY", UDim2.new(1, -18, 0, 22), UDim2.fromOffset(9, 4), 12).Font = Enum.Font.GothamBold
makeLabel(eggPage, "Pilih rarity yang ingin ditandai:", UDim2.new(1, -18, 0, 17), UDim2.fromOffset(9, 26), 10).TextColor3 = palette.muted

local rarityList = { "Divine", "Eternal", "Secret", "Mythic", "Celestial", "Legendary", "Epic", "Rare", "Uncommon", "Common", "Event", "Limited" }
local selectedRarity = { Divine = true, Eternal = true, Secret = true }
local selectedCountLabel = makeLabel(eggPage, "Terpilih: Divine, Eternal, Secret", UDim2.new(1, -18, 0, 27), UDim2.fromOffset(9, 263), 9)
selectedCountLabel.TextColor3 = palette.good

local rarityScroll = Instance.new("ScrollingFrame")
rarityScroll.Name = "RarityList"
rarityScroll.Size = UDim2.new(1, -18, 0, 210)
rarityScroll.Position = UDim2.fromOffset(9, 48)
rarityScroll.BackgroundColor3 = palette.panel2
rarityScroll.BorderSizePixel = 0
rarityScroll.ScrollBarThickness = 4
rarityScroll.CanvasSize = UDim2.fromOffset(0, #rarityList * 30)
rarityScroll.Parent = eggPage
addCorner(rarityScroll, 7)

local function refreshRaritySummary()
    local names = {}
    for _, rarity in ipairs(rarityList) do
        if selectedRarity[rarity] then table.insert(names, rarity) end
    end
    selectedCountLabel.Text = #names > 0 and ("Terpilih: " .. table.concat(names, ", ")) or "Terpilih: belum ada"
end

for i, rarity in ipairs(rarityList) do
    local rarityButton = makeButton(rarityScroll, "", UDim2.new(1, -10, 0, 26), UDim2.fromOffset(5, (i - 1) * 30 + 2), function() end)
    rarityButton.TextXAlignment = Enum.TextXAlignment.Left
    local function updateRarityButton()
        rarityButton.Text = (selectedRarity[rarity] and "✓ " or "○ ") .. rarity
        rarityButton.BackgroundColor3 = selectedRarity[rarity] and palette.buttonOn or palette.button
    end
    updateRarityButton()
    rarityButton.Activated:Connect(function()
        selectedRarity[rarity] = not selectedRarity[rarity]
        updateRarityButton()
        refreshRaritySummary()
        setStatus(rarity .. (selectedRarity[rarity] and " ditandai (UI saja)" or " dilepas (UI saja)"))
    end)
end

-- Event page
makeLabel(eventPage, "EVENT MENU", UDim2.new(1, -18, 0, 22), UDim2.fromOffset(9, 5), 13).Font = Enum.Font.GothamBold
addToggle(eventPage, "AutoHitMob", "Auto Hit Mob", 34)
addToggle(eventPage, "AutoFishing", "Auto Fishing", 70)
addToggle(eventPage, "AutoPumpkin", "Auto Pumpkin", 106)
addToggle(eventPage, "AutoPhantomExpress", "Auto Phantom Express", 142)
addToggle(eventPage, "AntiAFK", "Anti-AFK", 178)
makeLabel(eventPage, "Toggle ini hanya menyimpan pilihan pada GUI; tidak menggerakkan karakter atau menjalankan event.",
    UDim2.new(1, -18, 0, 50), UDim2.fromOffset(9, 218), 10).TextColor3 = palette.muted

-- Settings page: GUI look only; Roblox game graphics settings are not changed.
local logo -- forward-declare so the reset-position callback closes over the right variable
makeLabel(settingsPage, "TAMPILAN GUI", UDim2.new(1, -18, 0, 24), UDim2.fromOffset(9, 6), 13).Font = Enum.Font.GothamBold
makeLabel(settingsPage, "Ringan: GUI lebih sederhana. Normal: garis aksen ungu tipis.",
    UDim2.new(1, -18, 0, 38), UDim2.fromOffset(9, 32), 10).TextColor3 = palette.muted

local modeLabel = makeLabel(settingsPage, "Mode saat ini: Normal", UDim2.new(1, -18, 0, 22), UDim2.fromOffset(9, 77), 11)
modeLabel.TextColor3 = palette.good

makeButton(settingsPage, "Mode Ringan", UDim2.new(1, -18, 0, 34), UDim2.fromOffset(9, 106), function()
    mainStroke.Transparency = 1
    pageHolder.BackgroundColor3 = Color3.fromRGB(18, 19, 31)
    header.BackgroundColor3 = Color3.fromRGB(18, 19, 31)
    modeLabel.Text = "Mode saat ini: Ringan (GUI saja)"
    setStatus("mode ringan GUI aktif")
end)

makeButton(settingsPage, "Mode Normal", UDim2.new(1, -18, 0, 34), UDim2.fromOffset(9, 147), function()
    mainStroke.Transparency = 0.22
    pageHolder.BackgroundColor3 = palette.panel
    header.BackgroundColor3 = palette.panel
    modeLabel.Text = "Mode saat ini: Normal"
    setStatus("mode normal GUI aktif")
end)

makeButton(settingsPage, "Kembalikan Posisi Menu", UDim2.new(1, -18, 0, 34), UDim2.fromOffset(9, 188), function()
    main.Position = UDim2.new(0.5, -170, 0.5, -227)
    logo.Position = UDim2.new(0, 16, 0.4, 0)
    setStatus("posisi menu dikembalikan")
end)

-- Minimized floating logo. If no image ID is configured, show a Q badge.
logo = Instance.new("ImageButton")
logo.Name = "QeeewwieFloatingLogo"
logo.Size = UDim2.fromOffset(58, 58)
logo.Position = UDim2.new(0, 16, 0.4, 0)
logo.BackgroundColor3 = palette.panel
logo.BorderSizePixel = 0
logo.AutoButtonColor = false
logo.Image = LOGO_IMAGE
logo.ScaleType = Enum.ScaleType.Crop
logo.Visible = false
logo.Parent = gui
addCorner(logo, 29)
addStroke(logo, palette.accent, 2, 0.05)

local logoText = makeLabel(logo, "Q", UDim2.fromScale(1, 1), UDim2.fromOffset(0, 0), 26)
logoText.Font = Enum.Font.GothamBold
logoText.TextXAlignment = Enum.TextXAlignment.Center
logoText.TextColor3 = palette.accent
if LOGO_IMAGE ~= "" then
    logoText.Visible = false
else
    logo.Image = ""
end

local logoDragState = makeDraggable(logo, logo)

local function minimizeGui()
    main.Visible = false
    logo.Visible = true
end

minimizeButton.Activated:Connect(minimizeGui)
logo.Activated:Connect(function()
    if logoDragState.moved then
        logoDragState.moved = false
        return
    end
    main.Visible = true
    logo.Visible = false
    setStatus("menu dibuka")
end)

-- Start on the Home page.
showPage("Home")

-- FPS counter and local session stopwatch.
local frameCount = 0
local fpsElapsed = 0
local renderConnection
renderConnection = RunService.RenderStepped:Connect(function(dt)
    if not gui.Parent then
        if renderConnection then renderConnection:Disconnect() end
        return
    end

    frameCount += 1
    fpsElapsed += dt
    if fpsElapsed >= 1 then
        fpsLabel.Text = "FPS: " .. tostring(math.floor(frameCount / fpsElapsed + 0.5))
        frameCount = 0
        fpsElapsed = 0
    end

    if sessionRunning then
        sessionElapsed += dt
        local seconds = math.floor(sessionElapsed)
        sessionLabel.Text = string.format("Durasi sesi: %02d:%02d", math.floor(seconds / 60), seconds % 60)
    end
end)
