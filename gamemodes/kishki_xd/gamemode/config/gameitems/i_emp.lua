local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_emp"
ItemConfig.MetaData.ItemIcon = "emp_detector/base"

ItemConfig.MetaData.ItemName = "EMP Detector"
ItemConfig.MetaData.ItemDescription = "Electromagnetic radiation\ndetector."

ItemConfig.ItemData.CanBeUsedAsSlotItem = true

ItemConfig.ItemData.SystemValues.LogicTables['EMP'] = {
	_EmpLevel = 1,
	_EmpCT = 0,
	_EmpCT2 = 0,
	_EmpShow = false,
}


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)

end
 
ItemConfig.ItemData.SystemValues.ThinkFunctions["ThinkAttack"] = function(self, item_config)
	if SERVER then return end
	if SOCIOPATHY_PROJECT.LocalVars.LocalPlayerOnGame.MinEnemy  == nil then return end
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
	end
end
 

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['EMP']

	local TexSize = H*1
	surface.SetDrawColor(Color(255,255,255))
	surface.SetMaterial(Material("kishkixd/objects/emp_detector/base.png"))
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3
	surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)

	if att_table._EmpLevel != 0 && att_table._EmpShow then
		surface.SetMaterial(Material("kishkixd/objects/emp_detector/level_"..att_table._EmpLevel..".png"))
		surface.DrawTexturedRectRotated(x,y, TexSize,TexSize, 0)
	end
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)