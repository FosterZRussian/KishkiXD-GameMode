local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "krestianin_s_kopyem"

ItemConfig.MetaData.ItemIcon = Material("materials/kishkixd/monsters/theghost.png")



SOCIOPATHY_PROJECT.Sounds.List["nightmare-factory"] = {
	path = "ambient/617140__beetlemuse__nightmare-factory.mp3",
	channel = 166,
	duration = 41,
	pitch = 100,
}


local DefOnSpawnMethod = ItemConfig.ItemData.SystemValues.LogicMethods.OnSpawn.func
ItemConfig.ItemData.SystemValues.LogicMethods.OnSpawn.func = function(method_values, shared_values, object_table, on_call_values)
	DefOnSpawnMethod(method_values, shared_values, object_table, on_call_values)
	if _G.KishkiXD_SpawnMainMonster then		
		_G.KishkiXD_SpawnMainMonster = false

		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster("krestianin_ne_s_kopyem")
		
		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster("krestianin_s_kopyem")
		
		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster("krestianin_ne_s_kopyem")

		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster("krestianin_s_kopyem")

		SOCIOPATHY_PROJECT.GameLogic:SpawnMonster("krestianin_ne_s_kopyem")
	end
end


ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.func = function(method_values, shared_values, object_table, on_call_values)
	local ent = object_table.Entity
	local eye_ang = ent:GetAngles()


	ent.img = ent.img or math.random(1, #shared_values._RenderMats)

	local Render_Material = shared_values._RenderMats[ent.img]

	cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y +90,90) ,1)
		surface.SetDrawColor(150,150,150)
		surface.SetMaterial(Render_Material)
		surface.DrawTexturedRect(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y)		
	cam.End3D2D() 
	cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y + 270,90) ,1)
		surface.SetDrawColor(0,0,0)
		surface.SetMaterial(Render_Material)
		surface.DrawTexturedRectUV(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y, 1,0,0,1)		
	cam.End3D2D()
end

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDrawInCamera.func = ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.func

ItemConfig.ItemData.SystemValues.SharedValues._RenderMats = {
	[1] = Material("materials/kishkixd/monsters/theghost.png", "smooth"),
	[2] = Material("materials/kishkixd/monsters/theghost_krestyanin_s_kopiem.png", "smooth"),
	[3] = Material("materials/kishkixd/monsters/theghost_krestyanin_s_vilami.png", "smooth"),
}




-- ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.NoiseSound = nil
ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.EnemyChaseAmbientSound = "nightmare-factory"

-- ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry = nil
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle = nil
--[[ ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].path = "fosterz/kishkixd/objects/2gasmask.wav"
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].time = 11--]] 

ItemConfig.ItemData.SystemValues.SharedValues.SpeedForce = .9

ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1] = {
	path = "fosterz/kishkixd/ghost/588668__thepig01__you-will-die.wav",
	time = 4,
	time_max = 7,
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
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("default").MonstersSpawnList[ItemConfig.ItemData.SystemName] = true
end