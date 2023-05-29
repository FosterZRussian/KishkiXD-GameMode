include("cl_init.lua")

include("scripts/server/sv_gamelogic.lua")


hook.Add("PlayerSpawn", "SOCIOPATHY_PROJECT_PlayerSpawn", function(ply)


	ply:Remove()

	--SOCIOPATHY_PROJECT.GameLogic:ResetPlayer(ply)

	timer.Simple(0, function()
		PrintTable(player.GetAll())
	end)
	
	--ply:AllowFlashlight(false)

end)


local ENTS_WHITE_LIST = {
	--[[ ["info_player_start"] = true,
	['ai_hint'] = true,
	['info_ladder_dismount'] = true,
	['path_track'] = true,
	['path_corner'] = true,
	['worldspawn'] = true,
	-- ['point_spotlight'] = true,
	-- ['env_sun'] = true,
	['func_illusionary'] = true,
	['func_brush'] = true,
	['water_lod_control'] = true,
	['func_reflective_glass'] = true,
	-- ['light'] = true,
	--["phys_bone_follower"] = true,
	--['func_door_rotating'] = true,
	['func_nav_blocker'] = true,
	['func_button'] = true,
	['func_door_rotating'] = true,
	['beam'] = true,--]] 
	['prop_dynamic'] = true,
	['lua_run'] = true,
	['prop_physics'] = true,
	['light'] = true,
	['env_skypaint'] = true,
	['env_soundscape'] = true,
	['env_sun'] = true,
	['env_fog_controller'] = true,
	['sky_camera'] = true,
	['shadow_control'] = true,
	['light_environment'] = true,
	['env_tonemap_controller'] = true,
	['point_spotlight'] = true,
	['func_illusionary'] = true,
	['spotlight_end'] = true,
	['beam'] = true,
}


function S_ClearEnts()
	for k,v in pairs(ents.GetAll()) do

		if v:IsWeapon() then v:Remove()
			continue
		end
		if v:IsVehicle() then v:Remove()
			continue
		end
		if ENTS_WHITE_LIST[v:GetClass()] then
			--prop_door_rotating
			v:Remove()
		end
	end
end
hook.Add("PostCleanupMap", "SOCIOPATHY_PROJECT_PostCleanupMap", function()
	S_ClearEnts()
end)

