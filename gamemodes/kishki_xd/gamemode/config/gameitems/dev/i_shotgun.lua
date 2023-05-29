local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_shotgun"
ItemConfig.MetaData.ItemIcon = "shotgun"


 
ItemConfig.ItemData.CanBeUsedAsSlotItem = true




-- 544675__claiber7901__shotgun-03
function ItemConfig.ItemData.SystemFunctions:OnSwitchToHand(item_config, is_take)
	if SERVER then return end




	--local tr = util.TraceEntity({})

end

function ItemConfig.ItemData.SystemFunctions:OnDelete(item_config, is_take)
	if SERVER then return end
end


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	local ply = item_config.ItemData.SystemValues.ItemOwner


--	ply:EmitSound("fosterz/kishkixd/damage/544675__claiber7901__shotgun-03.mp3", 100,100)

end

ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then 
	end

end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.175
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/shotgun.png"))
	surface.DrawTexturedRectRotated(x,y, TexSize*0.75*1.2,TexSize*1.2, 0)
	
		
	



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[MOUSE 1]" ) 

	surface.SetDrawColor(Color(255,0,0,255))
	surface.DrawRect(W/2 - 8 ,H/2 - 8, 16,8)
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)