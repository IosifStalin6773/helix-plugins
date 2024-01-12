
local PLUGIN = PLUGIN

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	local uniqueID = "ixNeeds" .. client:UniqueID()

	if (timer.Exists(uniqueID)) then
		timer.Remove(uniqueID)
	end

	timer.Create(uniqueID, ix.config.Get("needsTickTime", 300), 0, function()
		if (!IsValid(client)) then
			return
		end

		if (hook.Run("ShouldCalculatePlayerNeeds", client, character) == false) then
			return
		end

		local scale = 1
		local count = math.max(character:GetInventory():GetFilledSlotCount(), 0) / 30
		local vcsqr = client:GetVelocity():LengthSqr()
		local walkSpeed = ix.config.Get("walkSpeed")

		if (!(client:GetMoveType() == MOVETYPE_NOCLIP) and client:KeyDown(IN_SPEED) and (vcsqr >= (walkSpeed * walkSpeed))) then
			scale = scale + count
		elseif (vcsqr > 0) then
			scale = scale + count * 0.3
		else
			scale = scale + count * 0.1
		end

		if (client:Health() < 90) then
			scale = scale + 0.2
		end

		local tickTime = ix.config.Get("needsTickTime", 300)

		local hunger = math.Clamp(character:GetHunger() + 60 * scale * tickTime / (3600 * ix.config.Get("hungerHours", 6)), 0, 100)
		local thirst = math.Clamp(character:GetThirst() + 60 * scale * tickTime / (3600 * ix.config.Get("thirstHours", 4)), 0, 100)

		character:SetHunger(hunger)
		character:SetThirst(thirst)

		if (ix.config.Get("killOnMaxNeeds", false)) then
			if (hunger >= 100) then
				character:SetHunger(30)

				client:Notify("Вы умерли от голода")
				client:Kill()
			elseif (thirst >= 100) then
				character:SetThirst(30)

				client:Notify("Вы умерли от обезвоживания")
				client:Kill()
			end
		end
	end)
end

function PLUGIN:ShouldCalculatePlayerNeeds(client, character)
	local faction = ix.faction.indices[character:GetFaction()]

	if faction.noNeeds then
		return false
	end

	if (client:GetMoveType() == MOVETYPE_NOCLIP) then
		return false
	end
end
