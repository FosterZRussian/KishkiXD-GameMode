local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "hunter_ghost"


ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.func = function() end


ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDrawInCamera.func = function(method_values, shared_values, object_table, on_call_values)
	local ent = object_table.Entity
	local eye_ang = ent:GetAngles()
	cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y +90,90) ,1)
		surface.SetDrawColor(0,0,0)
		surface.SetMaterial(method_values.Render_Material)
		surface.DrawTexturedRect(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y)		
	cam.End3D2D() 
	cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y + 270,90) ,1)
		surface.SetDrawColor(0,0,0)
		surface.SetMaterial(method_values.Render_Material)
		surface.DrawTexturedRectUV(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y, 1,0,0,1)		
	cam.End3D2D()
end

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDrawInCamera.values.Render_Material = Material("materials/kishkixd/monsters/ghostface.png")

ItemConfig.MetaData.ItemIcon = Material("materials/kishkixd/monsters/ghostface.png")


local XSounds = {
	"X_Airy Breath",
	"X_Bad Man",
	"X_Bad Man 2",
	"X_Bib-Click",
	"X_Big Bang",
	"X_Blow",
	"X_Breaking Small Sticks",
	"X_Breaking Sticks",
	"X_Broken String",
	"X_Cannon Synth",
	"X_Cannon Synth 2",
	"X_Cannon Synth 3",
	"X_Car Crash",
	"X_Dinger",
	"X_Drum Reverb",
	"X_Drums & Metal",
	"X_Fear Hit",
	"X_High Notes",
	"X_Horn",
	"X_Is That A Goat",
	"X_Piano C",
	"X_Piano String Cut",
	"X_Pulsing Metal",
	"X_Reverse Glass",
	"X_Sad Guitar",
	"X_Scary Highs",
	"X_Squeaky Monkeys",
	"X_Squeaky Robe",
	"X_Synth 42",
	"X_Thick String",
	"X_Thick String 2",
	"X_Thick String 3",
	"X_Thick String 4",
	"X_Thick String5",
	"X_White Noise",
}

local HorrorPanic_CT = 0

local DMG_CT = 0

ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame.values.LogicSubMethods = {
	[1] = function(methodvalues, shared_values, object_table, on_call_values)
		if SERVER then
			if shared_values.ActiveEnemy != nil then
				if CurTime() > HorrorPanic_CT then
					net.Start("FosterZ_PlayWorldSound")
					net.WriteString( table.Random(XSounds) )
					net.WriteVector( table.Random(navmesh.GetAllNavAreas()):GetRandomPoint() )
					net.Send(shared_values.ActiveEnemy) 
					-- SOCIOPATHY_PROJECT.GameLogic:AttackPlayer(shared_values.ActiveEnemy, object_table.Entity, 1 ) 
					for k,v in pairs(ents.FindByClass("prop_door_rotating")) do
						if math.random(1,3) == 3 then
							v._NextDorOpen = v._NextDorOpen or CurTime()
							if CurTime() > v._NextDorOpen then
								v:Fire("Toggle")
								v._NextDorOpen = CurTime() + math.random(1,4)
							end
						end
					end
					if CurTime() > HorrorPanic_CT + 2 then
						HorrorPanic_CT = CurTime() + math.Clamp((shared_values.ActiveEnemy:GetNWInt("Game_Stress", 100) / 100) * 4,0.5,10)
					end
				end
				local dist = shared_values.ActiveEnemy:GetPos():Distance(object_table.Entity:GetPos())
				if dist < 300 then
					if CurTime() > DMG_CT then
						if shared_values.ActiveEnemy:GetNWInt("Game_Stress", 100) < 1 then
							SOCIOPATHY_PROJECT.GameLogic:AttackPlayer(shared_values.ActiveEnemy, object_table.Entity, .35 ) 
							DMG_CT = CurTime() + 0.1
						end
					end
				end
			end
			return
		end


		if LocalPlayer():GetNWEntity("Game_MonsterAttacker") != nil then
			if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist != nil then
				if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist < 1500 then
					SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("316797__dimbark1__ghostly-whispers")
				else	
					SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("316797__dimbark1__ghostly-whispers")
				end
			end
			SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("166187__drminky__creepy-dungeon-ambience")
		else
			
			SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("166187__drminky__creepy-dungeon-ambience")
			SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("316797__dimbark1__ghostly-whispers")
		end
	end,
}


ItemConfig.ItemData.SystemValues.LogicMethods.OnEnemyAttack.func = function() end

ItemConfig.ItemData.SystemValues.LogicMethods.OnRunBehaviour = { -- called sv
	func = function(methodvalues, shared_values, object_table, on_call_values) 
		local ent = object_table.Entity
		while ( true ) do	
			if ( object_table.SystemMethods.CallMethod("LogicMethods" , "IsHaveEnemy", nil, object_table) ) then			
				
				ent:SetPos( shared_values.ActiveEnemy:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 )
				ent:EmitSound("fosterz/kishkixd/scary/hits/Airy Breath.mp3",100,100)

				ent:EmitSound("fosterz/kishkixd/horrorstuff/249686__cylon8472__cthulhu-growl.mp3",100,100)

				
			else						
				
				ent:SetPos( table.Random(navmesh.GetAllNavAreas()):GetCenter() ) -- table.Random(navmesh.GetAllNavAreas()):GetCenter() ) 
				ent:EmitSound("fosterz/kishkixd/scary/hits/Airy Breath.mp3",100,100)
				object_table.SystemMethods.CallMethod("LogicMethods" , "OnMoveFreeRoam", nil, object_table)
			end			 	 
			coroutine.wait(4)							
		end
	end,
	values = {
	} 
}

ItemConfig.ItemData.SystemValues.SharedValues.CheckVisibleAmbient = false

SOCIOPATHY_PROJECT.Sounds.List["166187__drminky__creepy-dungeon-ambience"] = {
	path = "horrorstuff/166187__drminky__creepy-dungeon-ambience.mp3",
	channel = 165,
	duration = 48,
	pitch = 100,
}

SOCIOPATHY_PROJECT.Sounds.List["316797__dimbark1__ghostly-whispers"] = {
	path = "horrorstuff/316797__dimbark1__ghostly-whispers.mp3",
	channel = 165,
	duration = 18,
	pitch = 100,
}


-- ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.NoiseSound = "316797__dimbark1__ghostly-whispers"
ItemConfig.ItemData.SystemValues.LogicMethods.OnLogicFrame_ClientsideChaseAmbient.values.EnemyChaseAmbientSound = nil 

-- ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry = nil
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Idle = nil
--[[ ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].path = "fosterz/kishkixd/objects/2gasmask.wav"
ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1].time = 11--]] 

ItemConfig.ItemData.SystemValues.SharedValues.MonsterSounds.Angry[1] = {
	path = "fosterz/kishkixd/horrorstuff/49017__djchaos__gatekeeper.mp3",
	time = 4,
}





SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(ItemConfig)

if SERVER then
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("default").MonstersSpawnList["hunter_ghost"] = true
end