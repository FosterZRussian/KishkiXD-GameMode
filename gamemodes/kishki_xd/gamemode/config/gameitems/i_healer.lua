local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_healer"
ItemConfig.MetaData.ItemIcon = "med_heal"



ItemConfig.MetaData.ItemName = "First Medical Kit"
ItemConfig.MetaData.ItemDescription = "Allows you to heal\nyourself completely."
 
ItemConfig.ItemData.CanBeUsedAsSlotItem = true





function ItemConfig.ItemData.SystemFunctions:OnSwitchToHand(item_config, is_take)
	if SERVER then return end

end

function ItemConfig.ItemData.SystemFunctions:OnDelete(item_config, is_take)
	if SERVER then return end
end

ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	if SERVER then
		ply = item_config.ItemData.SystemValues.ItemOwner
		ply:SetHealth(100)
		SOCIOPATHY_PROJECT.GameLogic:TakeItemFromPlayer(ply, item_config.ItemData.SystemName)
	end
end


ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then 
		--[[ local ply = item_config.ItemData.SystemValues.ItemOwner
		local sterss = ply:GetNWFloat("Game_Stress", 100)
		if sterss < 100 then
			ply:SetNWFloat("Game_Stress", math.Approach(sterss, 100, 0.2))
		end

		for k,v in pairs(ents.FindByClass("npc_hunter")) do
			
			if v.ClassSetuped then
				v.ClassConfig.SystemMethods.CallMethod("RenderMethods" , "OnEnemyUseNoiseItem", ply, v.ClassConfig)	
			end	
		end--]] 
		
	end

end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/med_heal.png"))
	surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	

		
	



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[MOUSE 1]" ) 

end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)