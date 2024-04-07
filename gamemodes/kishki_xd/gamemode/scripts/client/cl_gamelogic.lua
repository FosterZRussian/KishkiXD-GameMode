AddCSLuaFile()

if CLIENT then
	CreateClientConVar("kishki_render_eff_panic", 3, true, false, nil, 1, 4)
	CreateClientConVar("kishki_render_eff_screensize", 1, true, false, nil)
	CreateClientConVar("kishki_render_eff_preset", 1, true, false, nil, 1, 10)
end
local ProtectedHooks = {}

local function AddProtectedHook(h1, h2)
	ProtectedHooks[h1] = ProtectedHooks[h1] or {}
	ProtectedHooks[h1][h2] = true
end

AddProtectedHook("PostDrawEffects","RenderWidgets")
AddProtectedHook("ShutDown","SaveCookiesOnShutdown")
AddProtectedHook("EntityNetworkedVarChanged","NetworkedVars")
AddProtectedHook("EntityRemoved","Constraint Library - ConstraintRemoved")
AddProtectedHook("EntityRemoved","DoDieFunction")
AddProtectedHook("PlayerInitialSpawn","PlayerAuthSpawn")
AddProtectedHook("PlayerTick","TickWidgets")
AddProtectedHook("AddToolMenuCategories","CreateUtilitiesCategories")
AddProtectedHook("SpawniconGenerated","SpawniconGenerated")
AddProtectedHook("RenderScene","RenderSuperDoF")
AddProtectedHook("RenderScene","RenderStereoscopy")
AddProtectedHook("DrawOverlay","DragNDropPaint")
AddProtectedHook("DrawOverlay","DrawNumberScratch")
AddProtectedHook("DrawOverlay","VGUIShowLayoutPaint")
AddProtectedHook("GUIMousePressed","SuperDOFMouseDown")
AddProtectedHook("GUIMousePressed","PropertiesClick")
AddProtectedHook("Think","RealFrameTime")
AddProtectedHook("Think","NotificationThink")
AddProtectedHook("Think","DOFThink")
AddProtectedHook("Think","DragNDropThink")
AddProtectedHook("GUIMouseReleased","SuperDOFMouseUp")
AddProtectedHook("PostDrawEffects","RenderHalos")
AddProtectedHook("PostRender","RenderFrameBlend")
AddProtectedHook("PreDrawHalos","PropertiesHover")
AddProtectedHook("Tick","SendQueuedConsoleCommands")
AddProtectedHook("PreventScreenClicks","SuperDOFPreventClicks")
AddProtectedHook("PreventScreenClicks","PropertiesPreventClicks")
AddProtectedHook("PostReloadToolsMenu","BuildUndoUI")
AddProtectedHook("PostReloadToolsMenu","BuildCleanupUI")
AddProtectedHook("CalcView","MyCalcView")
AddProtectedHook("LoadGModSaveFailed","LoadGModSaveFailed")
AddProtectedHook("NeedsDepthPass","NeedsDepthPass_Bokeh")
AddProtectedHook("PopulateToolMenu","PopulateUtilityMenus")
AddProtectedHook("PlayerBindPress","PlayerOptionInput")
AddProtectedHook("VGUIMousePressAllowed","WorldPickerMouseDisable")
AddProtectedHook("RenderScreenspaceEffects","RenderToyTown")
AddProtectedHook("RenderScreenspaceEffects","RenderBokeh")
AddProtectedHook("RenderScreenspaceEffects","SOCIOPATHY_PROJECTRenderScreenspaceEffects")
AddProtectedHook("RenderScreenspaceEffects","RenderBloom")
AddProtectedHook("RenderScreenspaceEffects","RenderTexturize")
AddProtectedHook("RenderScreenspaceEffects","RenderColorModify")
AddProtectedHook("RenderScreenspaceEffects","RenderMaterialOverlay")
AddProtectedHook("RenderScreenspaceEffects","RenderMotionBlur")
AddProtectedHook("RenderScreenspaceEffects","RenderSharpen")
AddProtectedHook("RenderScreenspaceEffects","RenderSobel")
AddProtectedHook("RenderScreenspaceEffects","RenderSunbeams")
AddProtectedHook("VGUIMousePressed","TextEntryLoseFocus")
AddProtectedHook("VGUIMousePressed","DermaDetectMenuFocus")
AddProtectedHook("InitPostEntity","CreateVoiceVGUI")
AddProtectedHook("HUDPaint","DrawRecordingIcon")
AddProtectedHook("HUDPaint","PlayerOptionDraw")
AddProtectedHook("PopulateMenuBar","DisplayOptions_MenuBar")
AddProtectedHook("PopulateMenuBar","NPCOptions_MenuBar")
AddProtectedHook("OnGamemodeLoaded","CreateMenuBar")
AddProtectedHook("PopulateContent","GameProps")


