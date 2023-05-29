local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "hunter_rabbit"

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.values.Render_Material = Material("materials/kishkixd/monsters/hunter_3.png")
ItemConfig.MetaData.ItemIcon = Material("materials/kishkixd/monsters/hunter_3.png")



SOCIOPATHY_PROJECT.Sounds.List["nightmare-factory"] = {
	path = "ambient/617140__beetlemuse__nightmare-factory.mp3",
	channel = 166,
	duration = 41,
	pitch = 100,
}

-- ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.NoiseSound = nil
ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.EnemyChaseAmbientSound = "nightmare-factory"

-- ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry = nil
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle = nil
--[[ ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].path = "fosterz/kishkixd/objects/2gasmask.wav"
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].time = 11--]] 

ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1] = {
	path = "fosterz/kishkixd/horrorstuff/263708__scotcampbell__clown-laugh.mp3",
	time = 4,
}

ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackCT = .5
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDist = 150
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackTimeMemory = 8
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDamage = 15
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackSounds = {
	[1] = "fosterz/kishkixd/damage/knife_1.mp3",
	[2] = "fosterz/kishkixd/damage/knife_2.mp3",
	[3] = "fosterz/kishkixd/damage/knife_3.mp3",
	[4] = "fosterz/kishkixd/damage/knife_4.mp3",
	[5] = "fosterz/kishkixd/damage/knife_5.mp3",
	[6] = "fosterz/kishkixd/damage/knife_6.mp3",
}




SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(ItemConfig)

if SERVER then
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("default").MonstersSpawnList["hunter_rabbit"] = true
end