local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_visual_book_1"
ItemConfig.MetaData.ItemIcon = "book_obj12"

ItemConfig.MetaData.ItemName = "Lost book"
ItemConfig.MetaData.ItemDescription = "Contains unknown information"

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)