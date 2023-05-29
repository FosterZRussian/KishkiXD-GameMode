AddCSLuaFile()

if SERVER then return end

SOCIOPATHY_PROJECT.Render = {}



SOCIOPATHY_PROJECT.Render.ScreenMesh = {}
SOCIOPATHY_PROJECT.Render.ScreenMesh2 = {}
SOCIOPATHY_PROJECT.Render.RT = {}
SOCIOPATHY_PROJECT.Render.MAT = {}


SOCIOPATHY_PROJECT.Render.RT["MAIN"] = GetRenderTarget("S_EFFECT5", 1024, 1024)
SOCIOPATHY_PROJECT.Render.MAT["MAIN"] = CreateMaterial("S_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN"]:GetName(),
})
SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"] = GetRenderTarget("MAIN_BEFOREUI", 1024, 1024)
SOCIOPATHY_PROJECT.Render.MAT["MAIN_BEFOREUI"] = CreateMaterial("MAIN_BEFOREUI", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"]:GetName(),
})

SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS"] = GetRenderTarget("MAIN_RENDER_FOR_ITEMS", 1024*4, 1024*4) -- for items use
SOCIOPATHY_PROJECT.Render.MAT["MAIN_RENDER_FOR_ITEMS"] = CreateMaterial("MAIN_RENDER_FOR_ITEMS", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS"]:GetName(),
})

SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"] = GetRenderTarget("MAIN_RENDER_FOR_ITEMS_2", 1024*4, 1024*4) -- for items use
SOCIOPATHY_PROJECT.Render.MAT["MAIN_RENDER_FOR_ITEMS_2"] = CreateMaterial("MAIN_RENDER_FOR_ITEMS_2", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"]:GetName(),
})
SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_3"] = GetRenderTarget("MAIN_RENDER_FOR_ITEMS_3", 1024, 1024) -- for items use
SOCIOPATHY_PROJECT.Render.MAT["MAIN_RENDER_FOR_ITEMS_3"] = CreateMaterial("MAIN_RENDER_FOR_ITEMS_3", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_3"]:GetName(),
})

SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_4"] = GetRenderTarget("MAIN_RENDER_FOR_ITEMS_4", 1024, 1024) -- for items use
SOCIOPATHY_PROJECT.Render.MAT["MAIN_RENDER_FOR_ITEMS_4"] = CreateMaterial("MAIN_RENDER_FOR_ITEMS_4", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_4"]:GetName(),
})

SOCIOPATHY_PROJECT.Render.RT["RT_COLORED_ENTITIES"] = GetRenderTarget("RT_COLOREDENTITIES", ScrW(), ScrH())
SOCIOPATHY_PROJECT.Render.MAT["RT_COLORED_ENTITIES"] = CreateMaterial("RT_COLOREDENTITIES2", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["RT_COLORED_ENTITIES"]:GetName(),
	['$translucent'] = 1,
})
SOCIOPATHY_PROJECT.Render.RT["WRITE_SC_358256"] = GetRenderTarget("WRITE_SC_358256", 358, 256)
SOCIOPATHY_PROJECT.Render.MAT["WRITE_SC_358256"] = CreateMaterial("WRITE_SC_358256", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["WRITE_SC_358256"]:GetName(),
})


SOCIOPATHY_PROJECT.Render.RT["PP_EF"] = GetRenderTarget("PP_EF_EFFECT5", 1024, 1024)
SOCIOPATHY_PROJECT.Render.MAT["PP_EF"] = CreateMaterial("PP_EF_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["PP_EF"]:GetName(),
	['$translucent'] = 1,
})

SOCIOPATHY_PROJECT.Render.RT["PP_VGUI"] = GetRenderTarget("PP_VGUI_EFFECT5", 1024, 1024)
SOCIOPATHY_PROJECT.Render.MAT["PP_VGUI"] = CreateMaterial("PP_VGUI_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["PP_VGUI"]:GetName(),
	['$translucent'] = 1,
})


