-- =========================================================
-- AUTO STEAL EGG (TARGETED MODEL/PART SCANNER - AMAN DARI TOKO)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AutoSteal = true

-- Fungsi untuk mencari dan mengambil telur secara spesifik
task.spawn(function()
	print("🔥 Auto Steal Target Mode Aktif!")
	
	while AutoSteal do
		task.wait(0.1)
		
		-- Cari di seluruh isi Workspace
		for _, obj in pairs(Workspace:GetDescendants()) do
			-- Filter: Pastikan objek adalah Part atau Model dan namanya mengandung "egg" atau "telur"
			-- (Kecuali yang ada di dalam folder toko/shop)
			local nameLower = string.lower(obj.Name)
			
			if (nameLower:find("egg") or nameLower:find("telur")) then
				-- Cek apakah objek ini punya ProximityPrompt di dalamnya
				local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
				if not prompt and obj:IsA("BasePart") then
					prompt = obj.Parent and obj.Parent:FindFirstChildOfClass("ProximityPrompt")
				end
				
				-- Jika ketemu prompt di dalam objek telur tersebut, eksekusi!
				if prompt and prompt.Enabled then
					-- Pastikan parent-nya bukan bagian dari Shop/Toko
					local fullName = string.lower(obj:GetFullName())
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
