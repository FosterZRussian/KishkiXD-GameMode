local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_retroxc"
ItemConfig.MetaData.ItemIcon = "radio_2"


 

ItemConfig.MetaData.ItemName = "Music station"
ItemConfig.MetaData.ItemDescription = "Helps reduce stress."


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



local snds = {
	"GUITAR2","PIANO6","PIANO7","PIANO9","PIANO10","PIANO14","PIANO16","PIANO20"
}
SOCIOPATHY_PROJECT.Sounds.List['GUITAR2'] = { path = "ITCHPIANOVOL2/GUITAR2.mp3", duration = 38, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO6'] = { path = "ITCHPIANOVOL2/PIANO6.mp3", duration = 21, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO7'] = { path = "ITCHPIANOVOL2/PIANO7.mp3", duration = 23, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO9'] = { path = "ITCHPIANOVOL2/PIANO9.mp3", duration = 22, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO10'] = { path = "ITCHPIANOVOL2/PIANO10.mp3", duration = 22, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO14'] = { path = "ITCHPIANOVOL2/PIANO14.mp3", duration = 33, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO16'] = { path = "ITCHPIANOVOL2/PIANO16.mp3", duration = 33, }
SOCIOPATHY_PROJECT.Sounds.List['PIANO20'] = { path = "ITCHPIANOVOL2/PIANO20.mp3", duration = 32, }


local _last_snd = nil

function ItemConfig.ItemData.SystemFunctions:OnSwitchToHand(item_config, is_take)
	if SERVER then return end

	


	if is_take then
		_last_snd = table.Random(snds)
		SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound(_last_snd)
	else
		SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(_last_snd)	
	end
end

function ItemConfig.ItemData.SystemFunctions:OnDelete(item_config, is_take)
	if SERVER then return end
	SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(_last_snd)	
end

ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	
end


ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then 
		local ply = item_config.ItemData.SystemValues.ItemOwner
		local sterss = ply:GetNWFloat("Game_Stress", 100)
		if sterss < 100 then
			ply:SetNWFloat("Game_Stress", math.Approach(sterss, 100, 0.2))
		end

		for k,v in pairs(ents.FindByClass("npc_hunter")) do
			
			if v.ClassSetuped then
				v.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnEnemyUseNoiseItem", ply, v.ClassConfig)	
			end	
		end
		
	end

end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/radio_2.png"))
	surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	

		
	



end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[BE CALM]" ) 
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)