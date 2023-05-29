local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_visual_brain_1"
ItemConfig.MetaData.ItemIcon = "brain_cut"

ItemConfig.MetaData.ItemName = "Sawn brain"
ItemConfig.MetaData.ItemDescription = "???"

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)