local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_oilcan"
ItemConfig.MetaData.ItemIcon = "oilcan"

ItemConfig.MetaData.ItemName = "Oil Can"
ItemConfig.MetaData.ItemDescription = "Contains oil"


SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)