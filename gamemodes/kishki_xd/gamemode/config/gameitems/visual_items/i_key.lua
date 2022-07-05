local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_key"
ItemConfig.MetaData.ItemIcon = "key"

ItemConfig.MetaData.ItemName = "Unknown key"
ItemConfig.MetaData.ItemDescription = "ЧЕТЫРЕ\nЯБЛОКО\nДВА"

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)