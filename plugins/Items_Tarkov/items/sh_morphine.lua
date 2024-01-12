ITEM.name = "Morphine Injector"
ITEM.model = Model("models/illusion/eftcontainers/morphine.mdl")
ITEM.description = "Single-use syringe full of morphine - A powerful but addictive drug used primarily to treat both acute and severe pain."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 50, client:GetMaxHealth()))
	end
}