SOCIOPATHY_PROJECT.Render.RT["VEX_POINT"] = GetRenderTarget("VEX_POINT", 12, 12)
SOCIOPATHY_PROJECT.Render.MAT["VEX_POINT"] = CreateMaterial("VEX_POINT" .. SysTime(), "UnLitGeneric", {
	["$basetexture"] = SOCIOPATHY_PROJECT.Render.RT["VEX_POINT"]:GetName(),
	['$ignorez'] = 1,
	["$model"] = 1,
	['$additive'] = 1,
	['$vertexcolor'] = 1,
})

render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["VEX_POINT"])
	render.Clear(0,0,0,0,true,true)
	cam.Start2D()
		surface.SetDrawColor(255,255,255,255)
		surface.DrawRect(3,3,2,2)
	cam.End2D()
render.PopRenderTarget()

SOCIOPATHY_PROJECT.Render.MAT["RED_VHS"] = CreateMaterial("RED_VHS_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = "!",
    ["$additive"] = "1",
    ["$color2"] = "[1 0 0]",
})
SOCIOPATHY_PROJECT.Render.MAT["GREEN_VHS"] = CreateMaterial("GREEN_VHS_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = "!",
    ["$additive"] = "1",
    ["$color2"] = "[0 1 0]",
})
SOCIOPATHY_PROJECT.Render.MAT["BLUE_VHS"] = CreateMaterial("BLUE_VHS_EFFECT5", "UnLitGeneric", {
	["$basetexture"] = "!",
    ["$additive"] = "1",
    ["$color2"] = "[0 0 1]",
})

local function _RenderCA_Effect(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)

    local NUPD_RT_TEX = render.GetScreenEffectTexture()        

    SOCIOPATHY_PROJECT.Render.MAT["RED_VHS"]:SetTexture("$basetexture", NUPD_RT_TEX)
    local R_EFFECT_POS_OFFSET_X = 0 -- GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_r_x"):GetFloat()        
    local R_EFFECT_POS_OFFSET_Y = -2 -- GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_r_y"):GetFloat()
    render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["RED_VHS"]) 
    render.DrawScreenQuadEx((R_EFFECT_POS_OFFSET_X > 0 && -R_EFFECT_POS_OFFSET_X) or 0, (R_EFFECT_POS_OFFSET_Y > 0 && -R_EFFECT_POS_OFFSET_Y) or 0, (R_EFFECT_POS_OFFSET_X > 0 && ScrW()+R_EFFECT_POS_OFFSET_X) or ScrW()-R_EFFECT_POS_OFFSET_X*2, (R_EFFECT_POS_OFFSET_Y > 0 && ScrH()+R_EFFECT_POS_OFFSET_Y) or ScrH()-R_EFFECT_POS_OFFSET_Y*2) 


    SOCIOPATHY_PROJECT.Render.MAT["GREEN_VHS"]:SetTexture("$basetexture", NUPD_RT_TEX)
    local G_EFFECT_POS_OFFSET_X = -STRESS_LEVEL * 20 --GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_g_x"):GetFloat()                
    local G_EFFECT_POS_OFFSET_Y = 0 --GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_g_y"):GetFloat()
    render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["GREEN_VHS"]) 
    render.DrawScreenQuadEx((G_EFFECT_POS_OFFSET_X > 0 && -G_EFFECT_POS_OFFSET_X) or 0, (G_EFFECT_POS_OFFSET_Y > 0 && -G_EFFECT_POS_OFFSET_Y) or 0, (G_EFFECT_POS_OFFSET_X > 0 && ScrW()+G_EFFECT_POS_OFFSET_X) or ScrW()-G_EFFECT_POS_OFFSET_X*2, (G_EFFECT_POS_OFFSET_Y > 0 && ScrH()+G_EFFECT_POS_OFFSET_Y) or ScrH()-G_EFFECT_POS_OFFSET_Y*2) 

    SOCIOPATHY_PROJECT.Render.MAT["BLUE_VHS"]:SetTexture("$basetexture", NUPD_RT_TEX)
    local B_EFFECT_POS_OFFSET_X = 10 --GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_b_x"):GetFloat()                        
    local B_EFFECT_POS_OFFSET_Y = STRESS_LEVEL * 20 --GetConVar("pp_fz_ps1_shader_seffect_vhs_en_offs_b_y"):GetFloat()
    render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["BLUE_VHS"]) 
    render.DrawScreenQuadEx((B_EFFECT_POS_OFFSET_X > 0 && -B_EFFECT_POS_OFFSET_X) or 0, (B_EFFECT_POS_OFFSET_Y > 0 && -B_EFFECT_POS_OFFSET_Y) or 0, (B_EFFECT_POS_OFFSET_X > 0 && ScrW()+B_EFFECT_POS_OFFSET_X) or ScrW()-B_EFFECT_POS_OFFSET_X*2, (B_EFFECT_POS_OFFSET_Y > 0 && ScrH()+B_EFFECT_POS_OFFSET_Y) or ScrH()-B_EFFECT_POS_OFFSET_Y*2) 