hook.Add( "PlayerNoClip", "SOCIOPATHY_PROJECT_isInNoClip", function( ply, desiredNoClipState )
	return false
end )
hook.Add("InitPostEntity","SOCIOPATHY_PROJECT_ClearHooks", function()
	
	for k,v in pairs(hook.GetTable()) do
		for k2, v2 in pairs(v) do
			if isstring(k2) then
				if ProtectedHooks[k] != nil then
					if ProtectedHooks[k][k2] then
						continue
					end
				end
				if string.find(k2, "SOCIOPATHY_PROJECT_") == nil then
					--[[ print(k,v,k2,v2)
					print("removed")--]] 
					hook.Remove(k, k2)
				end
			end
		end
	end
end)

hook.Add("PlayerDeathSound", "SOCIOPATHY_PROJECT_PlayerDeathSound", function()
	return true
end)


local CMoveData = FindMetaTable("CUserCmd")

function CMoveData:_RemoveKey(keys)
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end

hook.Add("StartCommand", "SOCIOPATHY_PROJECT_StartCommand", function(ply, cmd)
	if cmd:KeyDown(IN_JUMP) then
		cmd:RemoveKey(IN_JUMP)
	end
	--[[ cmd:ClearMovement() 
	cmd:ClearButtons()--]] 
	--cmd:ClearButtons()
	local cmd_angs = cmd:GetViewAngles()
	--cmd:SetViewAngles()
end)

--[[ local sens = 0.074*0.25 -- removed
hook.Add( "InputMouseApply", "SOCIOPATHY_PROJECT_Mouse", function( cmd,x,y,ang )
	cmd:SetViewAngles(ang+Angle(y*sens,x*sens))
	cmd:SetMouseX( -x )
	cmd:SetMouseY( -y ) 
	return true
end )--]] 

--[[ hook.Add("CreateMove", "SOCIOPATHY_PROJECT_StartCommand", function(cmd)
    cmd:SetSideMove(cmd:GetSideMove()*-1)
end)--]] 

function SOCIOPATHY_PROJECT.GameLogic:Rotate2DPoint(x,y,angle)
	angle = math.rad(angle)
       return x * math.cos(angle) - y * math.sin(angle),x * math.sin(angle) + y * math.cos(angle)
end

function SOCIOPATHY_PROJECT.GameLogic:SwitchItemOnHand(ply, item_id)
	if SERVER then
		net.Start("FosterZ_ChangeItemToThis")
		net.WriteUInt(item_id, 16)
		net.Send(ply)
	end


	
	if ply.InventoryItems.SlotCache[item_id] != nil then
		SOCIOPATHY_PROJECT.Sounds:PlaySound("HoldItem")
		if ply.InventoryItems.SelectedItem != nil then
			if ply.InventoryItems.SelectedItem == item_id then
				item_id = nil
			end
			local item_data = SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, ply.InventoryItems.SelectedItem)
			if item_data != nil then
				item_data.ItemData.SystemFunctions:OnSwitchToHand(ply, false)
			end
		end
		ply.InventoryItems.SelectedItem = item_id
		if item_id != nil then

			if SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, ply.InventoryItems.SelectedItem).ItemData.SystemValues.IsInitialized != true then
				SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, ply.InventoryItems.SelectedItem).ItemData.SystemFunctions:OnInit(ply, true)
			end
			SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, ply.InventoryItems.SelectedItem).ItemData.SystemFunctions:OnSwitchToHand(ply, true)
		end
	end

end

local UPD_CT = 0
local C_FrameLerp = SysTime()
function SOCIOPATHY_PROJECT.GameLogic:CanUpdateFrame()
	local nowFrameLerping = SysTime() - C_FrameLerp
	local CAN_UPD = CurTime() > UPD_CT
	if CAN_UPD then
		local next_vsthink = (1-FrameTime())/30
		UPD_CT = CurTime() + next_vsthink
	end
	C_FrameLerp = SysTime()
	return CAN_UPD
