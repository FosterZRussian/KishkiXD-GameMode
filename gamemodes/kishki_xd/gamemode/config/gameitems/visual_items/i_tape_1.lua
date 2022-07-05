local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_visual_tape"
ItemConfig.MetaData.ItemIcon = "tape"

ItemConfig.MetaData.ItemName = "Lost tape"
ItemConfig.MetaData.ItemDescription = "Contains unknown information"

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)