end


local x_size, y_size = 10,5

local function _GenerateScreenMesh()
	for x = 1, x_size do
		for y = 1, y_size do
			SOCIOPATHY_PROJECT.Render.ScreenMesh2[x] = SOCIOPATHY_PROJECT.Render.ScreenMesh2[x] or {}
			SOCIOPATHY_PROJECT.Render.ScreenMesh2[x][y] = {
				{ pos = Vector( 0, 0+(2*x), 0-(y*2) ), u = (x-1)/(x_size), v = y/y_size }, 
				{ pos = Vector( 0, 0+(2*x), 2-(y*2) ), u = (x-1)/(x_size), v = (y-1)/y_size }, 
				{ pos = Vector( 0, 2+(2*x), 0-(y*2) ), u = (x)/(x_size), v = y/y_size }, 
		
				{ pos = Vector( 0, 2+(2*x), 0-(y*2) ), u = x/x_size, v = y/y_size }, 
				{ pos = Vector( 0, 0+(2*x), 2-(y*2) ), u = (x-1)/x_size, v = (y-1)/y_size }, 
				{ pos = Vector( 0, 2+(2*x), 2-(y*2) ), u = x/x_size, v = (y-1)/y_size },  
			}

			for k,v in pairs(SOCIOPATHY_PROJECT.Render.ScreenMesh2[x][y]) do
				v.show_pos = Vector(v.pos.x,v.pos.y, v.pos.z)
			end
		end
	end

	

end
_GenerateScreenMesh()

local UPD_CT = 0


local tbs = {
	[ "$pp_colour_addr" ] = 0.0,
	[ "$pp_colour_addg" ] = 0.0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0.02,
	[ "$pp_colour_mulb" ] = 0
}
--local pattern = Material("pp/texturize/pattern1.png")


if CLIENT then
	hook.Add( "HUDShouldDraw", "SOCIOPATHY_PROJECT_HideHUD", function( name )
		return false
	end )
	
end


local function _DrawItemInsideHud(pos, icon, label)

	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("materials/kishkixd/objects/" .. icon))

	local x_pos, y_pos = ScrW()-120,80+90*pos
	surface.DrawTexturedRect(x_pos, y_pos,100,100)

	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( x_pos-80, y_pos ) 
	surface.DrawText( label )
end

function SOCIOPATHY_PROJECT.VGUI:EntSetupSpriteRender(ent, sprite_material, size_x, size_y)
	ent.RenderOverride = function(self)
		local eye_ang = EyeAngles()
		cam.Start3D2D( ent:GetPos(), Angle(0,eye_ang,90) ,1)--Angle(0,eye_ang.y,0) + Angle(0,-90,90), 1 )
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(sprite_material)
			surface.DrawTexturedRect(-size_x/2,-size_y,size_x,size_y)			
		cam.End3D2D()
		
	end
end

