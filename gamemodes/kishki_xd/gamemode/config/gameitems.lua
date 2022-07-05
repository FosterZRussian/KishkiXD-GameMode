AddCSLuaFile()
SOCIOPATHY_PROJECT.GameLogic.GameItems = {}

local defaultItemData = {
	ItemData = {
		SystemName = "",
		CanBeUsedAsSlotItem = false,
		UseThinkFunctionForDroppedItem = false, 
		SystemValues = {
			IsInitialized = false,
			ItemOwner = (CLIENT && LocalPlayer()) or nil,
			InventoryID = 0,
			KeyFunctions = {
				[KEY_G] = function(item_config)
					if SERVER then
						SOCIOPATHY_PROJECT.GameLogic:DropItem(item_config.ItemData.SystemValues.ItemOwner, item_config.ItemData.SystemName, item_config)
					end
				end,
			},
			ThinkFunctions = {
				['Moving'] = function(self,item_config)
					if SERVER then return end
					local ply = item_config.ItemData.SystemValues.ItemOwner
					local UserSpeed = ply:GetVelocity():Length2DSqr() * 0.000085
					local movetb = item_config.ItemData.SystemValues.LogicTables.VisualMoving 
					local addspd = math.Clamp(movetb._MoveSpeed * UserSpeed, 0, 1)
					if ply:KeyDown(IN_DUCK) then
						addspd = addspd / 4
					end
					if addspd <= 0.1 then
						movetb._LastRenderYPos = math.Approach( movetb._LastRenderYPos, 0, 0.5 )
					else
						if movetb._NowStatus == 1 then
							movetb._LastRenderYPos = movetb._LastRenderYPos + addspd
							if movetb._LastRenderYPos > movetb._MaxLimit then
								movetb._NowStatus = 0
							end
						else
							movetb._LastRenderYPos = movetb._LastRenderYPos - addspd
							if movetb._LastRenderYPos < movetb._MinLimit then
								movetb._NowStatus = 1
							end
						end
					end
					--self.VisualMoving._LastRenderYPos
				end,
			},
			LogicTables = {
				['VisualMoving'] = {
					_LastRenderYPos = 0,
					_MaxLimit = 8,
					_MinLimit = -1,
					_NowStatus = 1, -- 0 down -- 1 up
					_MoveSpeed = 0.2,
				},
			},
		},
		SystemFunctions = {
			GetItemOwner = function(self, item_config)
				return item_config.ItemData.SystemValues.ItemOwner
			end,
			OnSwitchToHand = function(self, item_config, is_take) 
			end,
			OnInit = function(self, item_config) -- on first 
			end,
			OnDelete = function(self, item_config)
			end,
			ScreenDraw_First = function(self, item_config, w,h)
			end,
			ScreenDraw_UI = function(self, item_config, w,h)
			end,
			ScreenDraw_Third = function(self, item_config, w,h)
			end,
			OnKeyEnter = function(self, item_config, key)
				local func = item_config.ItemData.SystemValues.KeyFunctions[key]
				if func != nil then
					func(item_config)
				end

			end,
			OnThink = function(self, item_config)
				for k,v in pairs(item_config.ItemData.SystemValues.ThinkFunctions) do
					v(item_config.ItemData.SystemValues.ThinkFunctions, item_config)
					--item_config.ItemData.SystemValues.ThinkFunctions:[k]()
					--print(v)
					--v(item_table)
				end
			end,
		},
	},
	MetaData = {
		ItemName = "ITEMNAME",
		ItemDescription = "ITEMDESC",
		ItemIcon = "ITEMICON",
	},
}

function SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
	return table.Copy(defaultItemData)
end

local is_cleaned = false

function SOCIOPATHY_PROJECT.GameLogic:RegisterItem(data)
	if CLIENT && is_cleaned == false then
		if LocalPlayer().InventoryItems != nil then
			LocalPlayer().InventoryItems.ItemsTables = {}
		end
		is_cleaned = true
	end
	SOCIOPATHY_PROJECT.GameLogic.GameItems[data.ItemData.SystemName] = {}
	for k,v in pairs(defaultItemData) do
		for k2, v2 in pairs(v) do
			data[k][k2] = data[k][k2] or v2
		end
	end
	SOCIOPATHY_PROJECT.GameLogic.GameItems[data.ItemData.SystemName] = data
end
function SOCIOPATHY_PROJECT.GameLogic:IncludeItem(item_file)
	local path = "gameitems/" .. item_file .. ".lua"
	AddCSLuaFile(path)
	include(path)
end
-- SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_axe")

SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_emp")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_lighter")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_gasmask")

SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_oilcan")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_tape_1")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_paper_1")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_paper_2")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_paper_3")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_paper_4")

SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_book_1")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("visual_items/i_key")

SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_camera")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_retroxc")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_healer")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_minihealer")
SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_radio")
--SOCIOPATHY_PROJECT.GameLogic:IncludeItem("i_shotgun")



--SOCIOPATHY_PROJECT.GameLogic.GameItems[]