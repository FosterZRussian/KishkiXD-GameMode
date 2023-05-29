local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_camera"
ItemConfig.MetaData.ItemIcon = "camera"

ItemConfig.MetaData.ItemName = "Video Camera"
ItemConfig.MetaData.ItemDescription = "Allows you to capture\nbeautiful landscapes.\nThere is a motion detector."

ItemConfig.ItemData.CanBeUsedAsSlotItem = true

ItemConfig.ItemData.SystemValues.LogicTables['Camera'] = {
	_Zoom = 0,
	_EmpShow = false,
	_CT = 0,
	RT_Cleared = false
}

SOCIOPATHY_PROJECT.Sounds.List['CamZoom'] = {
	path = "objects/cam.wav",
	volume = 1,
	pitch = 100,
	duration = .2,
}
ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	if SERVER then return end
	
end
 
ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then return end

	local att_table = item_config.ItemData.SystemValues.LogicTables['Camera']
	


	local play_snd = false
	if input.IsMouseDown(MOUSE_LEFT) then
		
		att_table._Zoom = att_table._Zoom + 0.01
		play_snd = true
	end
	if input.IsMouseDown(MOUSE_RIGHT) then
		att_table._Zoom = att_table._Zoom - 0.01
		play_snd = true
	end


	att_table._Zoom = math.Clamp(att_table._Zoom, 0, 0.46)

	if att_table._Zoom <= 0.01 or att_table._Zoom >= 0.46 then
		play_snd = false
	end
	if play_snd then
		SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("CamZoom")
	else
		SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("CamZoom")
	end
end



function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)
	local att_table = item_config.ItemData.SystemValues.LogicTables['Camera']

	local TexSize = H*2.5
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/camera.png"))
	local x,y = (W-TexSize/4), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.25
	surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)


	surface.SetDrawColor(Color(255,255,255))
	local interface_min_x = W-TexSize/1.675
	local interface_min_y = y-H/50
	local interface_size_x = H/1.75
	local interface_size_y = H/3.5



	
--[[ 
	surface.DrawRect(interface_min_x, interface_min_y,interface_size_x , 4)

	surface.DrawRect(interface_min_x, interface_min_y + interface_size_y - 4,interface_size_x , 4)--]] 

	local imagebost = att_table._Zoom



--	cam.Start3D2D(EyePos(), EyeAngles(), 1)
--		for k,v in pairs(ents.FindByClass("npc_hunter")) do
--			if v.ClassSetuped then
--				v.ClassConfig.SystemMethods.CallMethod("RenderMethods" , "OnWorldDrawInCamera", nil, v.ClassConfig)
--			end
--		end
--	cam.End3D2D()

	render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_BEFOREUI"])

	if att_table.RT_Cleared == false then
		render.Clear(0,0,0,0,true,true)
		att_table.RT_Cleared = true
	end

	cam.Start({
		x = 0,
		y = 0,
		w = W,
		h = H,
		type = "3D",
		origin = EyePos(),
		angles = EyeAngles(),
	})

		for k,v in pairs(ents.FindByClass("npc_hunter")) do
			if v.ClassSetuped then
				v.ClassConfig.SystemMethods.CallMethod("RenderMethods" , "OnWorldDrawInCamera", nil, v.ClassConfig)
			end 
		end

	cam.End3D() 
	



	
	cam.Start2D()

		if CurTime() > att_table._CT then
			for k,v in pairs(ents.FindByClass("npc_hunter")) do


				local screen_pos = (v:GetPos() + v:OBBCenter()) :ToScreen()
				if !screen_pos.visible then continue end
				surface.SetDrawColor(255,255,255,255)
				local start_pos = screen_pos.x * (1024/W)
				local end_pos = screen_pos.y * (1024/H)	
				local size = 80000 / LocalPlayer():GetPos():Distance(v:GetPos())
				local size2 = size/2
				surface.DrawRect(start_pos-size2, end_pos-size2,size,1)
				surface.DrawRect(start_pos-size2, end_pos+size2,size,1)
				surface.DrawRect(start_pos-size2, end_pos-size2,1,size)
				surface.DrawRect(start_pos+size2, end_pos-size2,1,size)
			end
			if CurTime() - att_table._CT > .5 then
				att_table._CT = CurTime() + .5
			end
		end
	cam.End2D()
	render.PopRenderTarget()	


  	surface.SetDrawColor(Color(255,255,255, 255))
	surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["MAIN_BEFOREUI"])
	surface.DrawTexturedRectUV(interface_min_x, interface_min_y,interface_size_x , interface_size_y,imagebost,imagebost,1-imagebost,1-imagebost)  

 	
	surface.SetDrawColor(Color(255,255,255, 1))
	surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["RED_VHS"])
	surface.DrawTexturedRectUV(interface_min_x, interface_min_y,interface_size_x  , interface_size_y,imagebost,imagebost,1-imagebost,1-imagebost) 
  
 
	surface.SetDrawColor(Color(255,255,255, 1))
	surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["GREEN_VHS"])

	surface.DrawTexturedRectUV(interface_min_x, interface_min_y,interface_size_x * 0.3, interface_size_y,imagebost,imagebost,imagebost+((1-imagebost)-imagebost)*0.3,1-imagebost) 


	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont_2" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( interface_min_x, interface_min_y ) 
	surface.DrawText( "x" .. math.Round(imagebost, 2)*2 )

	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 0, 0 )
	surface.SetTextPos( interface_min_x, interface_min_y+80 ) 

	surface.DrawText( "•REC" )


	--[[ if att_table._EmpLevel != 0 && att_table._EmpShow then
		surface.SetMaterial(Material("kishkixd/objects/emp_detector/level_"..att_table._EmpLevel..".png"))
		surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	end--]] 
end



function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[MOUSE 1/2]" ) 
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)