-- =========================================================
-- AUTO STEAL EGG (KHUSUS GAME INDONESIA - ANTI BUKA TOKO)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AutoSteal = true

-- Fungsi khusus memicu prompt dengan aman
local function safeFire(prompt)
	if not prompt or not prompt.Enabled then return end
	
	-- Picu prompt seketika
	if fireproximityprompt then
		fireproximityprompt(prompt)
	elseif prompt.InputHoldBegin then
		prompt:InputHoldBegin()
		prompt:InputHoldEnd()
	end
end

-- Loop Auto Steal
task.spawn(function()
	print("🔥 Auto Steal Khusus Game Indonesia Aktif!")
	
	while AutoSteal do
		task.wait(0.05) -- Kecepatan tinggi (20x/detik)
		
		for _, prompt in pairs(Workspace:GetDescendants()) do
			if prompt:IsA("ProximityPrompt") and prompt.Enabled then
				local action = string.lower(prompt.ActionText or "")
				local object = string.lower(prompt.ObjectText or "")
				local parentName = string.lower(prompt.Parent and prompt.Parent.Name or "")

				-- 1. FILTER KETAT: Abaikan jika ada kata Toko, Beli, Gamepass, Robux, VIP, atau Halloween Promo
				local isStore = action:find("beli") or action:find("buy") or action:find("toko") or action:find("shop") 
				                or object:find("beli") or object:find("toko") or parentName:find("shop") or parentName:find("toko")
				                or action:find("robux") or object:find("robux")

				-- 2. HANYA JALANKAN jika prompt BENAR-BENAR bertuliskan "Curi" atau "Mencuri" atau "Steal"
				local isStealPrompt = action:find("curi") or action:find("mencuri") or action:find("steal") or action:find("take")

				if isStealPrompt and not isStore then
					-- Instant Hold Bypass (0 detik tahan)
					prompt.HoldDuration = 0
					
					-- Eksekusi ambil
					safeFire(prompt)
				end
			end
		end
	end
end)
