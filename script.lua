-- =========================================================
-- AUTO STEAL EGG (ANTI-LAG & ANTI-TOKO / SMOOTH VERSION)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AutoSteal = true

task.spawn(function()
	print("🔥 Auto Steal Anti-Lag Aktif!")
	
	while AutoSteal do
		-- Jeda diperbesar sedikit jadi 0.3 detik agar game tidak berat/patah-patah
		task.wait(0.3)
		
		-- Cek hanya objek yang ada di Workspace secara langsung atau dalam folder tertentu (jauh lebih ringan)
		for _, item in pairs(Workspace:GetChildren()) do
			local nameLower = string.lower(item.Name)
			
			-- Jika menemukan model/part telur di map
			if nameLower:find("egg") or nameLower:find("telur") then
				local prompt = item:FindFirstChildOfClass("ProximityPrompt")
				
				-- Jika prompt tidak ada di luar, cari di dalam anak komponennya (descendants terbatas)
				if not prompt then
					for _, child in pairs(item:GetDescendants()) do
						if child:IsA("ProximityPrompt") then
							prompt = child
							break
						end
					end
				end
				
				-- Eksekusi jika prompt ditemukan dan aktif
				if prompt and prompt.Enabled then
					-- Pastikan bukan bagian dari toko
					local fullName = string.lower(item:GetFullName())
					if not fullName:find("shop") and not fullName:find("toko") and not fullName:find("gamepass") then
						prompt.HoldDuration = 0
						
						if fireproximityprompt then
							fireproximityprompt(prompt)
						end
					end
				end
			end
		end
	end
end)
