local PLUGIN = PLUGIN

PLUGIN.name = "Tarkov Item Scripts"
PLUGIN.author = "TommyGman"
PLUGIN.description = "Adds many scripts from Escape From Tarkov, ranging from medical items, food and drink, storage solutions, electrical components and valuables."

-- 'If Rabid taught me anything, it's that I don't need guns to roleplay...'
-- 'Rabid was also full of shit' - Pyromancer
-- sv_hunger_thirst.lua

-- Configuración para el sistema de hambre
ix.char.RegisterVar("hunger", {
	field = "hunger",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true
})

ix.char.RegisterVar("thirst", {
	field = "thirst",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true
})

ix.config.Add("killOnMaxNeeds", false, "Habilita la muerte a los jugadores después de alcanzar el máximo de sed o hambre.", nil, {
	category = "needs"
})

ix.config.Add("hungerHours", 6, "¿Cuántas horas le tomará al jugador reducir el hambre a 60", nil, {
	data = {min = 1, max = 24},
	category = "needs"
})

ix.config.Add("thirstHours", 4, "¿Cuántas horas le tomará al jugador reducir el hambre a 60", nil, {
	data = {min = 1, max = 24},
	category = "needs"
})

ix.config.Add("needsTickTime", 300, "Cuántos segundos entre cada jugador necesita cálculo", nil, {
	data = {min = 60, max = 300},
	category = "needs"
})

ix.util.Include("sv_hooks.lua")

ix.command.Add("CharSetHunger", {
	description = "Establecer el hambre del personaje",
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, character, level)
		character:SetHunger(level)
		client:Notify(character:GetName().."'s el hambre se puso  "..level)
	end
})

ix.command.Add("CharSetThirst", {
	description = "Establecer sed de carácter",
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, character, level)
		character:SetThirst(level)
		client:Notify(character:GetName().." la lujuria estaba puesta "..level)
	end
})

local CHAR = ix.meta.character

function CHAR:GetMaxStamina()
	local hunger, thirst = self:GetHunger(), self:GetThirst()
	local stamina = 100

	if (hunger > 50) then
		stamina = stamina - (hunger >= 100 and 30 or 15)
	end

	if (thirst > 50) then
		stamina = stamina - (thirst >= 100 and 30 or 15)
	end

	return stamina
end

if CLIENT then
    ix.bar.Add(function()
        local hunger = LocalPlayer():GetLocalVar("hunger") or 0
        return math.max(hunger / 100, 0)
    end, Color(255, 0, 0), nil, "hunger", "hudhunger")  -- Rojo para la barra de hambre

    ix.bar.Add(function()
        local thirst = LocalPlayer():GetLocalVar("thirst") or 0
        return math.max(thirst / 100, 0)
    end, Color(0, 255, 0), nil, "thirst", "hudthirst")  -- Verde para la barra de sed
end

