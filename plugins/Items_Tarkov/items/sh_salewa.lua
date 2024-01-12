ITEM.name = "Salewa First Aid Kit"
ITEM.model = Model("models/illusion/eftcontainers/salewa.mdl")
ITEM.description = "A civilian first aid kit containing various types of bandages and dressing tools."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true
ITEM.width = 1
ITEM.height = 2

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 60, client:GetMaxHealth()))
	end
}