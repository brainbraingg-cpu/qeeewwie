-- =========================================================
-- ULTRA FAST AUTO STEAL EGG (STRICT ANTI-TOKO ROBUX)
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local AutoSteal = true

-- Daftar kata terlarang (Jangan pernah di-trigger)
local BlacklistText = {"buy", "toko", "shop", "pass", "robux", "gandakan", "kecepatan", "boost", "vip"}

-- Fungsi cek apakah prompt aman
local function isSafePrompt(prompt)
	local action = string.lower(prompt.ActionText or "")
	local object = string.lower(prompt.ObjectText or "")
	local parentName = string.lower(prompt.Parent and prompt.Parent.Name or "")

	-- 1. Cek kata-kata blacklist
	for _, word in ipairs(BlacklistText) do
		if action:find(word) or object:find(word) or parentName:find(word) then
			return false
		end
	end

	-- 2. Wajib mengandung kata kunci telur/steal/curi
	if action:find("steal") or action:find("curi") or action:find("take") or action:find("ambil")
		or object:find("egg") or object:find("telur") or parentName:find("egg") or parentName:find("telur") then
		return true
	end

	return false
end

-- Loop Auto Steal
task.spawn(function()
	print("🔥 Auto Steal Anti-Toko Aktif!")
	while AutoSteal do
		task.wait(0.05)
		
		for _, prompt in pairs(Workspace:GetDescendants()) do
			if prompt:IsA("ProximityPrompt") and prompt.Enabled then
				if isSafePrompt(prompt) then
					-- Instant Hold Bypass
					prompt.HoldDuration = 0
					
					-- Teleport sedikit mendekat jika perlu (biar prompt bisa dipicu)
					if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local promptPos = prompt.Parent:IsA("BasePart") and prompt.Parent.Position or prompt.Parent:GetPivot().Position
						-- Picu ProximityPrompt
						if fireproximityprompt then
							fireproximityprompt(prompt)
						end
					end
				end
			end
		end
	end
end)
