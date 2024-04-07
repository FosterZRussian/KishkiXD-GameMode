local GameModeTable = SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("sonarium")

GameModeTable.ItemsSpawnList = {
	['item_sonar'] = true,
}

GameModeTable.DefaultItemsOnGiveList['item_sonar'] = true

GameModeTable.QuestItemsSpawnList = {}

function GameModeTable:OnGameModeStart(is_record_game)

	local _ ,key = table.Random(GameModeTable.MonstersSpawnList)

	if timer.Exists("spawnmonster") then
		timer.Remove("spawnmonster")
	end

	local spawn_tiemr = math.random(20,100)
	if is_record_game then
		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster(key)
	else
		timer.Create("spawnmonster", spawn_tiemr , 1, function()
			SOCIOPATHY_PROJECT.GameLogic:SpawnMonster(key)
		end)
	end
	
	game.GetWorld():SetNWBool("IsQuest_Mode", !is_record_game)

	if !is_record_game then
		SOCIOPATHY_PROJECT.Quests:GenerateTasks()
	end

end