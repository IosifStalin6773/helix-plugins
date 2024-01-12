ITEM.name = "Medkit Pruebas"
ITEM.model = Model("models/illusion/eftcontainers/ai2.mdl")
ITEM.description = "Objeto Medico Basado en el sistema de tarkov (Simplificado)"
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

-- Parámetros configurables de tiempo y cantidad de curación
ITEM.healthTick = 5
ITEM.healthAmountPerTick = 5

-- Nuevos parámetros para stamina
ITEM.staminaTick = 5
ITEM.staminaAmountPerTick = 10 -- Ajusta según tus necesidades

-- Tiempo antes de restablecer los valores por defecto (en segundos)
ITEM.resetTime = 60

ITEM.functions.Apply = {
    OnRun = function(item)
		item.player:AddPowerUp("PowerUp_staminarestore", 50, { amount = 2.5 })
		item.player:AddPowerUp("PowerUp_slowheal", 4, { amount = item.restore/4 })
		--item.player:AddPowerUp("PowerUp_adrenalinerunspeed", 50, { })
		--item.player:AddPowerUp("PowerUp_adrenalinepunchdamage", 50, { })
	end
}