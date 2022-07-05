util.AddNetworkString("FosterZ_StartGame")
util.AddNetworkString("FosterZ_LoseGame")
util.AddNetworkString("FosterZ_WinGame")
util.AddNetworkString("FosterZ_ActivateCheatCode")
util.AddNetworkString("FosterZ_SendOpenMenu")
util.AddNetworkString("FosterZ_SetPlayerModel")
util.AddNetworkString("FosterZ_GiveItemToPlayer")


util.AddNetworkString("FosterZ_SetupPlayerTables")

util.AddNetworkString("FosterZ_WeaponEnterKey")
util.AddNetworkString("FosterZ_PressInGameKey")

util.AddNetworkString("FosterZ_TakeItemFromPlayer")
util.AddNetworkString("FosterZ_TakeDroppedItem")
util.AddNetworkString("FosterZ_ChangeItemToThis")
util.AddNetworkString("FosterZ_DropItem")
util.AddNetworkString("FosterZ_UseItem")


util.AddNetworkString("FosterZ_PlayWorldSound")
util.AddNetworkString("FosterZ_ChangeLevel")

util.AddNetworkString("FosterZ_InitMonster")

util.AddNetworkString("SendGenerateMSG")

local function ActivatePlayerModel(ply, model)
	net.Start("FosterZ_ActivateCheatCode")
	net.WriteString("ActivePlayerModel")
	net.WriteString(model)
	net.Send(ply)
end 


hook.Add( "CheckPassword", "SOCIOPATHY_PROJECT_CheckPassword", function( steamID64 )
	if #player.GetHumans() > 0 then
		return false
	end
end )

hook.Add( "PlayerSpray", "SOCIOPATHY_PROJECT_DisablePlayerSpray", function( ply )
	return true
end )

SOCIOPATHY_PROJECT.GameLogic.CheatCodes = {
	[3059] = function(ply) -- "KISHKI"

	end,
	[4015] = function(ply) -- "FOSTERZ"

	end,
	[3190] = function(ply) -- "GODGODGOD"

	end,
	[3178] = function(ply) -- "DEADINSIDE"

	end,
	[11] = function(ply) -- "0000000000"

	end,
	[2369] = function(ply) -- "HESOYAM"

	end,
	[2473] = function(ply) -- 'MANHUNT'
		ActivatePlayerModel(ply, "cerber")
		

	end,
	[5849] = function(ply) -- 'PIZZABOY'
		
	end,
	[2354] = function(ply) -- 'KONAMI'
		
	end,
	[4495] = function(ply) -- 'PUPPET'
		
	end,
	[199] = function(ply) -- '1488'
		
	end,
	[122] = function(ply) -- '1337'
		
	end,
	[2785] = function(ply) -- 'NUCLEAR'
		
	end,
	[2213] = function(ply) -- 'GHOST'
		
	end,
	[317] = function(ply) -- '1234567890'
		
	end,
	[1141] = function(ply) -- 'BIKER'
		ActivatePlayerModel(ply, "biker")

	end,
	[1565] = function(ply)
		ActivatePlayerModel(ply, "masyna")
	end,


}


function SOCIOPATHY_PROJECT.GameLogic:ChangeLevel(map)
	RunConsoleCommand("changelevel", map)
end



net.Receive("FosterZ_ChangeLevel", function(len,ply)
	local map = net.ReadString()
	if map == "!" then
		local maps = file.Find( "maps/*.bsp", "GAME" )
		local map_list = {}
		for k, v in ipairs( maps ) do
			local name = string.lower( string.gsub( v, "%.bsp$", "" ) )
			local prefix = string.match( name, "^(.-_)" )
			map_list[#map_list+1] = name
		end
		while (map == game.GetMap() or map == "!") do
			map = table.Random(map_list)
		end
	end
	SOCIOPATHY_PROJECT.GameLogic:ChangeLevel(map)
end)



net.Receive("FosterZ_ActivateCheatCode", function(len, ply)
	local int = net.ReadUInt(32)
	print(int)
	if SOCIOPATHY_PROJECT.GameLogic.CheatCodes[int] != nil then
		SOCIOPATHY_PROJECT.GameLogic.CheatCodes[int](ply)
		SOCIOPATHY_PROJECT.Sounds:PlaySound("SuccessCode", ply)
	else
		SOCIOPATHY_PROJECT.Sounds:PlaySound("ErrorCode", ply)
	end
end)

local function SetPlayerModel(ply, skin_id)
	net.Start("FosterZ_SetPlayerModel")
	net.WriteString(skin_id)
	net.Send(ply)
end




function SOCIOPATHY_PROJECT.GameLogic:ResetPlayerGameValues(ply)

	ply:SetNWFloat("Game_Stress", 100)
	ply:SetNWFloat("Game_Stamina", 100 )
	ply:SetNWBool("broken_eye_r", false)
	ply:SetNWBool("broken_eye_l", false)
end
function SOCIOPATHY_PROJECT.GameLogic:ResetPlayer(ply)
	ply:Lock()
	SOCIOPATHY_PROJECT.GameLogic:ResetPlayerGameValues(ply)
end
hook.Add( "WeaponEquip", "SOCIOPATHY_PROJECT_WeaponEquipExample", function( weapon, ply )
	weapon:Remove()
end )

function SOCIOPATHY_PROJECT.GameLogic:SetupPlayerToStart(ply, model, gm_id)

	ply:Spawn()


	ply.StartTime = SysTime()
	SOCIOPATHY_PROJECT.GameLogic:SetupPlayerTables(ply)

	SetPlayerModel(ply, model)

	ply:UnLock()

	
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, ( math.random(1,2) == 2) && "item_camera" or "item_gasmask" )
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_lighter")
	-- SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_camera")
	--[[ 
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_gasmask") 

	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_camera")

	

	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_healer")
	
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_minihealer")
	
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_radio")
	SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, "item_shotgun")--]] 


	
	
	SOCIOPATHY_PROJECT.GameLogic:ResetPlayerGameValues(ply)


	net.Start("FosterZ_StartGame")
	net.Send(ply)
