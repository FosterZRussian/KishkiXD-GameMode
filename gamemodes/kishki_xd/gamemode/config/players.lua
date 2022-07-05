AddCSLuaFile()

SOCIOPATHY_PROJECT.CONFIG.PLAYERS = {}
SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION = {}

function SOCIOPATHY_PROJECT:RegisterPlayer(new_table)
	SOCIOPATHY_PROJECT.CONFIG.PLAYERS[new_table.system_name] = new_table
	SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION[new_table.index_key] = SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION[new_table.index_key] or {}
	SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION[new_table.index_key][#SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION[new_table.index_key]+1] = new_table.system_name
end
function SOCIOPATHY_PROJECT:GetPlayerClass(id)
	return SOCIOPATHY_PROJECT.CONFIG.PLAYERS[id]
end



SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_1",
	system_name = "char_1",
	index_key = "unlocked",
})

SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_2", 
	system_name = "char_2",
	index_key = "unlocked",
})

SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_3", 
	system_name = "char_3",
	index_key = "cerber",
})

SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_4", 
	system_name = "char_4",
	index_key = "biker",
})

SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_5", 
	system_name = "char_5",
	index_key = "unlocked",
})


SOCIOPATHY_PROJECT:RegisterPlayer({
	character_image = "playermodel_6", 
	system_name = "char_6",
	index_key = "masyna",
})