local function _DrawHud(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)



	
	if LocalPlayer():Health() < 1 or !LocalPlayer():Alive() then
		return
	end

	if !SOCIOPATHY_PROJECT.LocalVars.GameStarted then
		--return
	end

	local ActiveItem = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem()
	if ActiveItem != nil then
		ActiveItem.ItemData.SystemFunctions:ScreenDraw_UI(ActiveItem, SCR_W, SCR_H)
	end

	surface.SetDrawColor(0,0,0)
	surface.DrawRect(20,ScrH()-80,200,40)
	surface.SetDrawColor(150,0,0)
	surface.DrawRect(30,ScrH()-75,185*LocalPlayer():GetNWFloat("Game_Stress", 0)/100,30)

	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 30,ScrH()-120 ) 
	surface.DrawText( "STREsS" )



	surface.SetDrawColor(0,0,0)
	surface.DrawRect(20,ScrH()-80-200,200,40)
	surface.SetDrawColor(150,0,0)
	surface.DrawRect(30,ScrH()-75-200,185*LocalPlayer():GetNWFloat("Game_Stamina", 0)/100,30)

	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 30,ScrH()-120-200 ) 
	surface.DrawText( "STAMINA" )

	if game.GetWorld():GetNWBool("IsQuest_Mode") then --game.GetWorld():GetNWInt("GameModeID") == 0 then
		local quests = game.GetWorld():GetNWInt("Game_Quest_Count", 0)
		if quests != 0 then
			for k = 1, quests do

				local sub_quest_id = game.GetWorld():GetNWInt("Game_Quest_ID_" .. k , 1) 
				local quest_data = SOCIOPATHY_PROJECT.Quests.Tasks[k][sub_quest_id]

				surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
				surface.SetTextColor( 255, 0, 0 )
				surface.SetTextPos( 30,30 + 110 *(k-1) ) 
				surface.DrawText( quest_data.title )

				surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
				surface.SetTextColor( 255, 200, 0 )
				surface.SetTextPos( 60,100 + 110 *(k-1) ) 
				surface.DrawText( game.GetWorld():GetNWInt("Game_Quest_Progress_" .. k , 0) .. "/" .. quest_data.count )
			end
		end
	else
		surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
		surface.SetTextColor( 255, 0, 0 )
		surface.SetTextPos( 30,30 + 110 ) 
		surface.DrawText( "[SURVIVE]" ) 

		surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
		surface.SetTextColor( 255, 200, 0 )
		surface.SetTextPos( 60,100 + 110  ) 
		surface.DrawText( string.FormattedTime( CurTime() - (LocalPlayer().StartedTime or 0) , "%02i:%02i:%02i" ) )

	end

	if LocalPlayer().InventoryItems != nil then
		for k,v in pairs(LocalPlayer().InventoryItems.SlotCache or {}) do
			local label = LocalPlayer().InventoryItems.SelectedItem == k && "[G]" or "[" .. k .. "]"
			_DrawItemInsideHud(k, SOCIOPATHY_PROJECT.GameLogic.GameItems[v].MetaData.ItemIcon .. ".png", label)
		end
	end

	
	if LocalPlayer()._CanTakeItem != nil then
		surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
		surface.SetTextColor( 255, 255, 255 )
		surface.SetTextPos( ScrW()/2 - 250,ScrH()/2+150 ) 
		surface.DrawText( "PRESS [E] TO TAKE" )
	end
	if LocalPlayer()._CanInteractiveItem != nil then
		surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
		surface.SetTextColor( 255, 255, 255 )
		surface.SetTextPos( ScrW()/2 - 250,ScrH()/2+150 ) 
		surface.DrawText( "PRESS [E] TO USE" )
	end
	
end




function SOCIOPATHY_PROJECT.VGUI:AddVGUIToRender(panel, is_game)
		
	panel:SetMouseInputEnabled(false)	
	panel:SetPaintedManually(true)

	local tb = is_game && SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_PRE or SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_POST
	tb[panel] = panel
end


local Effects2D = {
	['VHS_EF_1'] = 0
}

local _HeartBeat = false
local _HeartBoost = 4