end

function SOCIOPATHY_PROJECT.GameLogic:ThinkPlayer(ply)
	
end



hook.Add( "GetFallDamage", "SOCIOPATHY_PROJECT_GetFallDamage", function( ply, speed )
	return math.max( 0, math.ceil( 0.2418 * speed - 141.75 ) )
end )

hook.Add("PlayerDeath", "SOCIOPATHY_PROJECT_PlayerDeath", function(ply, weapon, attacker)
	
	SOCIOPATHY_PROJECT.GameLogic:ResetPlayer(ply)
	ply:SetNWInt("GameRecord", math.floor(SysTime() - ply.StartTime))
	timer.Simple(1, function()
		net.Start("FosterZ_LoseGame")
		net.Send(ply)
	end)
	ply:EmitSound("fosterz/kishkixd/damage/goresplat.mp3")

	for k,v in pairs(ents.FindByClass("npc_hunter")) do
		v:Remove()
	end
end)
function SOCIOPATHY_PROJECT.GameLogic:AttackPlayer(ply, from, dmg)

	ply:GodDisable()

	
	from.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnEnemyAttacked", ply, from.ClassConfig)	



	ply:SetHealth(ply:Health()-dmg)

	if dmg > 10 then
		local chanse_to_eye = math.random(0,4) == 4
		if chanse_to_eye then
			local eye_left = math.random(0,1) == 1
			local eye_broken = ply:GetNWBool("broken_eye_r") or ply:GetNWBool("broken_eye_l")
			if !eye_broken then
				ply:SetNWBool("broken_eye_r", eye_left)
				ply:SetNWBool("broken_eye_l", !eye_left)
			end
		end
	end
	if ply:Health() < 1 then
		ply:Kill()
		from.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnEnemyKilled", ply, from.ClassConfig)	
		from:Remove()

	end
end


function SOCIOPATHY_PROJECT.GameLogic:GameModeEnd()
	game.CleanUpMap()

	for k, ply in pairs(player.GetAll()) do
		ply:SetNWInt("GameRecord", math.floor(SysTime() - ply.StartTime))
		SOCIOPATHY_PROJECT.GameLogic:ResetPlayer(ply)	
	end
	
	
	net.Start("FosterZ_WinGame")
	net.Broadcast()
end

function SOCIOPATHY_PROJECT.GameLogic:SetupGameWorld(gm_id)


	game.CleanUpMap()

	SOCIOPATHY_PROJECT.GameLogic.TaskList = {}


	
	local nav = table.Random(navmesh.GetAllNavAreas())
	if nav == nil then
		net.Start("SendGenerateMSG")
		net.Broadcast()
		return
	end

	local _ ,key = table.Random(SOCIOPATHY_PROJECT.GameLogic.GameMonsters)
	SOCIOPATHY_PROJECT.GameLogic:SpawnMonster(key):SetPos(table.Random(navmesh.GetAllNavAreas()):GetCenter() + Vector(0,0,10) )

	SOCIOPATHY_PROJECT.Quests:GenerateTasks(gm_id == 0)


		-- 

	--[[ for k,v in pairs(navmesh.GetAllNavAreas()) do
		v:GetRandomPoint()
	end--]] 
end

net.Receive("FosterZ_StartGame", function(len, ply)
	local model = net.ReadString()
	local gm_id = net.ReadUInt(32)


	SOCIOPATHY_PROJECT.GameLogic:SetupPlayerToStart(ply, model, 1)

	game.GetWorld():SetNWString("GameModeID", gm_id)


	SOCIOPATHY_PROJECT.GameLogic:SetupGameWorld(gm_id)


	
end)


net.Receive("FosterZ_TakeDroppedItem", function(len, ply)
	-- 
end)
net.Receive("FosterZ_DropItem", function(len, ply)
	-- 
end)
net.Receive("FosterZ_UseItem", function(len, ply)
	-- 
end)


function SOCIOPATHY_PROJECT.GameLogic:OnKeyPress(ply, button)

	if ply._CanTakeItem != nil && button == KEY_E then
		if (SOCIOPATHY_PROJECT.GameLogic:GiveItemToPlayer(ply, ply._CanTakeItem:GetNWString("ItemID", nil), ply._CanTakeItem.IsQuestItem)) then

			for k,v in pairs(ents.FindByClass("npc_hunter")) do
				v.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnEnemyTakeItem", ply, v.ClassConfig)	
			end
			if IsValid(ply._CanTakeItem) then
				ply._CanTakeItem:Remove()
			end
		end
		return 
	end
	local weapon, weapon_id = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem(ply)
	if weapon != nil then

		weapon.ItemData.SystemFunctions:OnKeyEnter(weapon, button)
		net.Start("FosterZ_WeaponEnterKey")
		net.WriteUInt(weapon_id, 32)
		net.WriteUInt(button, 32)
		net.Send(ply)
	end	
end

net.Receive("FosterZ_PressInGameKey", function(len,ply)
	local button = net.ReadUInt(32)
	SOCIOPATHY_PROJECT.GameLogic:OnKeyPress(ply, button)

end)
-- SOCIOPATHY_PROJECT.GameLogic:SetupGameWorld(