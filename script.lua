
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local STEAL_RANGE = 18
local SCAN_DELAY = 0.6

local active = false
local sessionId = 0

local character
local humanoid
local rootPart

local function updateCharacter(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
end

if player.Character then
    updateCharacter(player.Character)
end

player.CharacterAdded:Connect(updateCharacter)

-- Cari RemoteEvent yang dibuat oleh server game milikmu.
local stealEvent = ReplicatedStorage:WaitForChild("StealEggEvent")

-- Pastikan tombol ini sudah dibuat di GUI milikmu.
local panel = playerGui:WaitForChild("QeeewwiePanel")
local toggle = panel:FindFirstChild("StealEggToggle", true)

assert(toggle and toggle:IsA("GuiButton"),
    "Buat GuiButton bernama StealEggToggle terlebih dahulu")

local function getEggPosition(egg)
    if egg:IsA("BasePart") then
        return egg.Position
    elseif egg:IsA("Model") then
        return egg:GetPivot().Position
    end
    return nil
end

local function findBestEgg()
    if not rootPart or not rootPart.Parent then
        return nil
    end

    local bestEgg
    local bestValue = -math.huge
    local bestDistance = math.huge

    for _, object in ipairs(workspace:GetDescendants()) do
        if object:GetAttribute("IsEgg") == true
            and object:GetAttribute("CanBeStolen") == true then

            local position = getEggPosition(object)

            if position then
                local distance = (rootPart.Position - position).Magnitude

                if distance <= STEAL_RANGE then
                    local value = tonumber(object:GetAttribute("Value")) or 1

                    -- Prioritas nilai tertinggi, lalu jarak terdekat.
                    if value > bestValue
                        or (value == bestValue and distance < bestDistance) then
                        bestEgg = object
                        bestValue = value
                        bestDistance = distance
                    end
                end
            end
        end
    end

    return bestEgg
end

local function runAutoSteal(mySession)
    while active and sessionId == mySession do
        task.wait(SCAN_DELAY)

        if not character or not character.Parent
            or not humanoid or humanoid.Health <= 0
            or not rootPart or not rootPart.Parent then
            continue
        end

        local egg = findBestEgg()

        if egg and egg.Parent then
            local position = getEggPosition(egg)

            if position then
                humanoid:MoveTo(position)

                -- Tunggu sebentar, lalu periksa kembali jarak.
                task.wait(0.4)

                if not active or sessionId ~= mySession then
                    break
                end

                if egg.Parent and rootPart and rootPart.Parent then
                    local currentPosition = getEggPosition(egg)

                    if currentPosition
                        and (rootPart.Position - currentPosition).Magnitude
                            <= STEAL_RANGE then
                        -- Server wajib memvalidasi permintaan ini.
                        stealEvent:FireServer(egg)
                    end
                end
            end
        end
    end
end

toggle.Activated:Connect(function()
    active = not active
    sessionId += 1

    toggle.BackgroundColor3 = active
        and Color3.fromRGB(16, 185, 129)
        or Color3.fromRGB(51, 51, 64)

    if active then
        local mySession = sessionId
        task.spawn(runAutoSteal, mySession)
    end
end)

print("Auto Steal controller loaded.")