end


local UsedItems = {
	["func_door_rotating"] = true,
	["prop_door_rotating"] = true,
	["func_button"] = true,
}
function SOCIOPATHY_PROJECT.GameLogic:ThinkItemForPlayer(ply)
	local weapon = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem(ply)
	if weapon != nil then
		weapon.ItemData.SystemFunctions:OnThink(weapon)
	end

	ply._CanTakeItem = nil
	ply._CanInteractiveItem = nil

	local USER_TRACE = util.TraceLine({
		start = ply:EyePos(),
		endpos = ply:EyePos()+ ply:EyeAngles():Forward() * 200,
		filter = function(ent)
			if (ent:GetClass() == "item_dropped") then
				if ent:GetPos():Distance(ply:GetPos()) < 64 then
					ply._CanTakeItem = ent
				end
				return true
			elseif UsedItems[ent:GetClass()] then
				if ent:GetPos():Distance(ply:GetPos()) < 120 then
					ply._CanInteractiveItem = ent
				end
				return true
			end
		end
	})
end


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

local HSounds = {
	"H_Beast-Thing",
	"H_Breath with bells",
	"H_Breather",
	"H_Broken Bow",
	"H_Bug",
	"H_Burning Voices",
	"H_Children",
	"H_Crash",
	"H_Creep",
	"H_Danger Clouds",
	"H_Dead Mother",
	"H_Ear Ghost",
	"H_Flute",
	"H_Gate 2",
	"H_Ghost Bee",
	"H_Ghost Train",
	"H_Haunted Dog",
	"H_Haunted Motor",
	"H_Metal Plate",
	"H_Monster Sight 2",
	"H_Mysterious Bell",
	"H_orbit",
	"H_Psy Waves",
	"H_Radiation",
	"H_Reverse Ghost",
	"H_Robot Wasps",
	"H_Run",
	"H_Sad Monster",
	"H_Sirens",
	"H_Sirens 2",
	"H_Soul-Wind",
	"H_Synth Winds",
	"H_Tension",
	"H_Vinyl Ghost",
	"H_Volts",
	"H_Wasps",
	"H_White Winds",
	"H_White Winds 2",
	"H_Wind",
	"H_Windy Noise",
}


local HorrorSND_CT = CurTime()


net.Receive("FosterZ_PlayWorldSound", function(len,ply)
	SOCIOPATHY_PROJECT.Sounds:PlaySound(net.ReadString(), net.ReadVector(),10)
end)
function SOCIOPATHY_PROJECT.GameLogic:PlayHorrorSound(ply, tb, ct, pos)
	if CurTime() > HorrorSND_CT then
		SOCIOPATHY_PROJECT.Sounds:PlaySound(table.Random(tb or HSounds), pos or (ply:GetPos() + Vector(math.random(-1000,1000),math.random(-1500,1500),10)))
		HorrorSND_CT = CurTime() + (ct or 2.5)
	end
end

local HorrorPanic_CT = CurTime()



