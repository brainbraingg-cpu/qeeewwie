-- =============================================
-- Auto Steal Egg Khusus Game Steal Egg Milikmu
-- Hanya berjalan di server game kamu sendiri
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local isStealActive = false
local STEAL_RANGE = 18 -- Jarak maksimal deteksi telur

-- Fungsi utama auto steal egg
local function stealLoop()
 while isStealActive and character and humanoid do
 task.wait(0.6) -- Jeda natural agar tidak terlihat seperti bot

 local root = character:FindFirstChild("HumanoidRootPart")
 if not root then continue end

 -- Cari semua telur yang tersedia di sekitar
 local allEggs = workspace:GetPartBoundsInRadius(root.Position, STEAL_RANGE)
 local targetEgg = nil
 local highestValue = 0

 -- Pilih telur dengan nilai tertinggi terdekat
 for _, egg in allEggs do
 if egg:GetAttribute("IsEgg") and egg:GetAttribute("CanBeStolen") then
 local eggValue = egg:GetAttribute("Value") or 1
 if eggValue > highestValue then
 highestValue = eggValue
 targetEgg = egg
 end
 end
 end

 -- Jika ditemukan telur target, jalankan aksi steal
 if targetEgg then
 humanoid:MoveTo(targetEgg.Position)
 task.wait(0.4)

 -- Jalankan event steal sisi server yang sudah kamu buat
 game.ReplicatedStorage.StealEggEvent:FireServer(targetEgg)
 print("Berhasil mencuri telur nilai: " .. highestValue)
 end
 end
end

-- Hubungkan dengan tombol toggle di GUI
StealEggToggle.MouseButton1Click:Connect(function()
 isStealActive = not isStealActive
 if isStealActive then
 task.spawn(stealLoop)
 StealEggToggle.BackgroundColor3 = Color3.fromHex("#10b981")
 else
 StealEggToggle.BackgroundColor3 = Color3.fromHex("#333340")
 end
end)

-- Perbaiki status saat karakter respawn
player.CharacterAdded:Connect(function(newChar)
 character = newChar
 humanoid = newChar:WaitForChild("Humanoid")
end)
