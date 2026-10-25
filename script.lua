-- =========================================================
-- SAFE AUTO STEAL EGG (TIDAK MEMBUKA TOKO ROBUX)
-- =========================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local AutoSteal = true

task.spawn(function()
	while AutoSteal do
		task.wait(0.1)
		
		for _, prompt in pairs(Workspace:GetDescendants()) do
			if prompt:IsA("ProximityPrompt") and prompt.Enabled then
				
				-- Ambil teks interaksi
				local actionText = string.lower(prompt.ActionText or "")
				local objectText = string.lower(prompt.ObjectText or "")
				
				-- PASTIKAN BUKAN PROMPT PEMBELIAN (ROBUX / GAMEPASS / BUY)
				local isRobuxPrompt = actionText:find("buy") or actionText:find("pass") or actionText:find("robux") or objectText:find("buy")
				
				-- Hanya eksekusi jika prompt bertuliskan Curi / Steal / Take dan BUKAN Robux
				if not isRobuxPrompt then
					if actionText:find("steal") or actionText:find("curi") or actionText:find("take") or objectText:find("egg") or objectText:find("telur") then
						if fireproximityprompt then
							fireproximityprompt(prompt)
						end
					end
				end
			end
		end
	end
end)
