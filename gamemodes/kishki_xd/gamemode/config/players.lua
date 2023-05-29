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

for k,v in pairs(file.Find("gamemodes/kishki_xd/gamemode/config/gameplayers/*.lua", "GAME")) do
	local item_path = "gameplayers/" .. v 
	AddCSLuaFile(item_path)
	include(item_path)
end