local function _Draw2DEffects(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)


	surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["RT_COLORED_ENTITIES"])
	surface.DrawTexturedRect(0,0,ScrW(),ScrH())
	render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["RT_COLORED_ENTITIES"])
	render.Clear(0,0,0,0,true,true)
	render.PopRenderTarget()



	--[[ surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial(Material("materials/kishkixd/effects/jiga.png"))
	surface.DrawTexturedRect(ScrW()-500,ScrH()-500,500,500)--]] 

	local ActiveItem = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem()
	if ActiveItem != nil then
		ActiveItem.ItemData.SystemFunctions:ScreenDraw_First(ActiveItem, SCR_W, SCR_H)
	end

		
	local min_enemy = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy

	if min_enemy != nil then
		if min_enemy.ClassSetuped then
			min_enemy.ClassConfig.SystemMethods.CallMethod("RenderMethods" , "OnDrawEffects", {
				SCR_W = SCR_W, SCR_H = SCR_H, nowFrameLerping = nowFrameLerping, CAN_UPDATE = CAN_UPDATE, STRESS_LEVEL = STRESS_LEVEL,
			}, min_enemy.ClassConfig)
		end
	end
	

	surface.SetDrawColor(0,0,0,255)
	surface.SetMaterial(Material("materials/kishkixd/effects/heartbeat_mask.png"))
	
	if CAN_UPDATE then
		if STRESS_LEVEL > 0 then 
			if _HeartBeat then
				_HeartBoost = math.Approach(_HeartBoost, 4.2, 0.1)
				if _HeartBoost > 4 then
					_HeartBeat = false
				end
			else
				_HeartBoost = math.Approach(_HeartBoost, 2.5-STRESS_LEVEL, 0.10*30 * STRESS_LEVEL)
				if _HeartBoost <= 2.5-STRESS_LEVEL then
					_HeartBeat = true
					SOCIOPATHY_PROJECT.Sounds:PlaySound("HeartBeat")
				end
			end
		else
			_HeartBoost = math.Approach(_HeartBoost, 4, 0.10)
		end
	end
	local boost = _HeartBoost
	local offseT_x = ScrW() - (ScrW() * boost)
	local offseT_y = ScrH() - (ScrH() * boost)
	surface.DrawTexturedRect(offseT_x/2,offseT_y/2,ScrW()*boost,ScrH()*boost,0)
	

	if LocalPlayer():Health() < 1 or !LocalPlayer():Alive() then
		surface.SetDrawColor(255,255,255,blood_alpha)
		surface.SetMaterial(Material("materials/kishkixd/ui/deathscreen.png"))
		surface.DrawTexturedRect(0,0,ScrW(),ScrH())
	end

	local blood_alpha = ((LocalPlayer():GetMaxHealth()-LocalPlayer():Health()) / LocalPlayer():GetMaxHealth()) * 255
	surface.SetDrawColor(255,255,255,blood_alpha)
	surface.SetMaterial(Material("materials/kishkixd/effects/blood.png"))
	surface.DrawTexturedRect(0,0,ScrW(),ScrH())

	if LocalPlayer():GetNWBool("broken_eye_r") == true then 

		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material("materials/kishkixd/effects/blood_r_mask.png"))
		surface.DrawTexturedRect(0,0,ScrW(),ScrH())

		surface.SetMaterial(Material("materials/kishkixd/effects/blood_r.png"))
		surface.DrawTexturedRect(0,0,ScrW(),ScrH())
	end
	if LocalPlayer():GetNWBool("broken_eye_l") == true then 

		local offseT_ = ScrW() - (ScrW() * 1.2)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material("materials/kishkixd/effects/blood_r_mask.png"))
		surface.DrawTexturedRectUV(-offseT_,0,ScrW()+offseT_,ScrH(), 1,1,0,0)

		surface.SetMaterial(Material("materials/kishkixd/effects/blood_r.png"))
		surface.DrawTexturedRectUV(-offseT_,0,ScrW()+offseT_,ScrH(), 1,1,0,0)
	end



	-- screen outline lines
--[[ 	surface.SetDrawColor(255,0,0,255)
	surface.DrawTexturedRect(0,-3,ScrW(),6)
	surface.DrawTexturedRect(-3,0,6,ScrH())--]] 

end

local function _DrawVGUI(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)
	for k,v in pairs(SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_PRE) do
		if !IsValid(v) then
			SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_PRE[k] = nil
			v = nil
		else
			v:PaintManual()
		end 
		
	end
end
local function _PostDrawVGUI(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)
	for k,v in pairs(SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_POST) do
		if !IsValid(v) then
			SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_POST[k] = nil
			v = nil
		else
			v:PaintManual()
		end 
	end
