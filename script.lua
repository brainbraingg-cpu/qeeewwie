
-- qeeewwie | GUI Update
-- GUI, FPS monitor, mode grafis, dan menu egg
-- Sistem pickup harus diimplementasikan di game milik sendiri.

    
-- Ganti callback Farm Menu dan Egg Priority
-- dengan kode berikut. Fungsi makeButton harus sudah tersedia.

local farmOptions = {
    "Auto Farm: OFF",
    "Instant Pickup: OFF"
}

local eggOptions = {
    "Divine",
    "Eternal",
    "Secret"
}

local function openMenu(titleText, options)
    local menu = Instance.new("Frame")
    menu.Size = UDim2.fromOffset(220, 200)
    menu.Position = UDim2.new(0.5, -110, 0.5, -100)
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 48)
    menu.Parent = gui

    local heading = Instance.new("TextLabel")
    heading.Size = UDim2.new(1, 0, 0, 35)
    heading.Text = titleText
    heading.TextScaled = true
    heading.TextColor3 = Color3.new(1, 1, 1)
    heading.BackgroundTransparency = 1
    heading.Parent = menu

    for i, option in ipairs(options) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -16, 0, 35)
        button.Position = UDim2.fromOffset(8, 38 + (i - 1) * 40)
        button.Text = option
        button.TextScaled = true
        button.Parent = menu

        button.Activated:Connect(function()
            status.Text = "Dipilih: " .. option
        end)
    end

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(1, -16, 0, 28)
    close.Position = UDim2.new(0, 8, 1, -32)
    close.Text = "Tutup"
    close.Parent = menu
    close.Activated:Connect(function()
        menu:Destroy()
    end)
end

-- Hubungkan ke tombol menu yang sudah ada:
-- Farm Menu:
-- openMenu("Farm Menu", farmOptions)
--
-- Egg Priority:
-- openMenu("Egg Priority", eggOptions)

