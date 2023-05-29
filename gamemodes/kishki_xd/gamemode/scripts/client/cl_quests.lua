AddCSLuaFile()
SOCIOPATHY_PROJECT.Quests = {}


SOCIOPATHY_PROJECT.Quests.Tasks = {}
SOCIOPATHY_PROJECT.Quests.Tasks[1] = {}
SOCIOPATHY_PROJECT.Quests.Tasks[2] = {}

SOCIOPATHY_PROJECT.Quests.Tasks[1][1] = {
	title = "Find [Note]",
	count = 7,
	item_type = "item_visual_paper_1",
}
SOCIOPATHY_PROJECT.Quests.Tasks[1][2] = {
	title = "Find [Note]",
	count = 7,
	item_type = "item_visual_paper_2",
}
SOCIOPATHY_PROJECT.Quests.Tasks[1][3] = {
	title = "Find [Note]",
	count = 7,
	item_type = "item_visual_paper_3",
}
SOCIOPATHY_PROJECT.Quests.Tasks[1][4] = {
	title = "Find [Note]",
	count = 7,
	item_type = "item_visual_paper_4",
}

SOCIOPATHY_PROJECT.Quests.Tasks[1][5] = {
	title = "Find [Note]",
	count = 7,
	item_type = "item_visual_paper_4",
}
SOCIOPATHY_PROJECT.Quests.Tasks[1][6] = {
	title = "Find [Keys]",
	count = 7,
	item_type = "item_key",
}

SOCIOPATHY_PROJECT.Quests.Tasks[2][1] = {
	title = "Find [Oil Can]",
	count = 2,
	item_type = "item_oilcan",
}
SOCIOPATHY_PROJECT.Quests.Tasks[2][2] = {
	title = "Find [Tape]",
	count = 2,
	item_type = "item_visual_tape",
}

SOCIOPATHY_PROJECT.Quests.Tasks[2][3] = {
	title = "Find [Book]",
	count = 2,
	item_type = "item_visual_book_1",
}

SOCIOPATHY_PROJECT.Quests.Tasks[2][4] = {
	title = "Find [Sawn Brain]",
	count = 4,
	item_type = "item_visual_brain_1",	
}


