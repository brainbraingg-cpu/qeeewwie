-- =========================================================
-- AUTO STEAL EGG (ONE-CLICK / LIGHTWEIGHT VERSION)
-- =========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local successCount = 0

-- Cari telur terdekat dalam radius 50 meter secara instan (tanpa loop berat)
for _, item in pairs(Workspace:GetDescendants()) do
	local nameLower = string.lower(item.Name)
	if nameLower:find("egg") or nameLower:find("telur") then
		local prompt = item:FindFirstChildOfClass("ProximityPrompt")
		if not prompt then
			for _, child in pairs(item:GetDescendants()) do
				if child:IsA("ProximityPrompt") then
					prompt = child
					break
				end
			end
		end
		
		if prompt and prompt.Enabled then
			local fullName = string.lower(item:GetFullName())
			-- Pastikan bukan toko/gamepass
			if not fullName:find("shop") and not fullName:find("toko") and not fullName:find("gamepass") then
				-- Cek jarak supaya tidak mengambil yang terlalu jauh
				local partPos = item:IsA("BasePart") and item.Position or (item.PrimaryPart and item.PrimaryPart.Position)
				if partPos and (rootPart.Position - partPos).Magnitude <= 60 then
					prompt.HoldDuration = 0
					if fireproximityprompt then
						fireproximityprompt(prompt)
						successCount = successCount + 1
					end
				end
			end
		end
	end
end

print("🔥 Berhasil mengambil " .. successCount .. " telur di sekitar!")