function SOCIOPATHY_PROJECT.GameLogic:ThinkMinEnemies(ply)


	if CLIENT then
		SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy or nil
		SOCIOPATHY_PROJECT.GameLogic:PlayHorrorSound(ply)
	else


		--[[ if CurTime() > HorrorPanic_CT then
			net.Start("FosterZ_PlayWorldSound")
			net.WriteString( table.Random(XSounds) )
			net.WriteVector( table.Random(navmesh.GetAllNavAreas()):GetRandomPoint() )
			net.Send(ply) 


			for k,v in pairs(ents.FindByClass("prop_door_rotating")) do
				v._NextDorOpen = v._NextDorOpen or CurTime()
				if CurTime() > v._NextDorOpen then
					v:Fire("Toggle")
					v._NextDorOpen = CurTime() + math.random(1,4)
				end
			end

			if CurTime() > HorrorPanic_CT + 2 then

			HorrorPanic_CT = CurTime() + 5
			end
		end--]] 
	end


	local min_enemy_dist = 999999
	local min_enemy = nil
	for k,v in pairs(ents.FindByClass("npc_hunter")) do
		if !v.IsHunter then continue end

		local c_min_enemy_dist = v:GetPos():Distance(ply:EyePos())
		if min_enemy == nil or c_min_enemy_dist < min_enemy_dist then
			min_enemy_dist = c_min_enemy_dist
			min_enemy = v
		end
	end

	local enemy_is_vis = false
	local enemy_trace = nil
	if min_enemy != nil then
		enemy_trace = util.TraceLine({
			start = ply:EyePos(),
			endpos = min_enemy:GetPos() + Vector(0,0,30),
			filter = function(ent)
				if ent == min_enemy then
					enemy_is_vis = true
					return true
				end
			end,
		})
	end


	if CLIENT then
		SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy = min_enemy
		SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist = min_enemy_dist
	end
	if CLIENT then
		SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy = min_enemy
		SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist = min_enemy_dist


		if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy != nil then
			if min_enemy.ClassSetuped then
				min_enemy.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnLogicFrame_ClientsideChaseAmbient", min_enemy_dist, min_enemy.ClassConfig)	
			end
		end
	else
		local stress = ply:GetNWFloat("Game_Stress", 0)
		if min_enemy != nil then
			if enemy_is_vis && min_enemy_dist < 2000 then
				if min_enemy_dist < 500 or (min_enemy_dist > 500 && stress > 0.5) then
					ply:SetNWFloat("Game_Stress", math.Clamp(stress - (1-(min_enemy_dist/500)), 0, 100))
				else
					ply:SetNWFloat("Game_Stress", math.Clamp(stress + 2, 0, 100))
				end
			else
				if stress < 100 then
					ply:SetNWFloat("Game_Stress", math.Clamp(stress + 0.5, 0, 100))
				end
			end
		else
			ply:SetNWFloat("Game_Stress", math.Clamp(stress + 0.5, 0, 100))
		end
	end

	--[[ if CLIENT then
		local attacker = ply:GetNWEntity("Game_MonsterAttacker", nil)
		if attacker != nil then
			SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("Game_BesideAmbient")
		else
			SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("Game_BesideAmbient")
		end
	end--]] 

end



hook.Add( "EntityEmitSound", "SOCIOPATHY_PROJECT_EntityEmitSound", function( t )		
	--PrintTable(t)		
end)

function _DistBAngle(ang1, ang2)
	local distance = (ang1-ang2) % 360
	if (distance < -180) then
    	distance = distance + 360
	elseif (distance > 179) then
    	distance = distance - 360
    end
	return distance
end


function SOCIOPATHY_PROJECT.GameLogic:ThinkOnMove(ply)

	
	if SERVER then		
		if ply.TeleportOnMove then
			for k, ply in pairs(player.GetAll()) do		
				ply._LastThinkFrameCT = ply._LastThinkFrameCT or 0
				if CurTime() > ply._LastThinkFrameCT then
					local ply_ang = ply:GetAngles()
					ply._LastAng = ply._LastAng or ply_ang
					ply._LastThinkFrameCT = ply._LastThinkFrameCT or CurTime()
					local rest = math.abs(_DistBAngle(ply._LastAng.y, ply_ang.y))
					if rest > 20 then

						ply:SetPos(table.Random(navmesh.GetAllNavAreas()):GetRandomPoint())
						ply._LastThinkFrameCT = CurTime() + 1
						ply.EYEBack = ply._LastAng + Angle(0,180,0)
					end 			 
				end
			end
			ply._LastAng = ply:GetAngles()
		end
	end

	if CLIENT then


		local stamina =  ply:GetNWFloat("Game_Stamina", 100)
		if stamina < 20 then
			SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("HumanBreathingOut1")
		else
			SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("HumanBreathingOut1", true)
		end

		local speed = ply:GetVelocity():Length2DSqr()*0.000015
		ply._EyeMovePos_y = ply._EyeMovePos_y or 0
		ply._EyeMovePos_ST = ply._EyeMovePos_ST or false
		
		if speed <= 0.2 then
			ply._EyeMovePos_y = math.Approach(ply._EyeMovePos_y, 0, 1)
		else
			if ply._EyeMovePos_ST then
				ply._EyeMovePos_y = ply._EyeMovePos_y - speed
				if ply._EyeMovePos_y < -2 then
					ply._EyeMovePos_ST = false
				end
			else
				ply._EyeMovePos_y = ply._EyeMovePos_y + speed
				if ply._EyeMovePos_y > 10 then
					ply._EyeMovePos_ST = true
				end
			end
		end
	else
		local used_speed = ply:GetVelocity():Length()
		local stamina =  ply:GetNWFloat("Game_Stamina", 100)
		if stamina < 50 then
			local stress = ply:GetNWFloat("Game_Stress", 0)
			if stress > 30 then
				ply:SetNWFloat("Game_Stress", math.Clamp(stress - 1, 0, 100))
			end

		end
		if used_speed > 250 then
			ply:SetNWFloat("Game_Stamina", math.Approach(stamina, 0, 0.5) )
		else 
			ply:SetNWFloat("Game_Stamina", math.Approach(stamina, 100, 0.5) )
		end


	end
