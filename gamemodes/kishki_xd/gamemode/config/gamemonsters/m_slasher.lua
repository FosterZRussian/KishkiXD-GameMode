local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseMonsterTable()

ItemConfig.ItemData.SystemName = "hunter_slasher"

ItemConfig.ItemData.SystemValues.RenderMethods.OnWorldDraw.Render_Material = Material("materials/kishkixd/monsters/hunter_2.png")

ItemConfig.MetaData.ItemIcon = Material("materials/kishkixd/monsters/hunter_2.png")



SOCIOPATHY_PROJECT.GameLogic:RegisterMonster(ItemConfig)