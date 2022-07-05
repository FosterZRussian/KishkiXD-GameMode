local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()

ItemConfig.ItemData.SystemName = "item_visual_paper_1"
ItemConfig.MetaData.ItemIcon = "papers/paper_a_hunter"


ItemConfig.MetaData.ItemName = "Lost note"
ItemConfig.MetaData.ItemDescription = "Contains unknown information"


SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)