end

hook.Add("Think", "SOCIOPATHY_PROJECT_GameMode_Think", function()
	if SOCIOPATHY_PROJECT.GameLogic:CanUpdateFrame() then
		if CLIENT then

			local ply = LocalPlayer()
			SOCIOPATHY_PROJECT.GameLogic:ThinkMinEnemies(ply)
			SOCIOPATHY_PROJECT.GameLogic:ThinkItemForPlayer(ply)

			SOCIOPATHY_PROJECT.GameLogic:ThinkOnMove(ply)

		
		else
			for k,v in pairs(player.GetAll()) do
				SOCIOPATHY_PROJECT.GameLogic:ThinkItemForPlayer(v)
				SOCIOPATHY_PROJECT.GameLogic:ThinkPlayer(v)
				SOCIOPATHY_PROJECT.GameLogic:ThinkMinEnemies(v)
				SOCIOPATHY_PROJECT.GameLogic:ThinkOnMove(v)
			end
		end
	end




end)

function SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem(ply)
	ply = ply or LocalPlayer()
	if ply.InventoryItems == nil then
		return nil
	end
	local selected_item = ply.InventoryItems.SelectedItem
	if selected_item != nil then
		return SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, selected_item), selected_item
	end
end

function SOCIOPATHY_PROJECT.GameLogic:GetSystemItemConfig(item_id)
	return SOCIOPATHY_PROJECT.GameLogic.GameItems[item_id]
end 


function SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, item_id)
	ply = ply or LocalPlayer()	
	local sys_id = ply.InventoryItems.SlotCache[item_id]
	if sys_id == nil then
		return
	end
	local copied_table = ply.InventoryItems.ItemsTables[sys_id]
	if ply.InventoryItems.ItemsTables[sys_id] == nil then
		copied_table = {}
		table.CopyFromTo(SOCIOPATHY_PROJECT.GameLogic.GameItems[sys_id], copied_table)
		ply.InventoryItems.ItemsTables[sys_id] = copied_table
	end
	return ply.InventoryItems.ItemsTables[sys_id]
end 


function SOCIOPATHY_PROJECT.GameLogic:DropItem(ply, item_id, item_config)
	if CLIENT then return end	
	local item_data = ents.Create("item_dropped")
	item_data:SetNWString("ItemID", item_id)
	item_data:SetPos(ply:GetPos())
	item_data:Spawn()
	item_data.IsQuestItem = item_config.ItemData.SystemValues.IsQuestItem
	SOCIOPATHY_PROJECT.GameLogic:TakeItemFromPlayer(ply, item_id)

	--[[ net.Start("FosterZ_TakeItemFromPlayer")
	net.WriteString(item_id)
	net.SendToServer()--]] 
end

function SOCIOPATHY_PROJECT.GameLogic:SetupPlayerTables(ply)
	if SERVER then
		net.Start("FosterZ_SetupPlayerTables")
		net.Send(ply)
	end
	ply.InventoryItems = {
		SlotCache = {},
		ItemsCache = {},
		ItemsTables = {},
		SelectedItem = nil,
	}
end
if CLIENT then
	net.Receive("FosterZ_SetupPlayerTables", function()
		SOCIOPATHY_PROJECT.GameLogic:SetupPlayerTables(LocalPlayer())
	end)
end


function SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, item_id, IsQuestItem)
	IsQuestItem = IsQuestItem or false
	if SERVER then
		net.Start("FosterZ_GiveItemToPlayer")
		net.WriteString(item_id)
		net.WriteBool(IsQuestItem)
		net.Send(ply)
	end
	

	local SystemItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetSystemItemConfig(item_id)
	if SystemItemConfig == nil then return false end


	if CLIENT then
		SOCIOPATHY_PROJECT.Sounds:PlaySound("HoldItem")
	end

	if SystemItemConfig.ItemData.CanBeUsedAsSlotItem then
		
		if ply.InventoryItems.ItemsCache[item_id] == nil then			
			local item_counts = #ply.InventoryItems.SlotCache
			if item_counts == 4 then
				local active_item_cfg, active_item_id = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem(ply)
				if active_item_cfg == nil then
					local drop_item_config = SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, 4)
					local drop_item_id = ply.InventoryItems.SlotCache[4]
					SOCIOPATHY_PROJECT.GameLogic:DropItem(ply, drop_item_id, drop_item_config)
				else
					local drop_item_id = ply.InventoryItems.SlotCache[active_item_id]
					SOCIOPATHY_PROJECT.GameLogic:DropItem(ply, drop_item_id, active_item_cfg)
				end
			end
			local n_item_id =  #ply.InventoryItems.SlotCache+1
			ply.InventoryItems.SlotCache[n_item_id] = item_id
			ply.InventoryItems.ItemsCache[item_id] = n_item_id
			-- ply.InventoryItems.SelectedItem = item_id
			if SERVER then
				SOCIOPATHY_PROJECT.GameLogic:SwitchItemOnHand(ply, n_item_id)
			end
			local data = SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, n_item_id)
			data.ItemData.SystemValues.ItemOwner = ply
			data.ItemData.SystemValues.InventoryID = ply
			data.ItemData.SystemValues.IsQuestItem = IsQuestItem
			if SERVER then
				if IsQuestItem then
					SOCIOPATHY_PROJECT.Quests:OnItemTaked(item_id)
				end
			end

			return true
		end
	else
		if SERVER then
			if IsQuestItem then
				SOCIOPATHY_PROJECT.Quests:OnItemTaked(item_id)
			end
		end
			return true
		-- SOCIOPATHY_PROJECT.GameLogic.TaskList[k].now_counter = 0

		-- SOCIOPATHY_PROJECT.GameLogic.TaskList_ItemsCallback[quest_data.item_type] = k
	end
	return false

	
end
if SERVER then
	util.AddNetworkString("FosterZ_SendPlaySound")	
	function SOCIOPATHY_PROJECT.GameLogic:PlaySound(pos, snd)
		net.Start("FosterZ_SendPlaySound")
		net.WriteVector(pos)
		net.WriteString(snd)
		net.Broadcast()		
	end
end
function SOCIOPATHY_PROJECT.GameLogic:PlaySound(pos, snd)
	sound.PlayFile( snd, "noplay", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:SetPos(pos)
			station:Play()
		end
	end )
end
net.Receive("FosterZ_SendPlaySound", function()
	local pos = net.ReadVector()
	local snd = net.ReadString()
	SOCIOPATHY_PROJECT.GameLogic:PlaySound(pos, snd)
	
	--local snd_data = sound.GetProperties(snd)

	
end)

function SOCIOPATHY_PROJECT.GameLogic:TakeItemFromPlayer(ply, s_item_id)


	local item_id = ply.InventoryItems.ItemsCache[s_item_id]

	local item_config = SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(ply, item_id)

	if SERVER then
		net.Start("FosterZ_TakeItemFromPlayer")
		net.WriteString(s_item_id)
		net.Send(ply)

		if item_config.ItemData.SystemValues.IsQuestItem then
			SOCIOPATHY_PROJECT.Quests:OnItemTaked(s_item_id, true)
		end
	else
		SOCIOPATHY_PROJECT.Sounds:PlaySound("HoldItem")
	end



	item_config.ItemData.SystemFunctions:OnDelete(item_config)

	ply.InventoryItems.ItemsCache[s_item_id] = nil


	ply.InventoryItems.SlotCache[item_id] = nil
	


	local n_table = {}

	for k,v in pairs(ply.InventoryItems.SlotCache) do
		local new_index = #n_table+1
		n_table[new_index] = v
		ply.InventoryItems.ItemsCache[v] = new_index
	end
	ply.InventoryItems.SlotCache = n_table
end


net.Receive("FosterZ_ChangeItemToThis", function(len, ply)
	local item_id = net.ReadUInt(16)
	if CLIENT then
		ply = LocalPlayer()
	end
	SOCIOPATHY_PROJECT.GameLogic:SwitchItemOnHand(ply, item_id)
end)


