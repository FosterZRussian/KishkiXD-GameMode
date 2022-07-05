local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_radio"
ItemConfig.MetaData.ItemIcon = "radio"


 
ItemConfig.ItemData.CanBeUsedAsSlotItem = true



ItemConfig.MetaData.ItemName = "Portable Radio"
ItemConfig.MetaData.ItemDescription = "Picks up radio waves."


SOCIOPATHY_PROJECT.Sounds.List['368115__nucleartape__60hz-glitch'] = {
	path = "noise/2368115__nucleartape__60hz-glitch.mp3",
	volume = .75,
	pitch = 100,
	duration = 25,
}

function ItemConfig.ItemData.SystemFunctions:OnSwitchToHand(item_config, is_take)
	if SERVER then return end
	if is_take then
		SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound("368115__nucleartape__60hz-glitch")
	else
		SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("368115__nucleartape__60hz-glitch")	
	end
end

function ItemConfig.ItemData.SystemFunctions:OnDelete(item_config, is_take)
	if SERVER then return end
	SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound("368115__nucleartape__60hz-glitch")	
end


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
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
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.535
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/radio.png"))
	surface.DrawTexturedRectRotated(x,y, TexSize*0.75*1.2,TexSize*1.2, 0)
	

	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 0, 0, 0 )
	surface.SetTextPos( x - TexSize * 0.08, y + TexSize*0.275 ) 

	local min_enemy = LocalPlayer():GetNWEntity("Game_MonsterAttacker", nil)
	if IsValid(min_enemy) then
		surface.DrawText( "RUN !" )
	else
		surface.DrawText( "BE SAFE" )
	end
	
		
	



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H) 
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)