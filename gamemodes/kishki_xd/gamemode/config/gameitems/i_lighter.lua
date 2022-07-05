local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_lighter"
ItemConfig.MetaData.ItemIcon = "lighter/icon"

ItemConfig.ItemData.CanBeUsedAsSlotItem = true



ItemConfig.MetaData.ItemName = "Lighter"
ItemConfig.MetaData.ItemDescription = "Convenient and fast lighter.\nReliable light source."


SOCIOPATHY_PROJECT.Sounds.List['Ligther_ChangeStatus'] = {
	path = "objects/ligther.wav",
	volume = 1,
	pitch = 100,
}

ItemConfig.ItemData.SystemValues.LogicTables['ItemLogic'] = {
	_LastDrawCT = 0,
	_LastAnim = 1,
	_MaxAnim = 4,
	_IsEnabled = true,
}


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	item_config.ItemData.SystemValues.LogicTables['ItemLogic']._IsEnabled = !item_config.ItemData.SystemValues.LogicTables['ItemLogic']._IsEnabled
	SOCIOPATHY_PROJECT.Sounds:PlaySound("Ligther_ChangeStatus")
end


ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then return end

	if item_config.ItemData.SystemValues.LogicTables['ItemLogic']._IsEnabled then
		local dlight = DynamicLight( LocalPlayer():EntIndex() )
		if ( dlight ) then
			dlight.pos = LocalPlayer():GetPos()
			dlight.r = 255
			dlight.g = 0
			dlight.b = 0
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 10024
			dlight.DieTime = CurTime() + .1
		end
	end
	--[[ if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy  == nil then return end
	local att_table = item_config.ItemData.SystemValues.LogicTables['EMP']
	local ply = item_config.ItemData.SystemValues.ItemOwner
	local n_pos = ply:EyePos()+ply:EyeAngles():Forward()*40
	local dist = n_pos:Distance(SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy:GetPos())

	local EMP_LEVEL = 0
	-- 

	if dist <= 500*4 then
		if dist >= 400*4 then EMP_LEVEL = 1
		elseif dist >= 300*4 then EMP_LEVEL = 2
		elseif dist >= 200*4 then EMP_LEVEL = 3
		elseif dist >= 100*4 then EMP_LEVEL = 4
		elseif dist >= 0 then EMP_LEVEL = 5
		end
	end


	att_table._EmpLevel = EMP_LEVEL
	if att_table._EmpShow then
		if CurTime() > att_table._EmpCT2 then
			att_table._EmpCT = CurTime() + (1-(att_table._EmpLevel * 0.175))*0.5
			att_table._EmpShow = false
		end
	else
		if CurTime() > att_table._EmpCT then
			att_table._EmpCT2 = CurTime() + (1-(att_table._EmpLevel * 0.175))*0.5
			att_table._EmpShow = true
			if EMP_LEVEL != 0 then
				SOCIOPATHY_PROJECT.Sounds:PlaySound("Items_EMPDetector")
			end
		end
	end--]] 
end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3
	surface.SetDrawColor(Color(255,255,255))



	if att_table._IsEnabled then	


		surface.SetMaterial(Material("kishkixd/objects/lighter/base_secondary.png"))
		surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	
	
		surface.SetMaterial(Material("kishkixd/objects/lighter/base_pr_off.png"))
		surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)

		surface.SetMaterial(Material("kishkixd/objects/lighter/light_".. att_table._LastAnim ..".png"))
		surface.DrawTexturedRectRotated(x,y+20, TexSize,TexSize, 0)
		if CurTime() > att_table._LastDrawCT then
			att_table._LastAnim = att_table._LastAnim + 1
			if att_table._LastAnim > att_table._MaxAnim then
				att_table._LastAnim = 1
			end
			att_table._LastDrawCT = CurTime() + 0.1
		end
	else
		surface.SetMaterial(Material("kishkixd/objects/lighter/base_closed.png"))
		surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	end



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[MOUSE 1]" )
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)