if CLIENT then
	hook.Add( "PlayerButtonDown", "SOCIOPATHY_PROJECT_PBDown", function( ply, button )
		if hook.Call("VGUI_MenuIsActive") == true then
			return
		end
		if button > 0 && button < 11 then
			local ItemKey = button - 1
			net.Start("FosterZ_ChangeItemToThis")
			net.WriteUInt(ItemKey, 16)
			net.SendToServer() 
		else
			net.Start("FosterZ_PressInGameKey")
			net.WriteUInt(button,32)
			net.SendToServer() 
		end
	end)
elseif game.SinglePlayer() then
	hook.Add( "PlayerButtonDown", "SOCIOPATHY_PROJECT_PBDown", function( ply, button )
		if hook.Call("VGUI_MenuIsActive") == true then
			return
		end
		if SERVER then
			if button > 0 && button < 11 then
				local ItemKey = button - 1
				SOCIOPATHY_PROJECT.GameLogic:SwitchItemOnHand(ply, ItemKey)
			else
				SOCIOPATHY_PROJECT.GameLogic:OnKeyPress(ply, button)
			end
		end
	end)
end

if SERVER && !game.SinglePlayer() then return end
SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers = {}
SOCIOPATHY_PROJECT.GameLogic.OwnedFlags = {
	["unlocked"] = true,
}

for k,v in pairs(SOCIOPATHY_PROJECT.CONFIG.PLAYERS) do
	if SOCIOPATHY_PROJECT.GameLogic.OwnedFlags[v.index_key] == true then
		SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[#SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers+1] = v.system_name
	end
end

local CheatCodes = {
	['ActivePlayerModel'] = function()
		local user_flag = net.ReadString()
		if SOCIOPATHY_PROJECT.GameLogic.OwnedFlags[user_flag] == true then return end
		for k,v in pairs(SOCIOPATHY_PROJECT.CONFIG.UNLOCK_INDEXATION[user_flag]) do
			SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[#SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers+1] = v
		end		
		SOCIOPATHY_PROJECT.GameLogic.OwnedFlags[user_flag] = true
	end,
}

net.Receive("FosterZ_GiveItemToPlayer", function()
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(LocalPlayer(), net.ReadString(), net.ReadBool())
end)
net.Receive("FosterZ_TakeItemFromPlayer", function()
	SOCIOPATHY_PROJECT.GameLogic:TakeItemFromPlayer(LocalPlayer(), net.ReadString())
end)

net.Receive("FosterZ_ActivateCheatCode", function()
	CheatCodes[net.ReadString()]()
end)

net.Receive("FosterZ_SetPlayerModel", function()
	local skin_id = net.ReadString()

	SOCIOPATHY_PROJECT.VGUI:EntSetupSpriteRender(LocalPlayer(), Material("materials/kishkixd/players/" .. SOCIOPATHY_PROJECT.CONFIG.PLAYERS[skin_id].character_image .. ".png"), 228*0.16, 505*0.16)
end)

if CLIENT then
	net.Receive("FosterZ_StartGame", function()
		SOCIOPATHY_PROJECT.Sounds:ClearAll_ControlledBGMSound()
		SOCIOPATHY_PROJECT.VGUI:CloseMenu()
		SOCIOPATHY_PROJECT.Sounds:StopBGMSound()
		-- SOCIOPATHY_PROJECT.Sounds:PlayBGMSound("Game_NormalAmbient")
		SOCIOPATHY_PROJECT.LocalVars.GameStarted = true

	end)
end

net.Receive("FosterZ_WeaponEnterKey", function()
	local uint = net.ReadUInt(32)
	local btn = net.ReadUInt(32)


	local weapon = SOCIOPATHY_PROJECT.GameLogic:GetPlayerItemData(nil, uint)
	if weapon != nil then
		weapon.ItemData.SystemFunctions:OnKeyEnter(weapon, btn)
	end
end)

hook.Add( "PlayerFootstep", "SOCIOPATHY_PROJECT_PlayerFootstep", function( ply, pos, foot, sound, volume, rf )
	local snd_index = math.random(1,4)
	ply:EmitSound( "fosterz/kishkixd/footsteps/FootstepsConcrete".. snd_index..".mp3" ) 
	ply:EmitSound( "fosterz/kishkixd/footsteps/FootstepsConcrete".. snd_index..".mp3" ) 
	return true -- Don't allow default footsteps, or other addon footsteps
end )
