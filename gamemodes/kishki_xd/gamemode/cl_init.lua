
SOCIOPATHY_PROJECT = {}
SOCIOPATHY_PROJECT.GameLogic = {}
SOCIOPATHY_PROJECT.CONFIG = {}



if CLIENT then
	SOCIOPATHY_PROJECT.VGUI = {}
	SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_PRE = {}
	SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_POST = {}
	SOCIOPATHY_PROJECT.LocalVars = {
		GameStarted = false,
		TaskList = {},
		Items = {},
		LocalPlayerOnGame = {},
	}
end



include("scripts/client/cl_sounds.lua")
include("config/gamemodes.lua")


include("config/players.lua")

include("config/gameitems.lua")
include("config/gamemonsters.lua")





include("scripts/client/cl_gamelogic.lua")

include("scripts/client/cl_quests.lua")

include("scripts/client/cl_render.lua")

include("scripts/client/cl_vgui.lua")


hook.Add("PostDraw2DSkyBox", "SOCIOPATHY_PROJECT_PostDraw2DSkyBox", function()

	local size = 16
    local color2 = Color(0,0,0,255)

    local mat = Material( "color" )
    cam.Start3D(Vector(0, 0, 0), EyeAngles())
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(1, 0, 0) * size, Vector(-1, 0, 0), size * 2, size * 2, color2, 180)
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(0, -1, 0) * size, Vector(0, 1, 0), size * 2, size * 2, color2, 180)
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(-1, 0, 0) * size, Vector(1, 0, 0), size * 2, size * 2, color2, 180)
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(0, 1, 0) * size, Vector(0, -1, 0), size * 2, size * 2, color2, 180)
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(0, 0, 1) * size, Vector(0, 0, -1), size * 2, size * 2, color2, 270)
    render.SetMaterial(mat)
    render.DrawQuadEasy(Vector(0, 0, -1) * size, Vector(0, 0, 1), size * 2, size * 2, color2, 90)
    cam.End3D()
end)

hook.Add( "PlayerButtonDown", "SOCIOPATHY_PROJECT_PlayerButtonDown", function( ply, button )

	if CLIENT then
		if ( IsFirstTimePredicted() ) then 
			

			local have_panels = false
			for k,v in pairs(SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_PRE) do
				have_panels = true
				v:OnKeyCodePressed(button)
			end
			for k,v in pairs(SOCIOPATHY_PROJECT.VGUI.VGUI_DRAWS_PANELS_POST) do
				have_panels = true
				v:OnKeyCodePressed(button)
			end
			
			if !have_panels  then
				--print( ply:Nick() .. " pressed " .. input.GetKeyName( button ) ) 
			end
		end
	else
		if ply.InGame then
			--print( ply:Nick() .. " pressed " .. button )
		end
	end
end)
