ITEM.name = "IFAK Tactical Aid Kit"
ITEM.model = Model("models/illusion/eftcontainers/ifak.mdl")
ITEM.description = "The personal medical kit issued to soldiers during their service. It is very well-designed and rich in contents."
ITEM.category = "Medical"
ITEM.bDropOnDeath = true

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 80, client:GetMaxHealth()))
	end
}