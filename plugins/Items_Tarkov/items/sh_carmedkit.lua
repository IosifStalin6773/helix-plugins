ITEM.name = "Car First Aid Kit"
ITEM.model = Model("models/illusion/eftcontainers/carmedkit.mdl")
ITEM.description = "Universally forgotten about in the trunk of your car, this first aid kit is a crucial protective measure in the event of an emergency on the road."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true
ITEM.width = 2
ITEM.height = 1

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 70, client:GetMaxHealth()))
	end
}