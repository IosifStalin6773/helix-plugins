ITEM.name = "Analgin Painkillers"
ITEM.model = Model("models/illusion/eftcontainers/painkiller.mdl")
ITEM.description = "The most cheap and widely spread painkillers, there is some debate about how much they actually help."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 15, client:GetMaxHealth()))
	end
}