function SOCIOPATHY_PROJECT.Quests:GenerateNavAreaForItems()
	local points = SOCIOPATHY_PROJECT.GameLogic.ItemsNavAreas
	for k,v in pairs(navmesh.GetAllNavAreas()) do
		if v:IsUnderwater() then continue end
		local min_dist = 9999
		local min_point = 0
		local pos = v:GetCenter()
		for k2, v2 in pairs(points) do
			local dist = v2:GetCenter():Distance(pos)
			if dist < min_dist then
				min_dist = dist
				min_point = k2
			end
		end
		if min_dist > 700 then
			points[#points+1] = v
		end
	end
end


function SOCIOPATHY_PROJECT.Quests:GenerateUsefulItems(white_list)
	
	local points = SOCIOPATHY_PROJECT.GameLogic.ItemsNavAreas
	
	for k,v in pairs(SOCIOPATHY_PROJECT.GameLogic.GameItems) do
		if white_list[v.ItemData.SystemName] != true then continue end
		if !v.ItemData.CanBeUsedAsSlotItem then continue end
		local item_data = ents.Create("item_dropped")
		item_data:SetNWString("ItemID", k)			
		local random_pos, random_key = table.Random(points)
		if random_pos == nil then
			for k,v in pairs(navmesh.GetAllNavAreas()) do
				if v:IsUnderwater() then continue end
				local min_dist = 9999
				local min_point = 0
				local pos = v:GetCenter()
				for k2, v2 in pairs(points) do
					local dist = v2:GetCenter():Distance(pos)
					if dist < min_dist then
						min_dist = dist
						min_point = k2
					end
				end
				if min_dist > 700 then
					points[#points+1] = v
				end
			end
			random_pos, random_key = table.Random(points)
		end
		item_data:SetPos(random_pos:GetRandomPoint()+Vector(0,0,40))
		points[random_key] = nil
		item_data:Spawn()
	end
end

function SOCIOPATHY_PROJECT.Quests:GenerateTasks()
	
	local points = SOCIOPATHY_PROJECT.GameLogic.ItemsNavAreas
	SOCIOPATHY_PROJECT.GameLogic.TaskList = {}
	SOCIOPATHY_PROJECT.GameLogic.TaskList_ItemsCallback = {}

	
	game.GetWorld():SetNWInt("Game_Quest_Count", #SOCIOPATHY_PROJECT.Quests.Tasks) 
	for k,v in pairs(SOCIOPATHY_PROJECT.Quests.Tasks) do
		local quest_data, sub_quest_id = table.Random(v)
		SOCIOPATHY_PROJECT.GameLogic.TaskList[k] = quest_data
		SOCIOPATHY_PROJECT.GameLogic.TaskList[k].now_counter = 0
		local quest_data = SOCIOPATHY_PROJECT.GameLogic.TaskList[k]
		game.GetWorld():SetNWInt("Game_Quest_ID_" .. k , sub_quest_id) 
		game.GetWorld():SetNWInt("Game_Quest_Progress_" .. k , 0 )
		game.GetWorld():SetNWInt("Game_Quest_IsCompleted_" .. k , false )
		for i = 1, quest_data.count do
			local item_data = ents.Create("item_dropped")
			item_data:SetNWString("ItemID", quest_data.item_type)				
			local random_pos, random_key = table.Random(points)
			if random_pos == nil then
				for k,v in pairs(navmesh.GetAllNavAreas()) do
					if v:IsUnderwater() then continue end
					local min_dist = 9999
					local min_point = 0
					local pos = v:GetCenter()
					for k2, v2 in pairs(points) do
						local dist = v2:GetCenter():Distance(pos)
						if dist < min_dist then
							min_dist = dist
							min_point = k2
						end
					end
					if min_dist > 700 then
						points[#points+1] = v
					end
				end
			end
			random_pos, random_key = table.Random(points)
			item_data:SetPos(random_pos:GetRandomPoint()+Vector(0,0,40))
			points[random_key] = nil
			item_data:Spawn()
			item_data.IsQuestItem = true
		end
		SOCIOPATHY_PROJECT.GameLogic.TaskList_ItemsCallback[quest_data.item_type] = {
			quest_id = k,
			sub_quest_id = sub_quest_id
		}
	end 
end

function SOCIOPATHY_PROJECT.Quests:OnItemTaked(item_id, is_removed)
	if CLIENT then return end
	local cb_task_table = SOCIOPATHY_PROJECT.GameLogic.TaskList_ItemsCallback[item_id]
	if cb_task_table != nil then
		SOCIOPATHY_PROJECT.GameLogic.TaskList[cb_task_table.quest_id].now_counter = SOCIOPATHY_PROJECT.GameLogic.TaskList[cb_task_table.quest_id].now_counter + (is_removed && -1 or 1)

		game.GetWorld():SetNWInt("Game_Quest_Progress_" .. cb_task_table.quest_id , SOCIOPATHY_PROJECT.GameLogic.TaskList[cb_task_table.quest_id].now_counter )
		game.GetWorld():SetNWBool("Game_Quest_IsCompleted_" .. cb_task_table.quest_id, SOCIOPATHY_PROJECT.GameLogic.TaskList[cb_task_table.quest_id].now_counter == SOCIOPATHY_PROJECT.Quests.Tasks[cb_task_table.quest_id][cb_task_table.sub_quest_id].count)
	end


	if is_removed != true then
		local completed_quests = 0

		local quests = game.GetWorld():GetNWInt("Game_Quest_Count", 0)
		if quests != 0 then
			for k = 1, quests do
				local sub_quest_id = game.GetWorld():GetNWInt("Game_Quest_ID_" .. k , 1) 
				local quest_data = SOCIOPATHY_PROJECT.Quests.Tasks[k][sub_quest_id]
				if game.GetWorld():GetNWInt("Game_Quest_Progress_" .. k , 0) == quest_data.count then
					completed_quests = completed_quests + 1
				end
			end
		end
		if completed_quests == quests then
			SOCIOPATHY_PROJECT.GameLogic:GameModeEnd()
		end
	end
	--[[ for k,v in pairs(SOCIOPATHY_PROJECT.Quests.Tasks) do
		SOCIOPATHY_PROJECT.GameLogic.TaskList[k] = table.Random(v)
		SOCIOPATHY_PROJECT.GameLogic.TaskList[k].now_counter = 0
	end--]] 
end