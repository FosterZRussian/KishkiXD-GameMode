local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "hunter_masyna"

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.values.Render_Material = Material("materials/kishkixd/monsters/hunter_5.png")



-- ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.NoiseSound = nil
ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.EnemyChaseAmbientSound = nil


ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle = nil

ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].path = "fosterz/kishkixd/masyna/2Stick your finger in my ass.mp3"
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].time = 2 

ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackCT = .5
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDist = 150
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackTimeMemory = 8
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackDamage = 0--15
ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.values.AttackSounds = {
	[1] = "fosterz/kishkixd/masyna/2Orgasm 1.mp3",
	[2] = "fosterz/kishkixd/masyna/2WOO.mp3",
}





local def_method_eff = ItemConfig.ItemData.SystemValues.RenderMethods.OnDrawEffects.func
ItemConfig.ItemData.SystemValues.RenderMethods.OnDrawEffects.func = function(method_values, shared_values, object_table, on_call_values) 

	def_method_eff(method_values, shared_values, object_table, on_call_values)


	-- on_call_values.SCR_W, on_call_values.SCR_H, on_call_values.nowFrameLerping, on_call_values.CAN_UPDATE, on_call_values.STRESS_LEVEL
	local SCR_W = on_call_values.SCR_W
	local SCR_H = on_call_values.SCR_H
	local nowFrameLerping = on_call_values.nowFrameLerping
	local CAN_UPDATE = on_call_values.CAN_UPDATE
	local STRESS_LEVEL = on_call_values.STRESS_LEVEL
	local min_enemy = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy
	local min_enemy_dist = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist
	if min_enemy != nil && min_enemy_dist < 800 then
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material("materials/kishkixd/ui/scream.png"))
		surface.DrawTexturedRect(0,0,ScrW(),ScrH())
	end
end


-- SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(ItemConfig)