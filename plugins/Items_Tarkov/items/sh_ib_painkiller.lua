ITEM.name = "Ibuprofen Painkillers"
ITEM.model = Model("models/illusion/eftcontainers/ibuprofen.mdl")
ITEM.description = "The nonsteroidal anti-inflammatory drug (NSAID) Ibuprofen, used for treating pain, fever, and inflammation."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 20, client:GetMaxHealth()))
	end
}