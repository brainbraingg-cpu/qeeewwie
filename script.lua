-- =========================================================
-- AUTO STEAL EGG (ULTRA FAST / NO HOLD / TELEPORT INTERACT)
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local AutoStealEnabled = true

-- Fungsi untuk langsung memicu ProximityPrompt tanpa delay (Bypass Hold Duration)
local function firePrompt(prompt)
	if not prompt or not prompt.Parent then return end
	
	-- Bypass Hold Duration sementara di client
	local originalHold = prompt.HoldDuration
	prompt.HoldDuration = 0
	
	-- Picu event interaksi ProximityPrompt
	if fireproximityprompt then
		fireproximityprompt(prompt)
	elseif prompt.InputHoldBegin then
		prompt:InputHoldBegin()
		prompt:InputHoldEnd()
	end
	
	-- Kembalikan settingan asli (opsional)
	prompt.HoldDuration = originalHold
end

-- Fungsi utama pengumpul telur otomatis
local function autoStealLoop()
	task.spawn(function()
		while AutoStealEnabled do
			task.wait(0.05) -- Loop kencang (20x per detik)
			
			-- Cari semua ProximityPrompt yang ada di game
			for _, prompt in pairs(Workspace:GetDescendants()) do
				if prompt:IsA("ProximityPrompt") and prompt.Enabled then
					
					-- Cek apakah prompt berhubungan dengan "Egg" atau "Telur"
					local objectName = string.lower(prompt.ObjectText or "")
					local actionName = string.lower(prompt.ActionText or "")
					local parentName = string.lower(prompt.Parent.Name or "")
					
					if parentName:find("egg") or parentName:find("telur") 
					or objectName:find("egg") or objectName:find("telur")
					or actionName:find("steal") or actionName:find("curi") or actionName:find("take") then
						
						-- Eksekusi ambil telur seketika
						firePrompt(prompt)
					end
				end
			end
		end
	end)
end

-- Jalankan Script
print("🔥 AUTO STEAL EGG AKTIF!")
autoStealLoop()
