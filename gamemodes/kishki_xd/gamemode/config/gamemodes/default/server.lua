local GameModeTable = SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("default")



GameModeTable.ItemsSpawnList['item_retroxc'] = true
GameModeTable.ItemsSpawnList['item_radio'] = true
GameModeTable.ItemsSpawnList['item_minihealer'] = true
GameModeTable.ItemsSpawnList['item_lighter'] = true
GameModeTable.ItemsSpawnList['item_healer'] = true
GameModeTable.ItemsSpawnList['item_gasmask'] = true
GameModeTable.ItemsSpawnList['item_camera'] = true
GameModeTable.ItemsSpawnList['item_emp'] = true



GameModeTable.ItemsOnGiveList['item_gasmask'] = true
GameModeTable.ItemsOnGiveList['item_camera'] = true
GameModeTable.ItemsOnGiveList['item_emp'] = true



GameModeTable.DefaultItemsOnGiveList['item_lighter'] = true


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

	SOCIOPATHY_PROJECT.Quests:GenerateUsefulItems(GameModeTable.ItemsSpawnList)
	if !is_record_game then
		SOCIOPATHY_PROJECT.Quests:GenerateTasks()
	end

end