end
local function _PostDraw2DEffects(SCR_W, SCR_H, nowFrameLerping, CAN_UPDATE, STRESS_LEVEL)
		render.SetWriteDepthToDestAlpha( false )
		render.OverrideBlend( true, 1, 1, 4 )


			surface.SetDrawColor(150,150,150,255)
			surface.SetMaterial(Material("materials/kishkixd/effects/vhs_ef_2.png"))
			surface.DrawTexturedRect(Effects2D['VHS_EF_1'],0,ScrW(),ScrH())
			surface.DrawTexturedRect(-ScrW()+Effects2D['VHS_EF_1'],0,ScrW(),ScrH())


			surface.DrawTexturedRect(Effects2D['VHS_EF_1'],0,ScrW(),ScrH())
			surface.DrawTexturedRect(ScrW()+Effects2D['VHS_EF_1'],0,ScrW(),ScrH())
			if CAN_UPDATE then
				Effects2D['VHS_EF_1'] = Effects2D['VHS_EF_1'] + 1 
			end
			if Effects2D['VHS_EF_1'] > ScrW() then
				Effects2D['VHS_EF_1'] = 0
			end

		render.OverrideBlend( false )
		render.SetWriteDepthToDestAlpha( true )
end


hook.Add( "CalcView", "MyCalcView", function( ply, pos, angles, fov )

	
	if CLIENT then
		local min_enemy = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy
		local min_enemy_dist = SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemyDist
		if min_enemy != nil && min_enemy_dist < 400 then
			angles = angles + Angle(0,0,20)
		end
		if ply._EyeMovePos_y != nil then
			pos.z = pos.z + ply._EyeMovePos_y
		end
	end


	local view = {
		origin = pos,
		angles = angles,
		fov = 55,
		drawviewer = false
	}

	return view
end )



local function _EasyLerp(value, from, to)
	if from < to then
		from = from + value
	else
		from = from - value
	end
	return from

end
local C_FrameLerp = SysTime()

local is_Cleared = false



local panics_boobs = {
	[4] = 1,
	[3] = 0.75,
	[2] = 0.5,
	[1] = 0.25,

}

local GraphicsStyles = {}
GraphicsStyles[1] = function()
	DrawTexturize(100, Material("materials/kishkixd/effects/dd_.png") )
end
GraphicsStyles[2] = function()
	DrawTexturize(51.5, Material("materials/kishkixd/effects/crt_lines.png") )
end

GraphicsStyles[3] = function()
	DrawTexturize(1.75, Material("materials/kishkixd/effects/dd_7.png") )
end
GraphicsStyles[4] = function()
	DrawTexturize(1.35, Material("materials/kishkixd/effects/dd_3.png") )
end
GraphicsStyles[5] = function()
	DrawTexturize(98.2, Material("materials/kishkixd/effects/dd_4.png") )
end
GraphicsStyles[6] = function()
	DrawTexturize(1000, Material("materials/kishkixd/effects/dd_5.png") )
end

GraphicsStyles[7] = function(check_call)
	if check_call then
		--return 
	end
	DrawTexturize(10.4, Material("materials/kishkixd/effects/dd_6.png") )
	return false
	
end

GraphicsStyles[8] = function(check_call)
	if check_call then
		--return -- true
	end
	DrawTexturize(1, Material("materials/kishkixd/effects/dd82.png") )
	return false
	
end
GraphicsStyles[9] = function(check_call)
	if check_call then
		--return -- true
	end
	
	DrawTexturize(2.23, Material("materials/kishkixd/effects/dd9.png") )
	return false
	
end

GraphicsStyles[10] = function(check_call)
	if check_call then
		--return -- true
	end
	
	DrawTexturize(1.225, Material("materials/kishkixd/effects/dd10.png") )
	return false
	
end



