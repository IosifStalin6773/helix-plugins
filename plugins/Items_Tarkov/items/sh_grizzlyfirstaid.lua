ITEM.name = "Grizzly First Aid Kit"
ITEM.model = Model("models/illusion/eftcontainers/grizzly.mdl")
ITEM.description = "The Grizzly Medical kit is considered one of the best first aid kits on the market. It contains everything necessary to provide timely medical care in extreme conditions."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true
ITEM.width = 2
ITEM.height = 2

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:GetMaxHealth(), client:GetMaxHealth()))
	end
}