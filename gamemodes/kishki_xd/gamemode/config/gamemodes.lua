AddCSLuaFile()

SOCIOPATHY_PROJECT.CONFIG.GAMEMODES = {
	LIST = {},
}


-- so bad because im tired of my life
SOCIOPATHY_PROJECT.CONFIG.GAMEMODES.DefaultGameModeTable = {
	ItemsSpawnList = {},
	ItemsOnGiveList = {},
	DefaultItemsOnGiveList = {},
	MonstersSpawnList = {},
	PreDraw3D = function() end,
	GameModeName = "BaseGameMode",
	OnGameModeStart = function(self) end,
	OnPlayerKeyPress = function(self) end, 
	OnGameModeFinish = function(self) end, 
}


function SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:RegisterGameMode(gm_name)
	self.LIST[gm_name] = table.Copy(SOCIOPATHY_PROJECT.CONFIG.GAMEMODES.DefaultGameModeTable)
	return self.LIST[gm_name]
end

function SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable(gm_name)
	return self.LIST[gm_name]
end


for k,v in pairs(select(2,file.Find("gamemodes/kishki_xd/gamemode/config/gamemodes/*", "GAME"))) do
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:RegisterGameMode(v)
	if CLIENT then
		include("gamemodes/"..v.."/client.lua")
	else
		AddCSLuaFile("gamemodes/"..v.."/client.lua")
		include("gamemodes/"..v.."/server.lua")
	end
end

