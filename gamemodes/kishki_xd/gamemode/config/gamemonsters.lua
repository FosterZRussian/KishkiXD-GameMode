AddCSLuaFile()

SOCIOPATHY_PROJECT.GameLogic.GameMonsters = {}

local defaultItemData = {
	ItemData = {
		SystemName = "",
		Entity = nil,
		SystemValues = {
			RenderMethods = { 
				OnDrawEffects = { -- called on client
					func = function(method_values, shared_values, object_table, on_call_values) 
						-- on_call_values.SCR_W, on_call_values.SCR_H, on_call_values.nowFrameLerping, on_call_values.CAN_UPDATE, on_call_values.STRESS_LEVEL
						local SCR_W = on_call_values.SCR_W
						local SCR_H = on_call_values.SCR_H
						local nowFrameLerping = on_call_values.nowFrameLerping
						local CAN_UPDATE = on_call_values.CAN_UPDATE
						local STRESS_LEVEL = on_call_values.STRESS_LEVEL

						local min_enemy = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy
						local min_enemy_dist = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist

						if min_enemy != nil && min_enemy_dist < 400 then
							surface.SetDrawColor(255,255,255,255)
							surface.SetMaterial(Material("materials/kishkixd/effects/vhs_ef_1.png"))
							surface.DrawTexturedRect(method_values.Effects2D['VHS_EF_1'],0,ScrW(),ScrH())
							surface.DrawTexturedRect(-ScrW()+method_values.Effects2D['VHS_EF_1'],0,ScrW(),ScrH())


							surface.DrawTexturedRect(-method_values.Effects2D['VHS_EF_1'],-500,ScrW(),ScrH())
							surface.DrawTexturedRect(ScrW()-method_values.Effects2D['VHS_EF_1'],-500,ScrW(),ScrH())
							if CAN_UPDATE then
								method_values.Effects2D['VHS_EF_1'] = method_values.Effects2D['VHS_EF_1'] + (400-min_enemy_dist)
							end
							if method_values.Effects2D['VHS_EF_1'] > ScrW() then
								method_values.Effects2D['VHS_EF_1'] = 0
							end
						end
					end,
					values = {
						Effects2D = {
							['VHS_EF_1'] = 0,
						}
					} 
				},
				OnRenderSetup = {
					func = function(method_values, shared_values, object_table, on_call_values) 
						
						if CLIENT then
							local DrawValues = object_table.SystemMethods.GetMethodValues("RenderMethods", "OnWorldDraw", object_table)
							object_table.Entity:SetRenderBounds(Vector(-DrawValues.Render_Size_X/2,-DrawValues.Render_Size_X/2,0), Vector(DrawValues.Render_Size_X/2,DrawValues.Render_Size_X/2,DrawValues.Render_Size_Y))
						end
					end,
					values = {
					} 
				},
				OnWorldDraw = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 
						local ent = object_table.Entity
						local eye_ang = ent:GetAngles()
						cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y +90,90) ,1)
							surface.SetDrawColor(255,255,255)
							surface.SetMaterial(method_values.Render_Material)
							surface.DrawTexturedRect(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y)		
						cam.End3D2D() 

						cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y + 270,90) ,1)
							surface.SetDrawColor(0,0,0)
							surface.SetMaterial(method_values.Render_Material)
							surface.DrawTexturedRectUV(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y, 1,0,0,1)		
						cam.End3D2D()
					end,
					values = {
						Render_Material = Material("materials/kishkixd/monsters/hunter_2.png"),
						Render_Size_X = 228*0.175,
						Render_Size_Y = 505*0.175,
					} 
				},
				OnWorldDrawInCamera = { -- called
					
					func = function(method_values, shared_values, object_table, on_call_values) 
						if 1 == 1 then return end
						local ent = object_table.Entity
						local eye_ang = ent:GetAngles()
						cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y +90,90) ,1)
							surface.SetDrawColor(255,255,255)
							surface.SetMaterial(method_values.Render_Material)
							surface.DrawTexturedRect(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y)		
						cam.End3D2D() 

						cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang.y + 270,90) ,1)
							surface.SetDrawColor(0,0,0)
							surface.SetMaterial(method_values.Render_Material)
							surface.DrawTexturedRectUV(-method_values.Render_Size_X/2,-method_values.Render_Size_Y,method_values.Render_Size_X,method_values.Render_Size_Y, 1,0,0,1)		
						cam.End3D2D()
					end,
					values = {
						Render_Material = Material("materials/kishkixd/monsters/hunter_2.png"),
						Render_Size_X = 228*0.175,
						Render_Size_Y = 505*0.175,
					} 
				},
			},
			SystemMethods = {
				CallMethod = function(method_type, method_string, on_call_value, object_table)
					local method_data = object_table[method_type][method_string]
					return method_data.func(method_data.values, object_table.SharedValues, object_table, on_call_value)
				end,
				GetMethodValues = function(method_type, method_string, object_table)
					return object_table[method_type][method_string].values
				end,
			},
			LogicMethods = {
				OnSpawn = {
					func = function(method_values, shared_values, object_table, on_call_values) 					 -- called
						object_table.SystemMethods.CallMethod("RenderMethods" , "OnRenderSetup", nil, object_table)	
						object_table.Entity.IsHunter = shared_values.IsHunter
					end,
					values = {
					} 
				},
				OnNearestWithEnemy = { -- called if <500
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnEnemyTakeItem = { -- called
					func = function(method_values, shared_values, object_table, player_ent) 
						shared_values.ForceMoveToEnemy = CurTime() + method_values.ForceMoveToEnemy
						object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", player_ent, object_table)
					end,
					values = {
						ForceMoveToEnemy = 10,
					} 
				},
				OnEnemyUseNoiseItem = { -- not called because we dont have items, we can call this from ItemThink
					func = function(method_values, shared_values, object_table, player_ent) 
						if math.random(1,4) == 4 then
							shared_values.ForceMoveToEnemy = CurTime() + 2
							object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", player_ent, object_table)
						end
					end,
					values = {
					} 
				},
				OnEnemyWalk = { -- called
					func = function(method_values, shared_values, object_table, player_ent) 

					end,
					values = {
					} 
				},
				OnDoorSpotted = { -- called
					func = function(method_values, shared_values, object_table, door_ent) 
						door_ent:Fire("Open")
					end,
					values = {
					} 
				},
				OnEnemyPanicStress = { -- called if <40
					func = function(method_values, shared_values, object_table, player_ent) 
						if CurTime() > method_values.LastCheckStress then
							if math.random(0,4) == 4 then
								shared_values.ForceMoveToEnemy = CurTime() + 5
								object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", player_ent, object_table)
							end
							method_values.LastCheckStress = CurTime() + method_values.StressCheckerCT 
						end
					end,
					values = {
						LastCheckStress = 0,
						StressCheckerCT = 1,
					} 
				},
				OnEnemySpotted = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnEnemyLost = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnMoveToEnemy = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},

				OnMoveFreeRoam = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnEnemyKilled = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnEnemyAttacked = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 
						shared_values.ActiveEnemy:ViewPunch(Angle(math.random(-10,10),math.random(-10,10),0))	
					end,
					values = {
					} 
				},
				OnEnemyAttack = {
					func = function(method_values, shared_values, object_table, on_call_values) 
						local ent = object_table.Entity
						local start_tr = ent:GetPos()
						local check_tr = util.TraceLine({
							start = start_tr,
							endpos = shared_values.ActiveEnemy:GetPos(),
							filter = function( ent_finded ) 
								if (ent_finded == shared_values.ActiveEnemy) then
									shared_values.LastSeeEnemy = CurTime() + method_values.AttackTimeMemory
									if CurTime() < method_values.__LastAttackTime then return end
									if shared_values.ActiveEnemy:GetPos():Distance(ent:GetPos()) > method_values.AttackDist then return end
									method_values.__LastAttackTime = CurTime()  + method_values.AttackCT


									shared_values.ActiveEnemy:EmitSound(table.Random(method_values.AttackSounds),100,100)-- "fosterz/kishkixd/chainsaw/chainsaw_1.mp3")--, 100, 100)

									SOCIOPATHY_PROJECT.GameLogic:AttackPlayer(shared_values.ActiveEnemy, ent, method_values.AttackDamage ) 
									return true
								end
							end
						})
					end,
					values = {
						AttackCT = 1,
						AttackDist = 150,
						AttackTimeMemory = 8,
						AttackDamage = 50,
						AttackSounds = {
							[1] = "fosterz/kishkixd/chainsaw/chainsaw_1.mp3",
						},
						__LastAttackTime = 0,

					} 
				},
				OnSetEnemy = {
					func = function(method_values, shared_values, object_table, enemy) 
						local ent = object_table.Entity
						shared_values.ActiveEnemy = enemy

						if enemy == nil then
							if shared_values.ActiveEnemy != nil then
								shared_values.ActiveEnemy:SetNWEntity("Game_MonsterAttacker", nil)
							end

							object_table.SystemMethods.CallMethod("LogicMethods" , "OnEnemyLost", shared_values.ActiveEnemy, object_table)

							

						else
							enemy:SetNWEntity("Game_MonsterAttacker", ent)

							object_table.SystemMethods.CallMethod("LogicMethods" , "OnEnemySpotted", shared_values.ActiveEnemy, object_table)
						end
						shared_values.ActiveEnemy = enemy
						shared_values.LastSeeEnemy = CurTime() + (CT or 8)
					end,
					values = {} 
				}, 
				OnFindEnemy = {
					func = function(method_values, shared_values, object_table, on_call_values) 
						local ent = object_table.Entity

						if !game.GetWorld():GetNWBool("IsQuest_Mode") then
							object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", table.Random(player.GetHumans()), object_table)	
							return true
						else
							local _ents = ents.FindInSphere( ent:GetPos(), method_values.SearchRadius )	
							for k,v in ipairs( _ents ) do
								if ( v:IsPlayer() ) then			
									object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", v, object_table)	
									return true
								end
							end		
							object_table.SystemMethods.CallMethod("LogicMethods" , "OnSetEnemy", nil , object_table)
							return false
						end
					end,
					values = {
						SearchRadius = 3000,
					} 
				},

				IsHaveEnemy = {
					func = function(method_values, shared_values, object_table, options) 
						local ent = object_table.Entity
						local enemy_ent = shared_values.ActiveEnemy
						if IsValid(enemy_ent) then	
							if game.GetWorld():GetNWBool("IsQuest_Mode") then
								if CurTime() > shared_values.ForceMoveToEnemy then
									if CurTime() > shared_values.LastSeeEnemy then
										return object_table.SystemMethods.CallMethod("LogicMethods" , "OnFindEnemy", nil, object_table)	
									elseif ( ent:GetRangeTo(enemy_ent:GetPos()) > method_values.LoseTargetDist ) then						
										return object_table.SystemMethods.CallMethod("LogicMethods" , "OnFindEnemy", nil, object_table)		
									elseif ( enemy_ent:IsPlayer() and !enemy_ent:Alive() ) then
										return object_table.SystemMethods.CallMethod("LogicMethods" , "OnFindEnemy", nil, object_table)		
									end			
								end
							end

							object_table.SystemMethods.CallMethod("LogicMethods" , "OnEnemyAttack", nil, object_table)		

							return true
						else		
							return object_table.SystemMethods.CallMethod("LogicMethods" , "OnFindEnemy", nil, object_table)
						end

						return "ok"
					end,
					values = {
						LoseTargetDist = 2500,
					} 
				},
				OnChaseEnemy = {
					func = function(method_values, shared_values, object_table, options) 
						local ent = object_table.Entity
						local options = options or {}
						local path = Path( "Follow" )
						path:SetMinLookAheadDistance( options.lookahead or 300 )
						path:SetGoalTolerance( options.tolerance or 20 )
						path:Compute( ent, shared_values.ActiveEnemy:GetPos() )	
						object_table.SystemMethods.CallMethod("LogicMethods" , "OnMoveToEnemy", nil, object_table)
						if ( !path:IsValid() ) then return "failed" end
						while ( path:IsValid() and object_table.SystemMethods.CallMethod("LogicMethods" , "IsHaveEnemy", nil, object_table) ) do
							if ( path:GetAge() > 0.1 ) then					
								path:Compute(ent, shared_values.ActiveEnemy:GetPos())
							end
							path:Update( ent )								
								
							if ( options.draw ) then path:Draw() end		



							if ( ent.loco:IsStuck() ) then
								ent:HandleStuck()
								return "stuck"
							end

							coroutine.yield()

						end


						return "ok"
					end,
					values = {
					} 
				},
				OnGetDesiredChaseSpeed = { -- called serverside
					func = function(methodvalues, shared_values, object_table, on_call_values) 

						local enemy_normal_speed = shared_values.ActiveEnemy:GetMaxSpeed()
						local enemy_max_speed = shared_values.ActiveEnemy:GetRunSpeed()
						return (enemy_normal_speed + ((enemy_max_speed - enemy_normal_speed) / 2)) * shared_values.SpeedForce
					end,
					values = {
					} 
				}, 
				OnRunBehaviour = { -- called sv
					func = function(methodvalues, shared_values, object_table, on_call_values) 
						local ent = object_table.Entity
						while ( true ) do	
							if ( object_table.SystemMethods.CallMethod("LogicMethods" , "IsHaveEnemy", nil, object_table) ) then			
								ent.loco:FaceTowards(shared_values.ActiveEnemy:GetPos())	
								ent.loco:SetDesiredSpeed( object_table.SystemMethods.CallMethod("LogicMethods" , "OnGetDesiredChaseSpeed", nil, object_table)  )		
								ent.loco:SetAcceleration(900)			
								object_table.SystemMethods.CallMethod("LogicMethods" , "OnChaseEnemy", nil, object_table)
								ent.loco:SetAcceleration(400)									
							else						
								ent.loco:SetDesiredSpeed( 200 )		
								ent:MoveToPos( ent:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 400 ) -- table.Random(navmesh.GetAllNavAreas()):GetCenter() ) 
								object_table.SystemMethods.CallMethod("LogicMethods" , "OnMoveFreeRoam", nil, object_table)
							end			 	 


							coroutine.wait(.1)
							
						end
					end,
					values = {
					} 
				},
				OnTakeDamageFromEnemy = { -- not called
					func = function(method_values, shared_values, object_table, on_call_values) 

					end,
					values = {
					} 
				},
				OnStuckDetected = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 
						if shared_values.VisibleFromEnemy then
							local pos = object_table.Entity:GetPos() + object_table.Entity:GetAngles():Forward()*150
							local nav_area = navmesh.GetNearestNavArea(pos, true, 99999, false, false)
							if nav_area == nil then
								object_table.Entity:SetPos(table.Random(navmesh.GetAllNavAreas()):GetRandomPoint())
							else
								object_table.Entity:SetPos( nav_area:GetCenter() ) 
							end
						else
							object_table.Entity:SetPos(table.Random(navmesh.GetAllNavAreas()):GetRandomPoint())
						end
					end,
					values = {
					} 
				},
				OnCheckStucked = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 
						if CurTime() > method_values.stuck_ct_checker then
							local ent = object_table.Entity
							if ent:GetPos():Distance(method_values['last_pos']) < 30 then
								object_table.Entity.loco:Jump()
								method_values['teleported'] = method_values['teleported'] + 1
								if method_values['teleported'] == 5 then
									object_table.SystemMethods.CallMethod("LogicMethods" , "OnStuckDetected", nil, object_table)
									method_values['teleported'] = 0
								end
							end
							method_values['last_pos'] = ent:GetPos()

							method_values.stuck_ct_checker = CurTime() + 1
						end
					end,
					values = {
						last_stuck = 0,
						teleported = 0,
						last_pos = Vector(),
						stuck_ct_checker = 0
					} 
				},
				OnLogicFrame_ClientsideChaseAmbient = { -- called
					func = function(method_values, shared_values, object_table, distance) 
						if method_values.NoiseSound != nil then
							if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist < 600 then
								SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound(method_values.NoiseSound)
							else
								SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(method_values.NoiseSound)
							end
						end

						if shared_values.CheckVisibleAmbient && object_table.Entity:GetNWBool("VisibleFromEnemy") == false then 
							if method_values.EnemyChaseAmbientSound != nil then
								SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(method_values.EnemyChaseAmbientSound)
							end
							return 
						end
						if method_values.EnemyChaseAmbientSound != nil then
							if LocalPlayer():GetNWEntity("Game_MonsterAttacker") != nil then
								if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist < 1500 then
									if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist < 400 then
										SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(method_values.EnemyChaseAmbientSound)
									else
										SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound(method_values.EnemyChaseAmbientSound)
									end

								else
									SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(method_values.EnemyChaseAmbientSound)
								end
							else	
								SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(method_values.EnemyChaseAmbientSound)
							end
						end
					end,
					values = {
						NoiseSound = "Game_Noise_1",
						EnemyChaseAmbientSound = "Game_ChainSawScr"
					} 
				},
				OnLogicFrame = { -- called
					func = function(method_values, shared_values, object_table, on_call_values) 

						for k,v in pairs(method_values.LogicSubMethods) do
							v(method_values, shared_values, object_table, on_call_values)
						end


						if SERVER then

							
							local ent = object_table.Entity
						
							local eye_pos = ent:GetPos() + Vector(0,0,30)

							shared_values.LastTrace = util.TraceLine({
								start = eye_pos,
								endpos = eye_pos + ent:GetAngles():Forward()*1000,
								filter = function(ent_finded)
									if shared_values.EntsClasses.Doors[ent_finded:GetClass()] then
										object_table.SystemMethods.CallMethod("LogicMethods" , "OnDoorSpotted", ent_finded, object_table)
									end
								end
							})

							if shared_values.MonsterSounds.Idle != nil then
								if CurTime() > method_values.LastSound_TimerIdle then
									local rnd_snd = table.Random(shared_values.MonsterSounds.Idle)
									ent:EmitSound(rnd_snd.path, 100, 100)
									--method_values.LastSound_TimerIdle = CurTime() + rnd_snd.time

									if rnd_snd.time_max != nil then
										method_values.LastSound_TimerIdle = CurTime() + math.random(rnd_snd.time,rnd_snd.time_max)
									else
										method_values.LastSound_TimerIdle = CurTime() + rnd_snd.time
									end
								end
							end
							if shared_values.MonsterSounds.Angry != nil then
								if shared_values.MonsterSounds.PlayAngryWithoutEnemy or (!shared_values.MonsterSounds.PlayAngryWithoutEnemy && shared_values.ActiveEnemy != nil) then
									if CurTime() > method_values.LastSound_TimerAngry then
										local rnd_snd = table.Random(shared_values.MonsterSounds.Angry)
										ent:EmitSound(rnd_snd.path, 100, 100)
										if rnd_snd.time_max != nil then
											method_values.LastSound_TimerAngry = CurTime() + math.random(rnd_snd.time,rnd_snd.time_max)
										else
											method_values.LastSound_TimerAngry = CurTime() + rnd_snd.time
										end
									end
								end
							end

							object_table.SystemMethods.CallMethod("LogicMethods" , "OnCheckStucked", nil, object_table)

							if shared_values.ActiveEnemy != nil then
								shared_values.VisibleFromEnemy = false
								object_table.Entity:SetNWBool("VisibleFromEnemy", false)
								shared_values.TraceToEnemy = util.TraceLine({
									start = eye_pos,
									endpos = shared_values.ActiveEnemy:EyePos(),
									filter = function(ent_finded)
										if ent_finded == shared_values.ActiveEnemy then
											shared_values.VisibleFromEnemy = true
											object_table.Entity:SetNWBool("VisibleFromEnemy", true)
											return true
										end
									end
								})
								local vec = shared_values.ActiveEnemy:GetVelocity()
								if vec.x != 0 or vec.y != 0 then
									object_table.SystemMethods.CallMethod("LogicMethods" , "OnEnemyWalk", shared_values.ActiveEnemy, object_table)
								end

								local dist = ent:GetPos():Distance(shared_values.ActiveEnemy:GetPos())
								if dist < 500 then
									object_table.SystemMethods.CallMethod("LogicMethods" , "OnNearestWithEnemy", dist, object_table)
								end
							else
								for k, ent in pairs(player.GetHumans()) do
									if ent:GetNWInt("Game_Stamina", 100) < 20 then
										object_table.SystemMethods.CallMethod("LogicMethods" , "OnEnemyPanicStress", ent, object_table)
									end	
								end
							end
						end

								
					end,
					values = {
						LastSound_TimerAngry = 0,
						LastSound_TimerIdle = 0,
						LogicSubMethods = {}

					} 
				},
			},
			SharedValues = {
				CheckVisibleAmbient = true,
				LastSeeEnemy = 0,
				ActiveEnemy = nil,
				SpeedForce = 1,
				VisibleFromEnemy = false,
				TraceToEnemy = nil,
				ForceMoveToEnemy = 0,
				IsHunter = true, -- 	
				EntsClasses = {
					Doors = {
						["func_door"] = true,
						['prop_door_rotating'] = true,
						['func_door_rotating'] = true,
					}
				},
				MonsterSounds = {
					PlayAngryWithoutEnemy = true,
					Angry = {
						[1] = {
							path = "fosterz/kishkixd/chainsaw/118972__esperri__chainsaw.mp3",
							time = 11,
						},
					},
					Idle = {
						[1] = {
							path = "fosterz/kishkixd/chainsaw/scre2.mp3",
							time = 4,
						},
					},
				},
			},
		},
	},
	MetaData = {
		ItemName = "ITEMNAME",
		ItemDescription = "ITEMDESC",
		DrawInStorageReview = true,
	},
}

function SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()
	return table.Copy(defaultItemData)
end

local is_cleaned = false

function SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(data)
	SOCIOPATHY_PROJECT.GameLogic.GameMonsters[data.ItemData.SystemName] = {}
	for k,v in pairs(defaultItemData) do
		for k2, v2 in pairs(v) do
			if data[k][k2] == nil then
				data[k][k2] = v2
			end
		end
	end
	SOCIOPATHY_PROJECT.GameLogic.GameMonsters[data.ItemData.SystemName] = data
end
function SOCIOPATHY_PROJECT.GameLogic:SpawnMonster(monster_class)
	local ent = ents.Create("npc_hunter")
	ent:Spawn()
	ent:SetupLogicTable(monster_class)

	ent:SetPos(table.Random(navmesh.GetAllNavAreas()):GetCenter() + Vector(0,0,10) )

	return ent
end
function SOCIOPATHY_PROJECT.GameLogic:IncludeMonster(item_file)
	local path = "gamemonsters/" .. item_file .. ".lua"
	AddCSLuaFile(path)
	include(path)
end
--[[ SOCIOPATHY_PROJECT.GameLogic:IncludeMonster("m_slasher")
SOCIOPATHY_PROJECT.GameLogic:IncludeMonster("m_rabbit")
SOCIOPATHY_PROJECT.GameLogic:IncludeMonster("m_ghost") --]] 



for k,v in pairs(file.Find("gamemodes/kishki_Xd/gamemode/config/gamemonsters/*", "GAME")) do
	SOCIOPATHY_PROJECT.GameLogic:IncludeMonster(string.StripExtension(v))
end 


for k,v in pairs(ents.FindByClass("npc_hunter")) do
	if v.CachedClass != nil then
		v:SetupLogicTable(v.CachedClass)	
	end
end