local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_gasmask"
ItemConfig.MetaData.ItemIcon = "gasmask/ui"



ItemConfig.MetaData.ItemName = "Gas Mask ГП-5"
ItemConfig.MetaData.ItemDescription = "Allows you to save\nstamina and stress"
 
ItemConfig.ItemData.CanBeUsedAsSlotItem = true
SOCIOPATHY_PROJECT.Sounds.List['GasMask_Equipped'] = {
	path = "objects/2gasmask.wav",
	volume = .4,
	pitch = 100,
	duration = 15,
}
 
ItemConfig.ItemData.SystemValues.LogicTables['ItemLogic'] = {
	_LastDrawCT = 0,
	_LastAnim = 1,
	_MaxAnim = 4,
	_IsEnabled = true,
}


function ItemConfig.ItemData.SystemFunctions:OnSwitchToHand(item_config, is_take)
	if SERVER then return end
	if is_take then
		SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("GasMask_Equipped")	
		SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("GasMask_Equipped")
	else
		SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("GasMask_Equipped")	
	end
end

function ItemConfig.ItemData.SystemFunctions:OnDelete(item_config, is_take)
	if SERVER then return end
	SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("GasMask_Equipped")	
end

ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	
end


ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then 
		local ply = item_config.ItemData.SystemValues.ItemOwner
		local stamina = ply:GetNWFloat("Game_Stamina", 100)
		if stamina < 100 then
			ply:SetNWFloat("Game_Stamina", math.Approach(stamina, 100, 0.35))
		end
		local sterss = ply:GetNWFloat("Game_Stress", 100)
		if sterss < 100 then
			ply:SetNWFloat("Game_Stress", math.Approach(sterss, 100, 0.1))
		end
	end

end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x = item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025)
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/gasmask/ui_mask.png"))
	surface.DrawTexturedRect(-50,-50, W+100,H+100+x)

		
	



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[DONT RUN]" ) 
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)