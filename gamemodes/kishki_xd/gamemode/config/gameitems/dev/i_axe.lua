local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_axe"
ItemConfig.MetaData.ItemIcon = "axe"


ItemConfig.ItemData.SystemValues.LogicTables['Attacking'] = {
	_AttackStatus = 0,
	_AttackStart = 0,
	_AttackRotating = -5,
	_AttackStartCT = 0
}


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)

	local att_table = item_config.ItemData.SystemValues.LogicTables['Attacking']
	-- print("attack")
	if att_table._AttackStatus == 0 && CurTime() > att_table._AttackStartCT then
		att_table._AttackStatus = 1
		att_table._AttackStart = CurTime() + .5	
	end
end

ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	local att_table = item_config.ItemData.SystemValues.LogicTables['Attacking']
	if att_table._AttackStatus == 1 then
		if CurTime() > att_table._AttackStart then
			att_table._AttackStatus = 0
			att_table._AttackStartCT = CurTime() + 0.5
		else
			att_table._AttackRotating = math.Approach(att_table._AttackRotating, 75, 8)
		end
	else
		att_table._AttackRotating = math.Approach(att_table._AttackRotating, -5, 10)
	end
end


function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['Attacking']

	local TexSize = H*1.2
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/axe.png"))

	surface.DrawTexturedRectRotated(W-TexSize/2,item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3,TexSize,TexSize, att_table._AttackRotating)
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)