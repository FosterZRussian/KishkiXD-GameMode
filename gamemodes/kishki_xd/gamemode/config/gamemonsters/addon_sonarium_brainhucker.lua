local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "hunter_sonarium_1"

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.values.Render_Material = Material("materials/kishkixd/players/addon_sonarium_pm.png")
ItemConfig.MetaData.ItemIcon = Material("materials/kishkixd/players/addon_sonarium_pm.png")



SOCIOPATHY_PROJECT.Sounds.List["brainHemorrhageStage2"] = {
	path = "addon_sonarium/base_sonarium/m/brainHemorrhageStage4.mp3",
	channel = 166,
	duration = 5,
	pitch = 100,
}

-- ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.NoiseSound = nil
ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.EnemyChaseAmbientSound = "brainHemorrhageStage2"

-- ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry = nil
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle[1] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitMedium1.mp3",
	time =84,
}
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle[2] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitMedium2.mp3",
	time =84,
}
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle[3] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitMedium3.mp3",
	time =84,
}
--[[ ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].path = "fosterz/kishkixd/objects/2gasmask.wav"
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].time = 11--]] 


ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitVeryClose1.mp3",
	time = 1,
}
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[2] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitVeryClose2.mp3",
	time = 1,
}
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[3] = {
	path = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingSuitVeryClose3.mp3",
	time = 1,
}


ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackCT = 2
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDist = 150
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackTimeMemory = 8
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDamage = 30
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackSounds = {
	[1] = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingWaterVeryClose1.mp3",	
	[2] = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingWaterVeryClose1.mp3",	
	[3] = "fosterz/kishkixd/addon_sonarium/base_sonarium/m/sonarPingWaterVeryClose1.mp3",	
}



SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(ItemConfig)


if SERVER then
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("sonarium").MonstersSpawnList["hunter_sonarium_1"] = true
end