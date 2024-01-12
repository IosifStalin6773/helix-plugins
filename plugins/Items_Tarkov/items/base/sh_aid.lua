ITEM.name = "AI-2 Medikit"
ITEM.model = Model("models/illusion/eftcontainers/ai2.mdl")
ITEM.description = "A standard service first aid kit for various defence and law enforcement agencies, notably the civil defense forces of the USSR. Mass produced, it would have been distributed to the population of the affected areas during wartime."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

-- Parámetros configurables
ITEM.healthTick = 5
ITEM.healthAmountPerTick = 5

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		-- Verifica si el temporizador ya existe antes de crear uno nuevo
		if not timer.Exists("healthRegeneration") then
			timer.Create("healthRegeneration", itemTable.healthTick, 8, function()
				for _, ply in pairs(player.GetAll()) do
					if IsValid(ply) and ply:Alive() then
						local currentHealth = ply:Health()
						local newHealth = math.min(currentHealth + itemTable.healthAmountPerTick, 100)
						ply:SetHealth(newHealth)
					end
				end
			end)
		end
	end
}
