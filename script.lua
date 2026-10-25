-- =========================================================
-- STEAL AN EGG SYSTEM (Server-Side)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Configuration
local EGG_NAME = "Egg" -- Nama Model/Part telur di Workspace
local STEAL_TIME = 1.5 -- Waktu menahan tombol "E" (detik)

-- Fungsi untuk menangani proses mencuri telur
local function setupEggInteraction(eggPart)
	if not eggPart:IsA("BasePart") and not eggPart:IsA("Model") then return end

	-- 1. Buat ProximityPrompt secara otomatis jika belum ada
	local prompt = eggPart:FindFirstChildOfClass("ProximityPrompt")
	if not prompt then
		prompt = Instance.new("ProximityPrompt")
		prompt.ObjectText = "Egg"
		prompt.ActionText = "Steal"
		prompt.HoldDuration = STEAL_TIME
		prompt.MaxActivationDistance = 8
		prompt.Parent = eggPart
	end

	-- 2. Event ketika pemain selesai menekan tombol
	local connection
	connection = prompt.Triggered:Connect(function(player)
		-- Safety Check: Pastikan player dan character ada
		if not player or not player.Character then return end

		-- Ambil Leaderstats (Opsional: Tambahkan skor/poin)
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local eggsStolen = leaderstats:FindFirstChild("Eggs")
			if eggsStolen then
				eggsStolen.Value = eggsStolen.Value + 1
			end
		end

		print(player.Name .. " berhasil mencuri telur!")

		-- Matikan prompt agar tidak bisa dicuri berkali-kali saat proses hilang
		prompt.Enabled = false

		-- Efek Animasi/Hilang (Respawn logic)
		eggPart.Transparency = 1
		if eggPart:IsA("Model") then
			for _, child in pairs(eggPart:GetDescendants()) do
				if child:IsA("BasePart") then
					child.Transparency = 1
					child.CanCollide = false
				end
			end
		else
			eggPart.CanCollide = false
		end

		-- Tunggu beberapa detik untuk Respawn telur (Contoh: 10 detik)
		task.wait(10)

		-- Respawn Telur
		eggPart.Transparency = 0
		if eggPart:IsA("Model") then
			for _, child in pairs(eggPart:GetDescendants()) do
				if child:IsA("BasePart") then
					child.Transparency = 0
					child.CanCollide = true
				end
			end
		else
			eggPart.CanCollide = true
		end
		
		prompt.Enabled = true
	end)
end

-- Cari semua Telur di Workspace saat game mulai
for _, item in pairs(Workspace:GetChildren()) do
	if item.Name == EGG_NAME then
		setupEggInteraction(item)
	end
end

-- Deteksi jika ada telur baru yang di-spawn secara dinamis
Workspace.ChildAdded:Connect(function(child)
	if child.Name == EGG_NAME then
		setupEggInteraction(child)
	end
end)