hook.Add("RenderScreenspaceEffects", "SOCIOPATHY_PROJECTRenderScreenspaceEffects", function(depht, sky, d)


	--if 1== 1 then return end
    	
	--	DrawSobel( 0.5 )
	--DrawColorModify(tbs)
	--DrawSharpen( 1.2, 1.2 )
	
	
	-- DrawTexturize(100, Material("materials/kishkixd/effects/dd_.png") )	

	
	
	local now_effectt = GetConVar("kishki_render_eff_preset"):GetInt()
	local check_call = GraphicsStyles[now_effectt](true)



	local SCR_W, SCR_H = ScrW(), ScrH()

	local nowFrameLerping = SysTime() - C_FrameLerp


	local CAN_UPD = CurTime() > UPD_CT

	if CAN_UPD then
		local next_vsthink = (1-FrameTime())/30
		UPD_CT = CurTime() + next_vsthink
	end
	
	local ply = LocalPlayer()

	local stress_level = 1 - (ply:GetNWFloat("Game_Stress", 0 )/100)

	ply._FrameCanUpdate = CAN_UPD


	local ActiveItem = SOCIOPATHY_PROJECT.GameLogic:GetPlayerActiveItem()

	cam.Start3D()
		for k,v in pairs(ents.GetAll()) do
			if v.DrawColored != nil then
				v:DrawColored()
			end
		end
		
		local now_world = SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable(game.GetWorld():GetNWString("GameModeID"))
		if now_world != nil then
			now_world:PreDraw3D()
		end

		if ActiveItem != nil then

			ActiveItem.ItemData.SystemFunctions:ScreenDraw_PreDraw3D(ActiveItem, SCR_W, SCR_H)
		end

	cam.End3D()

	
	--[[ render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"])

	render.PopRenderTarget()	--]] 


    render.UpdateScreenEffectTexture()      



	render.CopyTexture(render.GetScreenEffectTexture(), SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"])	

	--render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"])
	cam.Start2D()
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["MAIN_BEFOREUI"])
		surface.DrawTexturedRectUV(0,0,ScrW(),ScrH(),1,0,0,1)


		
		if ActiveItem != nil then
			ActiveItem.ItemData.SystemFunctions:ScreenDraw_PreDraw(ActiveItem, SCR_W, SCR_H)
		end

	cam.End2D()

    render.UpdateScreenEffectTexture()      
	render.CopyTexture(render.GetScreenEffectTexture(), SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"])

	--render.PopRenderTarget()	

	cam.Start2D()

		
		_Draw2DEffects(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)
		if check_call then
			GraphicsStyles[now_effectt](false)
		end

		

		_DrawHud(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)

		_DrawVGUI(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)
		_PostDraw2DEffects(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)
        render.UpdateScreenEffectTexture()
		_RenderCA_Effect(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)
		_PostDrawVGUI(SCR_W, SCR_H, nowFrameLerping, CAN_UPD, stress_level)
	cam.End2D()


	--if SysTime() - C_FrameLerp > 0.1 then
	C_FrameLerp = SysTime()
	

	


    render.UpdateScreenEffectTexture()      
    render.ResetToneMappingScale(1)

    --[[ render.CopyTexture(SOCIOPATHY_PROJECT.Render.RT["MAIN"], render.GetScreenEffectTexture())

	render.CopyRenderTargetToTexture(SOCIOPATHY_PROJECT.Render.RT["MAIN"])--]] 



	render.CopyTexture(render.GetScreenEffectTexture(), SOCIOPATHY_PROJECT.Render.RT["MAIN"])





	SOCIOPATHY_PROJECT.Render.MAT["MAIN"]:SetTexture( "$basetexture",  SOCIOPATHY_PROJECT.Render.RT["MAIN"])


	
	render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["WRITE_SC_358256"])
	cam.Start2D()

	
	
	if CAN_UPD then
		render.Clear(0,0,0,0,true, true)

		surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["MAIN"])
		surface.DrawTexturedRectUV(0,0,ScrW(),ScrH(),0,0,1,1)

		


		render.CopyRenderTargetToTexture(SOCIOPATHY_PROJECT.Render.RT["WRITE_SC_358256"])
	end
	cam.End2D()


	render.PopRenderTarget()

	

	render.Clear(0,0,0,0,true,true)

	

	cam.Start3D(nil, nil,nil, nil,nil, nil,nil, 1, 0)
	
	render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["WRITE_SC_358256"])

	mesh.Begin( MATERIAL_TRIANGLES, x_size*y_size*3) 


	local eyeang = EyeAngles() 



	   
	
	local mesh_AddVecOffset = Vector(0,7.5,3)
	local forward_distance = 18 
	if ScrH() % 3 == 0 && ScrW() % 4 == 0 then
		forward_distance = forward_distance + 5
	end
	mesh_AddVecOffset:Rotate(eyeang)

	local mesh_rotateAng = Angle(-eyeang.x,eyeang.y+180,-eyeang.z)

	forward_distance = forward_distance - (GetConVar("kishki_render_eff_screensize"):GetInt() - 1)
	local mesh_AddForward = eyeang:Forward()*forward_distance

	local ply_Speed = (LocalPlayer():GetVelocity():Length2DSqr() * 0.00000025)
	local mesh_RebuildLerpSpeed = math.Clamp(ply_Speed, 0.01, 4) * 1.25



	
	mesh_RebuildLerpSpeed = mesh_RebuildLerpSpeed + 0.35 * (stress_level * panics_boobs[GetConVar("kishki_render_eff_panic"):GetInt()])

	local mesh_MaxPos = SOCIOPATHY_PROJECT.LocalVars.GameStarted == false && 2 or 3


	--mesh_MaxPos = mesh_MaxPos + stress_level * 10
	--[[ if ply_Speed > 0.025 then
		mesh_MaxPos = 8
	end --]] 


	for x, x_table in pairs(SOCIOPATHY_PROJECT.Render.ScreenMesh2) do
		for y, mesh_data in pairs(x_table) do
			if CAN_UPD then
				if y > 1 then
					local last_data = SOCIOPATHY_PROJECT.Render.ScreenMesh2[x][y-1]
					mesh_data[3].show_pos.x = last_data[4].show_pos.x 
					mesh_data[3].show_pos.y = last_data[4].show_pos.y	


					mesh_data[6].show_pos.x = last_data[4].show_pos.x 
					mesh_data[6].show_pos.y = last_data[4].show_pos.y	


					mesh_data[2].show_pos.x = last_data[1].show_pos.x 
					mesh_data[2].show_pos.y = last_data[1].show_pos.y	

					mesh_data[5].show_pos.x = mesh_data[2].show_pos.x
					mesh_data[5].show_pos.y = mesh_data[2].show_pos.y
	
				end
				if x > 1 then
					local last_data = SOCIOPATHY_PROJECT.Render.ScreenMesh2[x-1][y]
					mesh_data[1].show_pos.y = last_data[3].show_pos.y 
					mesh_data[1].show_pos.x = last_data[3].show_pos.x 


					mesh_data[2].show_pos.x = last_data[6].show_pos.x 
					mesh_data[2].show_pos.y = last_data[6].show_pos.y 

					mesh_data[5].show_pos.x = last_data[6].show_pos.x 
					mesh_data[5].show_pos.y = last_data[6].show_pos.y 

				end

	
				local tr_tb = mesh_data[4]	

				


				tr_tb.show_pos.x = Lerp(mesh_RebuildLerpSpeed,tr_tb.show_pos.x, math.random(tr_tb.pos.x-mesh_MaxPos,tr_tb.pos.x+mesh_MaxPos))
				tr_tb.show_pos.y = Lerp(mesh_RebuildLerpSpeed,tr_tb.show_pos.y, math.random(tr_tb.pos.y-mesh_MaxPos,tr_tb.pos.y+mesh_MaxPos))

				if x == 1 then
					local tr_tb = mesh_data[1]
					tr_tb.show_pos.x = Lerp(mesh_RebuildLerpSpeed,tr_tb.show_pos.x, math.random(tr_tb.pos.x-mesh_MaxPos,tr_tb.pos.x+mesh_MaxPos))
					tr_tb.show_pos.y = Lerp(mesh_RebuildLerpSpeed,tr_tb.show_pos.y, math.random(tr_tb.pos.y-mesh_MaxPos,tr_tb.pos.y+mesh_MaxPos))
				end


				mesh_data[3].show_pos.x = mesh_data[4].show_pos.x
				mesh_data[3].show_pos.y = mesh_data[4].show_pos.y  
			

			end

			for mesh_Index, mesh_table in pairs(mesh_data) do

				local tr_tb = mesh_table	
				local pos = Vector(tr_tb.show_pos.x, tr_tb.show_pos.y, tr_tb.show_pos.z) - Vector(0,4,-2)
				pos:Rotate(mesh_rotateAng)
					

				mesh.Position( EyePos() + mesh_AddForward + pos + mesh_AddVecOffset ) 
				mesh.TexCoord( 0, tr_tb.u, tr_tb.v ) 
				mesh.AdvanceVertex() 
			end
			
			
		end
	end

		mesh.End() 
	cam.End3D()  


    render.UpdateScreenEffectTexture()

end )