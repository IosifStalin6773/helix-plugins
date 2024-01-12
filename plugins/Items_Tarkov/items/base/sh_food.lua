
ITEM.name = "Scran"
ITEM.model = Model("models/props_junk/garbage_takeoutcarton001a.mdl")
ITEM.description = "A base for consumables."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "food"

ITEM.useSound = {"npc/barnacle/barnacle_crunch3.wav", "npc/barnacle/barnacle_crunch2.wav"}

ITEM.hunger = 0
ITEM.thirst = 0
ITEM.health = 0
ITEM.damage = 0
ITEM.spoilTime = 14

ITEM.colorAppendix = {}

function ITEM:GetName()
	if (self:GetSpoiled()) then
		local spoilText = self.spoilText or "(consentido)"
		return spoilText.." "..self.name
	end

	return self.name
end

function ITEM:GetDescription()
	local description = {self.description}
	if (!self:GetSpoiled() and self:GetData("spoilTime")) then
		local spoilTime = math.floor((self:GetData("spoilTime") - os.time()) / 60)
		local text = " minutos."
		if (spoilTime > 60) then
			text = " horas."
			spoilTime = math.floor(spoilTime / 60)
		end

		if (spoilTime > 24) then
			text = " dias."
			spoilTime = math.floor(spoilTime / 24)
		end

		description[#description + 1] = "\nse echará a perder "..spoilTime..text
	end

	return table.concat(description, "")
end

function ITEM:GetBoostAppend()
	local boostAppend = {}
	if (self.boosts) then
		boostAppend[#boostAppend + 1] = "IMPULSOS A LARGO PLAZO:\n"

		if (self.boosts.strength) then
			boostAppend[#boostAppend + 1] = string.format("Fuerza: %d\n", self.boosts.strength)
		end
		if (self.boosts.agility) then
			boostAppend[#boostAppend + 1] = string.format("Agilidad: %d\n", self.boosts.agility)
		end
		if (self.boosts.intelligence) then
			boostAppend[#boostAppend + 1] = string.format("Inteligencia: %d\n", self.boosts.intelligence)
		end
		if (self.boosts.perception) then
			boostAppend[#boostAppend + 1] = string.format("Percepción: %d", self.boosts.perception)
		end
	end

	return table.concat(boostAppend, "")
end

function ITEM:GetColorAppendix()
	return {["yellow"] = self:GetBoostAppend()}
end

function ITEM:GetSpoiled()
	local spoilTime = self:GetData("spoilTime")
	if (!spoilTime) then
		return false
	end

	return os.time() > spoilTime
end

ITEM.functions.Consume = {
	name = "Употребить",
	OnRun = function(item)
		local client = item.player
		local character = item.player:GetCharacter()
		local bSpoiled = item:GetSpoiled()

		if (item.damage > 0) then
			client:TakeDamage(item.damage, client, client)
		end

		-- Spawn the junk item if it exists
		if (item.junk) then
			if (!character:GetInventory():Add(item.junk)) then
				ix.item.Spawn(item.junk, client)
			end
		end

		if (item.useSound) then
			if (istable(item.useSound)) then
				client:EmitSound(table.Random(item.useSound))
			else
				client:EmitSound(item.useSound)
			end
		end

		if (!bSpoiled) then
			if (item.thirst > 0) then
				character:SetThirst(math.Clamp(character:GetThirst() - item.thirst, 0, 100))
			end

			if (item.hunger > 0) then
				character:SetHunger(math.Clamp(character:GetHunger() - item.hunger, 0, 100))
			end

			if (item.health > 0) then
				client:SetHealth(math.Clamp(client:Health() + item.health, 0, client:GetMaxHealth()))
			end

			if (item.boosts) then
				for k, v in pairs(item.boosts) do
					character:SetSpecialBoost(k, v, false)
				end
			end
		end
	end
}

function ITEM:OnInstanced()
	if (self.spoil) then
		self:SetData("spoilTime", os.time() + 24 * 60 * 60 * self.spoilTime)
	end
end