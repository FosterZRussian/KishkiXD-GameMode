AddCSLuaFile()
if SERVER then return end


function SOCIOPATHY_PROJECT.VGUI:CloseMenu()
	hook.Call("VGUI_CloseMenu")
end


local function GetBased_W()
	return ScrW()/1920
end


local function GetBased_H()
	return ScrH()/1080
end
local function f_SetPos(panel, x,y, ignore_scaling)
	if ignore_scaling != true then
		panel:SetPos(x*GetBased_W(),y*GetBased_H())
	else
		panel:SetPos(x,y)
	end
end



local function f_SetSize(panel, x,y, ignore_scaling)
	if ignore_scaling != true then
		panel:SetSize(x*GetBased_W(),y*GetBased_H())
	else
		panel:SetSize(x,y)
	end
end

local function f_AlignRight(panel,value, ignore_scaling)
	if ignore_scaling != true then
		panel:AlignRight(value*GetBased_W())
	else
		panel:AlignRight(value)
	end
end
local function f_AlignLeft(panel,value, ignore_scaling)
	if ignore_scaling != true then
		panel:AlignLeft(value*GetBased_W())
	else
		panel:AlignLeft(value)
	end
end
local function f_AlignTop(panel,value, ignore_scaling)
	if ignore_scaling != true then
		panel:AlignTop(value*GetBased_H())
	else
		panel:AlignTop(value)
	end
end
local function f_AlignBottom(panel,value, ignore_scaling)
	if ignore_scaling != true then
		panel:AlignBottom(value*GetBased_H())
	else
		panel:AlignBottom(value)
	end
end

local function ReadrRecords(data)
	if data != nil then
		data = util.JSONToTable(data)
	else
		data = {}
	end
	data.survive_rec = data.survive_rec or nil
	data.classic_rec = data.classic_rec or nil
	return data
end

function RebuildFonts() 
	surface.CreateFont( "SOCIOPATHY_PROJECT_HUDFont", {
		font = "Arial", 
		extended = false,
		size = 50*GetBased_H(),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true,
	} )
	surface.CreateFont( "SOCIOPATHY_PROJECT_HUDFont_2", {
		font = "Arial", 
		extended = false,
		size = 80*GetBased_H(),
		weight = 100,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true,
	} )
end



local END_TITLE = {}
table.insert(END_TITLE, "I didn't make it...")
table.insert(END_TITLE, "It's over for me...")
table.insert(END_TITLE, "I failed...")
table.insert(END_TITLE, "This is it...")
table.insert(END_TITLE, "I died...")
table.insert(END_TITLE, "This is the end...")
table.insert(END_TITLE, "I can't believe it's over...")
table.insert(END_TITLE, "It's too late for me...")
table.insert(END_TITLE, "I won't live to fight another day...")
table.insert(END_TITLE, "I'm lost...")
table.insert(END_TITLE, "I was so close...")
table.insert(END_TITLE, "It's all over...")
table.insert(END_TITLE, "I regret everything...")
table.insert(END_TITLE, "This was my fate...")
table.insert(END_TITLE, "I knew this was coming...")
table.insert(END_TITLE, "The darkness has overcome me...")
table.insert(END_TITLE, "This is how it was meant to end...")
table.insert(END_TITLE, "I'm sorry...")
table.insert(END_TITLE, "It's done...")
table.insert(END_TITLE, "The fear got the better of me...")
table.insert(END_TITLE, "I should have been more careful...")
table.insert(END_TITLE, "Death comes for us all...")
table.insert(END_TITLE, "I couldn't save myself...")
table.insert(END_TITLE, "I was too weak...")
table.insert(END_TITLE, "The horror was too much to bear...")
table.insert(END_TITLE, "It's a slow death...")
table.insert(END_TITLE, "I'll never see the light of day again...")
table.insert(END_TITLE, "It's the end of the road...")
table.insert(END_TITLE, "I thought I had a chance...")
table.insert(END_TITLE, "It's time to say goodbye...")
table.insert(END_TITLE, "I couldn't outrun it...")
table.insert(END_TITLE, "I should have turned back...")
table.insert(END_TITLE, "The darkness consumed me...")
table.insert(END_TITLE, "I'm sorry I failed...")
table.insert(END_TITLE, "It's over and I'm not coming back...")
table.insert(END_TITLE, "I'm slipping away...")
table.insert(END_TITLE, "The game is over and I lost...")
table.insert(END_TITLE, "I can feel it slipping away...")
table.insert(END_TITLE, "I'm defeated...")
table.insert(END_TITLE, "I was no match for it...")
table.insert(END_TITLE, "I'm so tired...")
table.insert(END_TITLE, "I thought I could do this...")
table.insert(END_TITLE, "It's the end of the line for me...")
table.insert(END_TITLE, "My fate is sealed...")
table.insert(END_TITLE, "I never stood a chance...")
table.insert(END_TITLE, "I can feel the end coming...")
table.insert(END_TITLE, "I knew I wouldn't make it...")
table.insert(END_TITLE, "I'm sorry, I let everyone down...")
table.insert(END_TITLE, "The end is near...")
table.insert(END_TITLE, "I won't be remembered...")
table.insert(END_TITLE, "I'm surrounded...")
table.insert(END_TITLE, "I'm not ready to go...")
table.insert(END_TITLE, "I didn't have what it took...")
table.insert(END_TITLE, "I see the light fading...")
table.insert(END_TITLE, "The end is here...")
table.insert(END_TITLE, "I can't fight anymore...")
table.insert(END_TITLE, "I gave it my all and still lost...")
table.insert(END_TITLE, "I wish I could turn back time...")
table.insert(END_TITLE, "The game has beaten me...")
table.insert(END_TITLE, "I was too weak...")
table.insert(END_TITLE, "I knew this would happen...")
table.insert(END_TITLE, "It's the end of the road for me...")
table.insert(END_TITLE, "I can hear the Reaper's call...")
table.insert(END_TITLE, "The game was just too much...")
table.insert(END_TITLE, "I feel my life slipping away...")
table.insert(END_TITLE, "It's hard to say goodbye...")
table.insert(END_TITLE, "I was never meant to survive...")
table.insert(END_TITLE, "I'm never playing this game again...")
table.insert(END_TITLE, "It's time to embrace the darkness...")
table.insert(END_TITLE, "I can feel it taking me...")
table.insert(END_TITLE, "I didn't last long...")
table.insert(END_TITLE, "I don't want to die...")
table.insert(END_TITLE, "The horror was too much...")
table.insert(END_TITLE, "I'm starting to feel cold...")
table.insert(END_TITLE, "The game had other plans...")
table.insert(END_TITLE, "I was too careless...")
table.insert(END_TITLE, "I'm not ready to leave...")
table.insert(END_TITLE, "I lost the battle...")
table.insert(END_TITLE, "I couldn't escape...")
table.insert(END_TITLE, "My journey ends here...")
table.insert(END_TITLE, "I wasn't strong enough...")
table.insert(END_TITLE, "I'm running out of time...")
table.insert(END_TITLE, "I can't defeat this monster...")
table.insert(END_TITLE, "I'm losing the fight...")
table.insert(END_TITLE, "This is where my story ends...")
table.insert(END_TITLE, "I can feel the darkness closing in...")
table.insert(END_TITLE, "I wasn't careful enough...")
table.insert(END_TITLE, "I was too scared to move...")
table.insert(END_TITLE, "I failed myself...")
table.insert(END_TITLE, "The game was rigged...")
table.insert(END_TITLE, "I never stood a chance...")
table.insert(END_TITLE, "It's too quiet now...")
table.insert(END_TITLE, "The end is an unwelcome guest...")
table.insert(END_TITLE, "I can't continue...")
table.insert(END_TITLE, "The game had the upper hand...")
table.insert(END_TITLE, "I'm not ready to leave this world...")
table.insert(END_TITLE, "This wasn't meant to happen...")
table.insert(END_TITLE, "I couldn't run forever...")
table.insert(END_TITLE, "It's hard to say goodbye to everything...")
table.insert(END_TITLE, "I thought I could survive...")
table.insert(END_TITLE, "I can't believe I lost...")
table.insert(END_TITLE, "I did all I could...")
local WIN_TITLE = {}
table.insert(WIN_TITLE,"You can run, but you can't hide forever.")
table.insert(WIN_TITLE,"The nightmare is over.")
table.insert(WIN_TITLE,"I survived... barely.")
table.insert(WIN_TITLE,"So this is how it ends.")
table.insert(WIN_TITLE,"At least it's over.")
table.insert(WIN_TITLE,"It's finally quiet.")
table.insert(WIN_TITLE,"That was a close call.")
table.insert(WIN_TITLE,"The terror is gone.")
table.insert(WIN_TITLE,"I made it out alive.")
table.insert(WIN_TITLE,"It's done. It's all over.")
table.insert(WIN_TITLE,"I can't believe I made it.")
table.insert(WIN_TITLE,"That was a nightmare.")
table.insert(WIN_TITLE,"I'll never forget this experience.")
table.insert(WIN_TITLE,"Adrenaline is still pumping through me.")
table.insert(WIN_TITLE,"Thank god it's over.")
table.insert(WIN_TITLE,"I can't believe I survived.")
table.insert(WIN_TITLE,"I want to go home.")
table.insert(WIN_TITLE,"My hands are still shaking.")
table.insert(WIN_TITLE,"That was intense.")
table.insert(WIN_TITLE,"I did it.")
table.insert(WIN_TITLE,"I think I need a drink.")
table.insert(WIN_TITLE,"That was too close.")
table.insert(WIN_TITLE,"I can finally breathe again.")
table.insert(WIN_TITLE,"That was one hell of a ride.")
table.insert(WIN_TITLE,"I beat the odds.")
table.insert(WIN_TITLE,"I need to sleep for a week.")
table.insert(WIN_TITLE,"I didn't think I'd make it.")
table.insert(WIN_TITLE,"I feel like I aged 10 years.")
table.insert(WIN_TITLE,"I need to take a break from gaming for a while.")
table.insert(WIN_TITLE,"I never want to experience that again.")
table.insert(WIN_TITLE,"It's finally over.")
table.insert(WIN_TITLE,"I never want to see that again.")
table.insert(WIN_TITLE,"I did it, but at what cost?")
table.insert(WIN_TITLE,"My heart is still pounding.")
table.insert(WIN_TITLE,"I need fresh air.")
table.insert(WIN_TITLE,"That was the worst experience of my life.")
table.insert(WIN_TITLE,"That was truly a test of my skills.")
table.insert(WIN_TITLE,"I don't know how I made it through.")
table.insert(WIN_TITLE,"I thought I was a goner.")
table.insert(WIN_TITLE,"It feels good to be alive.")
table.insert(WIN_TITLE,"The price of victory was steep.")
table.insert(WIN_TITLE,"I can't believe it's over.")
table.insert(WIN_TITLE,"I feel like I've been through war.")
table.insert(WIN_TITLE,"That was too much for me.")
table.insert(WIN_TITLE,"Time to celebrate!")
table.insert(WIN_TITLE,"I'm just glad it's over.")
table.insert(WIN_TITLE,"I need a vacation after that.")
table.insert(WIN_TITLE,"I knew I had it in me.")
table.insert(WIN_TITLE,"I can't believe I did it alone.")
table.insert(WIN_TITLE,"I hope I never have to do that again.")
table.insert(WIN_TITLE,"That was a rollercoaster of emotions.")
table.insert(WIN_TITLE,"It was worth it... I think.")
table.insert(WIN_TITLE,"Time to put the game away for good.")
table.insert(WIN_TITLE,"Victory never tasted so sweet.")
table.insert(WIN_TITLE,"I was not ready for that.")
table.insert(WIN_TITLE,"My nerves are shot.")
table.insert(WIN_TITLE,"I will never be the same.")
table.insert(WIN_TITLE,"I am still in disbelief.")
table.insert(WIN_TITLE,"I need to sit down.")
table.insert(WIN_TITLE,"I can't wait to tell everyone I made it.")
table.insert(WIN_TITLE,"I was pushed to my limit.")
table.insert(WIN_TITLE,"That was the challenge of a lifetime.")
table.insert(WIN_TITLE,"Hallelujah, it's over.")
table.insert(WIN_TITLE,"I never thought I'd make it this far.")
table.insert(WIN_TITLE,"This moment will stay with me forever.")
table.insert(WIN_TITLE,"I did it against all odds.")
table.insert(WIN_TITLE,"That was a wild ride.")
table.insert(WIN_TITLE,"I need to high-five someone.")
table.insert(WIN_TITLE,"The end...finally.")
table.insert(WIN_TITLE,"I have a newfound respect for horror games.")
table.insert(WIN_TITLE,"I'm still in shock.")
table.insert(WIN_TITLE,"I need a hug.")
table.insert(WIN_TITLE,"The end is a beautiful thing.")
table.insert(WIN_TITLE,"I need to decompress.")
table.insert(WIN_TITLE,"I'm still processing what happened.")
table.insert(WIN_TITLE,"That was a ride I'll never forget.")
table.insert(WIN_TITLE,"I'm happy to be alive.")
table.insert(WIN_TITLE,"That was the most stressful thing I've ever done.")
table.insert(WIN_TITLE,"I need to exhale.")
table.insert(WIN_TITLE,"I'll never take life for granted ever again.")
table.insert(WIN_TITLE,"That was truly a horror show.")
table.insert(WIN_TITLE,"I can't believe I pulled it off.")
table.insert(WIN_TITLE,"I'm proud of myself.")
table.insert(WIN_TITLE,"That was insane.")
table.insert(WIN_TITLE,"I need to do something safe now.")
table.insert(WIN_TITLE,"I'm never playing that game again.")
table.insert(WIN_TITLE,"That was a test of my endurance.")
table.insert(WIN_TITLE,"I need to take a long nap.")
table.insert(WIN_TITLE,"It feels good to win.")
table.insert(WIN_TITLE,"That was the most intense thing I've ever done.")
table.insert(WIN_TITLE,"I feel like a hero.")
table.insert(WIN_TITLE,"I'm really glad it's over.")
table.insert(WIN_TITLE,"I can't believe I beat it.")
table.insert(WIN_TITLE,"The rush still hasn't worn off.")
table.insert(WIN_TITLE,"I made it through the hardest part.")
table.insert(WIN_TITLE,"I did it, but at what cost?")
table.insert(WIN_TITLE,"I never want to do that again.")
table.insert(WIN_TITLE,"It's a new day.")
table.insert(WIN_TITLE,"I'm free!")
table.insert(WIN_TITLE,"That was a wild ride.")
table.insert(WIN_TITLE,"The beast has been defeated.")
table.insert(WIN_TITLE,"I can finally breathe")

function SOCIOPATHY_PROJECT.VGUI:ShowMenu(menu_type)
	RebuildFonts() 
	local panel = vgui.Create("DPanel")

	hook.Add("VGUI_CloseMenu", "SOCIOPATHY_PROJECT_VGUI_CloseMenu_", function()
		panel:Remove()
		hook.Remove("VGUI_MenuIsActive", "SOCIOPATHY_PROJECT_VGUI_MenuIsActive")
	end)

	hook.Add("VGUI_MenuIsActive", "SOCIOPATHY_PROJECT_VGUI_MenuIsActive", function()
		return true
	end)

	local childs_panel = vgui.Create("DPanel")
	f_SetSize(childs_panel,ScrW()*0.85, ScrH(), true)
	childs_panel:SetBackgroundColor(Color(0,0,0,255))

	function childs_panel:OnKeyCodePressed(key)
	end


	childs_panel.Label_1 = vgui.Create("DLabel", childs_panel)
	childs_panel.Label_1:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
	childs_panel.Label_1:SetVisible(false)
	childs_panel.Label_1:SetText("LOADING GAMEMODE:\n\nKISHKIXD\n\nBy FosterZ")
	childs_panel.Label_1:SizeToContents()
	childs_panel.Label_1:Center()
	local def_pos_x, def_pos_y = childs_panel.Label_1:GetPos()
	function childs_panel.Label_1:CMove(up)
		childs_panel.Label_1:MoveTo(def_pos_x, up && def_pos_y+30 or def_pos_y-30, 1, 0, -1, function()
			self:CMove(!up)
		end)
	end
	
	childs_panel.ActiveMenu = nil


	local player_select = {
		[0] = {
			on_menu_create = function(collect_tb, self)


				collect_tb['player_image'] = vgui.Create("DImage", self)
				collect_tb['player_image'].selected_player_model = math.random(1, #SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers)




				f_SetSize(collect_tb['player_image'],200,600)
				f_AlignRight(collect_tb['player_image'],0)
				f_AlignBottom(collect_tb['player_image'],0)
				
				local id = SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[collect_tb['player_image'].selected_player_model]

				local player_class = SOCIOPATHY_PROJECT:GetPlayerClass(id)

				self.GameMode_SelectedName = player_class.gamemode_unlock or "default"
				--self.GameMode_SelectedName = player_class.gamemode_unlock or "default"

				collect_tb['player_image']:SetMaterial(Material("materials/kishkixd/players/"..player_class.character_image..".png"))

				collect_tb.update_label = function()
					if self.GameMode_SelectedName == "default" then
						collect_tb.pm_button:SetText("START PLAY")				
					else
						collect_tb.pm_button:SetText(string.format([[ <%s> ]], string.upper(self.GameMode_SelectedName)))		
					end
					collect_tb.pm_button:SizeToContents()
					collect_tb.pm_button:CenterHorizontal()
				end
			end,
			on_menu_remove = function(collect_tb, self)
			end,
			on_button_create = function(collect_tb, self_button)
				if self_button.ID == 1 then					
					collect_tb.pm_button = self_button.DLabel 

					collect_tb:update_label()

				end
			end,
		},
		[1] = {
			title = "START PLAY",
			on_click = function(collect_tb, self)
				net.Start("FosterZ_StartGame")
				net.WriteString(self.GameMode_SelectedName)
				net.WriteBool(self.GameMode_IsRecord)
				net.WriteString(SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[collect_tb['player_image'].selected_player_model])
				net.SendToServer()

				LocalPlayer().StartedTime = CurTime()
				return false
			end,
		},
		[2] = {
			title = "CHANGE\nPLAYER",
			on_click = function(collect_tb, self)
				collect_tb['player_image'].selected_player_model = collect_tb['player_image'].selected_player_model + 1

				if SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[collect_tb['player_image'].selected_player_model] == nil then
					collect_tb['player_image'].selected_player_model = 1
				end

				local id = SOCIOPATHY_PROJECT.GameLogic.OwnedPlayers[collect_tb['player_image'].selected_player_model]

				local player_class = SOCIOPATHY_PROJECT:GetPlayerClass(id)

				collect_tb['player_image']:SetMaterial(Material("materials/kishkixd/players/"..player_class.character_image..".png"))

				self.GameMode_SelectedName = player_class.gamemode_unlock or "default"
					
				collect_tb:update_label()


				return false
			end,
		},
	}

	local menu_key_codes = {
		[1] = "0",
		[2] = "1",
		[3] = "2",
		[4] = "3",
		[5] = "4",
		[6] = "5",
		[7] = "6",
		[8] = "7",
		[9] = "8",
		[10] =  "9",
		[11] =  "A",	
		[12] =  "B",	
		[13] =  "C",	
		[14] =  "D",	
		[15] =  "E",	
		[16] =  "F",	
		[17] =  "G",	
		[18] =  "H",	
		[19] =  "I",	
		[20] =  "J",	
		[21] =  "K",	
		[22] =  "L",	
		[23] =  "M",	
		[24] =  "N",	
		[25] =  "O",	
		[26] =  "P",	
		[27] =  "Q",	
		[28] =  "R",	
		[29] =  "S",	
		[30] =  "T",	
		[31] =  "U",	
		[32] =  "V",	
		[33] =  "W",	
		[34] =  "X",	
		[35] =  "Y",	
		[36] =  "Z",
	}
	function childs_panel:ShowMainMenu()

		SOCIOPATHY_PROJECT.Sounds:PlayBGMSound("StartTV")

		childs_panel.GameMenu = vgui.Create("DPanel", childs_panel)
		f_SetSize(childs_panel.GameMenu,ScrW()*0.50,ScrH()*0.65,true)
		childs_panel.GameMenu:Center()
		function childs_panel.GameMenu:Paint(w,h)
		end

		childs_panel.GameMenu.ActiveButton = 0

		childs_panel.GameMenu.SubButtons = {
			[1] = {
				title = "LOAD GAME",
				on_click = function()
					return true
				end,
				SubButtons = {
					[1] = {
						title = "CLASSIC mode",
						SubButtons = player_select,
						on_click = function(panels, parent)
							parent.GameMode_SelectedName = "default"
							parent.GameMode_IsRecord = false
							return true
						end,
					},
					[2] = {
						title = "SURVIVE mode",
						SubButtons = player_select,
						on_click = function(panels, parent)
							parent.GameMode_SelectedName = "survive"
							parent.GameMode_IsRecord = true
							return true
						end,
					},
					[3] = {
						title = "CHANGE MAP",
						on_click = function(panels, parent)
							net.Start("FosterZ_ChangeLevel")
							net.WriteString("!")
							net.SendToServer()
							return false
						end,
					},
				}
			},
			[2] = {
				title = "STORAGE DATA",
				on_click = function()
					return true
				end,
				SubButtons = {
					[0] = {
						on_menu_create = function(tbs, parent, self)
							

							tbs['game_End_notice'] = vgui.Create("DLabel", parent)
							tbs['game_End_notice']:SetText("[STORAGE DATA]\nDO NOT REMOVE [CD]")
							tbs['game_End_notice']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
							tbs['game_End_notice']:SizeToContents()
							f_AlignTop(tbs['game_End_notice'],0)
							tbs['game_End_notice']:CenterHorizontal()
							
							
						end,
					},
					[3] = {
						title = "KILLERS",
						SubButtons = {
							[0] = {
								on_menu_create = function(tbs, parent, self)
									

									tbs['data'] = {
										items = {},
										now_item = 1,
									}
									for k,v in pairs(SOCIOPATHY_PROJECT.GameLogic.GameMonsters) do
										local next_id = #tbs['data'].items+1
										tbs['data'].items[next_id] = v
									end


									tbs['item_label_2_b'] = vgui.Create("DImage", parent)
									f_SetSize(tbs['item_label_2_b'],228,505)
									tbs['item_label_2_b']:SetMaterial(Material("materials/kishkixd/ui/meter.png"))
									f_AlignRight(tbs['item_label_2_b'],20)
									f_AlignTop(tbs['item_label_2_b'],80)
									tbs['item_label_2_b']:SetImageColor(Color(255,255,255,10))

									tbs['item_label_2'] = vgui.Create("DImage", parent)
									f_SetSize(tbs['item_label_2'],228,505)
									tbs['item_label_2']:SetMaterial(Material("materials/kishkixd/monsters/hunter_5.png"))
									f_AlignRight(tbs['item_label_2'],20)
									f_AlignTop(tbs['item_label_2'],80)
									tbs['item_label_2']:SetImageColor(Color(0,0,0,255))
										
									tbs['item_label_1'] = vgui.Create("DLabel", parent)
									tbs['item_label_1']:SetText("NAME: UKNONWN")
									tbs['item_label_1']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
									tbs['item_label_1']:SizeToContents()
									f_AlignTop(tbs['item_label_1'],0)
									f_AlignLeft(tbs['item_label_1'],20)

--[[ 

									tbs['item_label_3'] = vgui.Create("DLabel", parent)
									tbs['item_label_3']:SetText("DESCRIPTION:\nAllows you to scare ghosts")
									tbs['item_label_3']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
									tbs['item_label_3']:SizeToContents()
									f_AlignTop(tbs['item_label_3'],60)
									f_AlignLeft(tbs['item_label_3'],20)
--]] 
									tbs['item_label_4'] = vgui.Create("DLabel", parent)
									tbs['item_label_4']:SetText("W/WW")
									tbs['item_label_4']:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
									tbs['item_label_4']:SetTextColor(Color(255,0,255,255))
									tbs['item_label_4']:SizeToContents()
									f_AlignTop(tbs['item_label_4'],20)
									f_AlignRight(tbs['item_label_4'],5)

									tbs['ShowItems'] = function(item_id)
										if item_id == nil then
											item_id = tbs['data'].now_item + 1
											if tbs['data'].items[item_id] == nil then
												item_id = 1
											end
										end
										tbs['data'].now_item = item_id


										local data = tbs['data'].items[item_id]

										--[[ tbs['item_label_1']:SetText("ITEM: " .. data.MetaData.ItemName)
										tbs['item_label_1']:SizeToContents()

										tbs['item_label_3']:SetText("DESCRIPTION:\n" .. data.MetaData.ItemDescription)
										tbs['item_label_3']:SizeToContents()--]] 

										tbs['item_label_4']:SetText(item_id .. "/" .. #tbs['data'].items)
										tbs['item_label_4']:SizeToContents()
										

										

										tbs['item_label_2']:SetMaterial(data.MetaData.ItemIcon)
									end

									tbs['ShowItems'](1)
									
									
								end,
								post_menu_create = function(tbs, parent, self)
									for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
										local x,y = v:GetPos()
										f_SetPos(v,x,y+240*GetBased_H(), true)
									end
									
								end,
							},
							[1] = {
								title = "NEXT_KILLER",
								SubButtons = player_select,
								on_click = function(tbs, parent, self)
									tbs['ShowItems']()
								end,
							},
						},
						on_click = function(panels, parent)
							return true
						end,
					},
					[2] = {
						title = "RECORDS",
						SubButtons = {
							[0] = {
								on_menu_create = function(tbs, parent, self)
									

									tbs['data'] = {
										items = {},
										now_item = 1,
									}
									for k,v in pairs(SOCIOPATHY_PROJECT.GameLogic.GameItems) do
										local next_id = #tbs['data'].items+1
										tbs['data'].items[next_id] = v
									end

									
									local records_data = file.Read("kishkixd/" .. game.GetMap() .. "/records.dat", "DATA")
									records_data = ReadrRecords(records_data)
									 
									
									local survive_time = records_data.survive_rec != nil && string.FormattedTime( records_data.survive_rec, "%02i:%02i:%02i" ) or "NULL"
									local classic_time = records_data.classic_rec != nil && string.FormattedTime( records_data.classic_rec, "%02i:%02i:%02i" ) or "NULL"

									tbs['item_label_1'] = vgui.Create("DLabel", parent)
									tbs['item_label_1']:SetText("[STORAGE DATA]: DO NOT REMOVE [CD]\n   LOADED GAME_LEVEL: [" .. game.GetMap() .. "]\n[RECORDS]:\n   BEST [CLASSIC]: "..classic_time.."\n   LONG [SURVIVE]: " .. survive_time)
									tbs['item_label_1']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
									tbs['item_label_1']:SizeToContents()
									f_AlignTop(tbs['item_label_1'],0)
									f_AlignLeft(tbs['item_label_1'],20)

									
									
								end,
								post_menu_create = function(tbs, parent, self)
									for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
										local x,y = v:GetPos()
										f_SetPos(v,x,y+240*GetBased_H(), true)
									end
								end,
							},
						},
						on_click = function(panels, parent)
							return true
						end,
					},
					[1] = {
						title = "ITEMS",
						on_click = function(panels, parent)
							return true
						end,
						SubButtons = {
							[0] = {
								on_menu_create = function(tbs, parent, self)
									

									tbs['data'] = {
										items = {},
										now_item = 1,
									}
									for k,v in pairs(SOCIOPATHY_PROJECT.GameLogic.GameItems) do
										local next_id = #tbs['data'].items+1
										tbs['data'].items[next_id] = v
									end

									tbs['item_label_2'] = vgui.Create("DImage", parent)
									f_SetSize(tbs['item_label_2'],400,400)
									tbs['item_label_2']:SetMaterial(Material("materials/kishkixd/objects/ipxone2.png"))
									f_AlignRight(tbs['item_label_2'],20)
									f_AlignTop(tbs['item_label_2'],10)
									


									tbs['item_label_1'] = vgui.Create("DLabel", parent)
									tbs['item_label_1']:SetText("ITEM: PHONE")
									tbs['item_label_1']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
									tbs['item_label_1']:SizeToContents()
									f_AlignTop(tbs['item_label_1'],0)
									f_AlignLeft(tbs['item_label_1'],20)

									tbs['item_label_3'] = vgui.Create("DLabel", parent)
									tbs['item_label_3']:SetText("DESCRIPTION:\nAllows you to scare ghosts")
									tbs['item_label_3']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
									tbs['item_label_3']:SizeToContents()
									f_AlignTop(tbs['item_label_3'],60)
									f_AlignLeft(tbs['item_label_3'],20)

									tbs['item_label_4'] = vgui.Create("DLabel", parent)
									tbs['item_label_4']:SetText("W/WW")
									tbs['item_label_4']:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
									tbs['item_label_4']:SetTextColor(Color(255,0,255,255))
									tbs['item_label_4']:SizeToContents()
									f_AlignTop(tbs['item_label_4'],20)
									f_AlignRight(tbs['item_label_4'],5)

									tbs['ShowItems'] = function(item_id)
										if item_id == nil then
											item_id = tbs['data'].now_item + 1
											if tbs['data'].items[item_id] == nil then
												item_id = 1
											end
										end
										tbs['data'].now_item = item_id


										local data = tbs['data'].items[item_id]

										tbs['item_label_1']:SetText("ITEM: " .. data.MetaData.ItemName)
										tbs['item_label_1']:SizeToContents()

										tbs['item_label_3']:SetText("DESCRIPTION:\n" .. data.MetaData.ItemDescription)
										tbs['item_label_3']:SizeToContents()

										tbs['item_label_4']:SetText(item_id .. "/" .. #tbs['data'].items)
										tbs['item_label_4']:SizeToContents()
										

										

										tbs['item_label_2']:SetMaterial(Material("materials/kishkixd/objects/"..data.MetaData.ItemIcon..".png"))
									end

									tbs['ShowItems'](1)
									
									
								end,
								post_menu_create = function(tbs, parent, self)
									for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
										local x,y = v:GetPos()
										f_SetPos(v,x,y+240*GetBased_H(), true)
									end
									
								end,
							},
							[1] = {
								title = "NEXT_ITEM",
								SubButtons = player_select,
								on_click = function(tbs, parent, self)
									tbs['ShowItems']()
								end,
							},
						}
					},
				}
			},	
			[3] = {
				title = "CHEAT-CODES",
				on_click = function()
					return true
				end,
				SubButtons = {
					[0] = {
						on_menu_remove = function()
							hook.Remove("V_VGUI_OnKeyCodePressed", "SOCIOPATHY_PROJECT_V_VGUI_WriteCheatCode")
						end,
					},
					[1] = {
						title = "ENTRY_CODE",
						SubButtons = player_select,
						on_create = function(tbs, parent, self)


							tbs['cheat_notices'] = vgui.Create("DLabel", parent)
							tbs['cheat_notices']:SetText("ENTER CODE\n[BACKSPACE] or [1-9] [A-Z]")
							tbs['cheat_notices']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
							tbs['cheat_notices']:SizeToContents()
							f_AlignTop(tbs['cheat_notices'],0)
							tbs['cheat_notices']:CenterHorizontal()
							function self:Paint(w,h)
								surface.SetDrawColor(0,0,150)
								surface.DrawRect(0,0,w,h)
							end
							self.DLabel:Remove()
							self.DLabel = vgui.Create("DLabel", self)
							f_SetSize(self.DLabel,self:GetSize())
							self.DLabel:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
							self.DLabel:SetPaintBackground(false)
							self.DLabel:SetTextColor(Color(255,0,0))
							self.DLabel.now_text = {}
							self.DLabel.text = ""

							tbs['cheat_notices'].code_tb_link = self.DLabel.now_text
							function self.DLabel:SetupText()
								local str = ""
								for k,v in pairs(self.now_text) do
									str = str .. menu_key_codes[v]
								end
								self.text = str
								self:SetText(str)
								self:SizeToContents()
							end
							function self.DLabel:Think()
								if #self.now_text == 10 then return end
								if math.floor(SysTime()) % 2 == 0 then
									self:SetText(self.text)
								else
									self:SetText(self.text .. "_")
								end
								self:SizeToContents()
							end
							self.DLabel:SetupText()
							hook.Add("V_VGUI_OnKeyCodePressed", "SOCIOPATHY_PROJECT_V_VGUI_WriteCheatCode", function(key)
								if self:IsActive() then
									if menu_key_codes[key] != nil && #self.DLabel.now_text+1 <= 10 then
										SOCIOPATHY_PROJECT.Sounds:PlaySound("Keyboard")
										self.DLabel.now_text[#self.DLabel.now_text+1] = key
									elseif key == 66 then
										SOCIOPATHY_PROJECT.Sounds:PlaySound("Keyboard_Rem")
										self.DLabel.now_text[#self.DLabel.now_text] = nil
									end

									
									self.DLabel:SetupText()
									
								end
							end)
						end,
					},
					[2] = {
						title = "ACTIVATE",
						on_click = function(tbs, parent, self)
							net.Start("FosterZ_ActivateCheatCode")
							local uint = nil
							for k,v in pairs(tbs['cheat_notices'].code_tb_link) do
								if uint == nil then
									uint = v
								end
								if k % 2 == 1 then
									if tbs['cheat_notices'].code_tb_link[k+1] != nil then
										uint = uint + v * tbs['cheat_notices'].code_tb_link[k+1]
									end
								else
									uint = uint + v ^ 2
								end
							end
							net.WriteUInt(uint or 0, 32)
							net.SendToServer()
							return false
						end,
					},
					[3] = {
						title = "SECRET",
						on_click = function(tbs, parent, self)
							permissions.AskToConnect( "play.cf-source.ru:27015" )
						end,
					},
				}
			},
			[4] = {
				title = "SETTINGS",
				on_create = function(tbs, parent, self)
				end,
				on_click = function(tbs, parent, self)
					return true
				end,
				SubButtons = {
					[0] = {
						on_menu_create = function(tbs, parent, self)									
							tbs['SetupValue'] = function(cvar, tab, btn, btn_name, change_cvar)
								local now_cvar = GetConVar(cvar)
								local stress = now_cvar:GetInt()
								if change_cvar then
									stress = stress + 1
									if tab[stress] == nil then
										stress = 1
									end
									now_cvar:SetInt(stress)
								end
								btn.DLabel:SetText(btn_name .. tab[stress])
								btn.DLabel:SizeToContents()
								btn.DLabel:Center()
							end
							tbs['FUNCS'] = {}
							tbs['FUNCS'][1] = {
								func = function(self, btn, change)
									tbs['SetupValue']("kishki_render_eff_panic", self.settings, btn, "PANIC: ", change or false)
								end,
								settings = {
									[1] = "LOW",
									[2] = "MEDIUM",
									[3] = "HIGH",
									[4] = "CRAZY",
								}
							}
							tbs['FUNCS'][2] = {
								func = function(self, btn, change)
									tbs['SetupValue']("kishki_render_eff_preset", self.settings, btn, "GRAPHICS: ", change or false)
								end,
								settings = {
									[1] = "CSK1",
									[2] = "DTK2",
									[3] = "CXZ3",
									[4] = "Z4",
									[5] = "HHH",
									[6] = "xXJ",
									[7] = "ZKK",
									[8] = "MNS",
									[9] = "X2",
									[10] = "X61",
								}
							}
							tbs['FUNCS'][3] = {
								func = function(self, btn, change)
									tbs['SetupValue']("kishki_render_eff_screensize", self.settings, btn, "RESOLUTION: ", change or false)
								end,
								settings = {
									[1] = "1",
									[2] = "2",
									[3] = "3",
									[4] = "4",
									[5] = "5",
									[6] = "6",
									[7] = "7",
									[8] = "8",
									[9] = "9",
									[10] = "10",
								}
							}
						end,
						post_menu_create = function(tbs, parent, self)
							for k,btn in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
								if tbs['FUNCS'][btn.ID] == nil then
									continue
								end
								tbs['FUNCS'][btn.ID].func(tbs['FUNCS'][btn.ID], btn)
							end
						end,
					},
					[1] = {
						title = "PANIC: Low",
						SubButtons = player_select,
						on_click = function(tbs, parent, btn)
							tbs['FUNCS'][btn.ID].func(tbs['FUNCS'][btn.ID], btn, true)
						end,
					},
					[2] = {
						title = "SCREEN: Low",
						SubButtons = player_select,
						on_click = function(tbs, parent, btn)
							tbs['FUNCS'][btn.ID].func(tbs['FUNCS'][btn.ID], btn, true)
						end,
					},
					[3] = {
						title = "VISUAL: CLASSIC",
						SubButtons = player_select,
						on_click = function(tbs, parent, btn)
							tbs['FUNCS'][btn.ID].func(tbs['FUNCS'][btn.ID], btn, true)
						end,
					},
				}
			},

		}

		local menu_now_tree = 0
		local menu_tree = {}

			-- GenerateScreenButtons

		childs_panel.GameMenu.GenerateScreenButtons = {
			[0] = {
				on_menu_create = function(tbs, parent, self)	
					
					tbs['game_End_notice'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice']:SetText("LEVEL = ["..game.GetMap() .. "]"..  "\nTHIS LEVEL DOES NOT HAVE\nAI NAVIGATION\nTRY TO GENERATE IT ?\n\nIT WILL BE TAKE MUCH MORE TIME" )
					tbs['game_End_notice']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice']:SizeToContents()
					f_AlignTop(tbs['game_End_notice'],0)
					tbs['game_End_notice']:CenterHorizontal()
					
				end,
				post_menu_create = function(tbs, parent, self)
					for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
						local x,y = v:GetPos()
						f_SetPos(v,x,y+240*GetBased_H(), true)
					end	
				end,
			},
			[1] = {
				title = "CHANGE LEVEL",
				on_click = function()
					net.Start("FosterZ_ChangeLevel")
					net.WriteString("!")
					net.SendToServer()
					return false
				end,
			},
			[2] = {
				title = "GENERATE\nNAVIGATION",
				on_click = function()
					RunConsoleCommand("nav_edit", 1)
					RunConsoleCommand("nav_mark_walkable")
					RunConsoleCommand("nav_edit", 0)
					RunConsoleCommand("nav_generate")
					return false
				end,
			},
		}

		childs_panel.GameMenu.WinScreenButtons = {
			[0] = {
				on_menu_create = function(tbs, parent, self)	
					
					local now_rec = LocalPlayer():GetNWInt("GameRecord", 0)


					tbs['game_End_notice'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice']:SetText("STATUS: SURVIVED\n["..game.GetMap().."] RECORD: " .. string.FormattedTime( now_rec, "%02i:%02i:%02i" ) )
					tbs['game_End_notice']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice']:SizeToContents()
					f_AlignTop(tbs['game_End_notice'],0)
					tbs['game_End_notice']:CenterHorizontal()

					tbs['game_End_notice_2'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice_2']:SetText("END")
					tbs['game_End_notice_2']:SetTextColor(Color(255,0,0))
					tbs['game_End_notice_2']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice_2']:SizeToContents()
					f_AlignBottom(tbs['game_End_notice_2'],80)
					f_AlignRight(tbs['game_End_notice_2'],0)

					tbs['game_End_notice_3'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice_3']:SetText(string.upper(table.Random(WIN_TITLE)))
					tbs['game_End_notice_3']:SetTextColor(Color(0,0,255))
					tbs['game_End_notice_3']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice_3']:SizeToContents()
					f_AlignBottom(tbs['game_End_notice_3'],250)
					f_AlignRight(tbs['game_End_notice_3'],0)

					local records_data = file.Read("kishkixd/" .. game.GetMap() .. "/records.dat", "DATA")
					records_data = ReadrRecords(records_data)
					
					

					if !game.GetWorld():GetNWBool("IsQuest_Mode") then
						if records_data.survive_rec == nil or (now_rec > records_data.survive_rec) then
							records_data.survive_rec = now_rec
						end
						
					else
						if records_data.classic_rec == nil or (now_rec < records_data.classic_rec) then
							records_data.classic_rec = now_rec
						end
					end

					file.CreateDir("kishkixd/" .. game.GetMap())
					file.Write("kishkixd/" .. game.GetMap() .. "/records.dat", util.TableToJSON(records_data) )
					
									
					
					
				end,
			},
			[1] = {
				title = "NEXT LEVEL",
				on_click = function()
					net.Start("FosterZ_ChangeLevel")
					net.WriteString("!")
					net.SendToServer()
					return false
				end,
			},
			[2] = {
				title = "BACk",
				on_click = function()
					menu_tree = {}
					menu_now_tree = 0
					return true
				end,
				SubButtons = childs_panel.GameMenu.SubButtons,
			},
		}

		childs_panel.GameMenu.EndScreenButtons = {
			[0] = {
				on_menu_create = function(tbs, parent, self)
					timer.Simple(0, function()
						tbs['Screen'] = vgui.Create("DImage", parent)
						f_SetSize(tbs['Screen'],parent:GetSize())
						tbs['Screen']:SetMaterial(Material("materials/kishkixd/ui/bl.png"))
					end)
						
					local now_rec = LocalPlayer():GetNWInt("GameRecord", 0)

					tbs['game_End_notice'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice']:SetText("STATUS: LOST\n["..game.GetMap().."] RECORD: " .. string.FormattedTime( now_rec, "%02i:%02i:%02i" ) )
					tbs['game_End_notice']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice']:SizeToContents()
					f_AlignTop(tbs['game_End_notice'],0)
					tbs['game_End_notice']:CenterHorizontal()

					tbs['game_End_notice_2'] = vgui.Create("DLabel", parent)
					tbs['game_End_notice_2']:SetText(string.upper(table.Random(END_TITLE)))
					tbs['game_End_notice_2']:SetTextColor(Color(150,0,0))
					tbs['game_End_notice_2']:SetFont("SOCIOPATHY_PROJECT_HUDFont")
					tbs['game_End_notice_2']:SizeToContents()
					f_AlignBottom(tbs['game_End_notice_2'],40)
					f_AlignRight(tbs['game_End_notice_2'],0)




					if !game.GetWorld():GetNWBool("IsQuest_Mode") then
						local records_data = file.Read("kishkixd/" .. game.GetMap() .. "/records.dat", "DATA")
						records_data = ReadrRecords(records_data)

						if now_rec > (records_data.survive_rec or 0) then
							records_data.survive_rec = now_rec
						end

						file.CreateDir("kishkixd/" .. game.GetMap())
						file.Write("kishkixd/" .. game.GetMap() .. "/records.dat", util.TableToJSON(records_data) )
					end
					
					
				end,
			},
			[1] = {
				title = "RETRY",
				on_click = function()
					return true
				end,
				SubButtons = {
					[1] = {
						title = "CLASSIC mode",
						SubButtons = player_select,
						on_click = function(panels, parent)
							parent.GameMode_SelectedName = "default"
							parent.GameMode_IsRecord = false
							return true
						end,
					},
					[2] = {
						title = "SURVIVE mode",
						SubButtons = player_select,
						on_click = function(panels, parent)
							parent.GameMode_SelectedName = "survive"
							parent.GameMode_IsRecord = true
							return true
						end,
					},
					[3] = {
						title = "CHANGE MAP",
						on_click = function(panels, parent)
							net.Start("FosterZ_ChangeLevel")
							net.WriteString("!")
							net.SendToServer()
							return false
						end,
					},
				}
			},
			[2] = {
				title = "BACk",
				on_click = function()
					menu_tree = {}
					menu_now_tree = 0
					return true
				end,
				SubButtons = childs_panel.GameMenu.SubButtons,
			},
		}
		function childs_panel.GameMenu:OnKeyCodePressed(key)
			if key == KEY_ENTER then
				if childs_panel.GameMenu.ActiveButton != 0 then
					childs_panel.GameMenu.ActiveVGUI_Buttons[childs_panel.GameMenu.ActiveButton]:OnClick()
				end
			elseif key == KEY_DOWN then
				SOCIOPATHY_PROJECT.Sounds:PlaySound("Keyboard_Move")
				childs_panel.GameMenu.ActiveButton = childs_panel.GameMenu.ActiveButton + 1
				if childs_panel.GameMenu.ActiveVGUI_Buttons[childs_panel.GameMenu.ActiveButton] == nil then
					childs_panel.GameMenu.ActiveButton = 1
				end
			elseif key == KEY_UP then
				SOCIOPATHY_PROJECT.Sounds:PlaySound("Keyboard_Move")
				childs_panel.GameMenu.ActiveButton = childs_panel.GameMenu.ActiveButton - 1
				if childs_panel.GameMenu.ActiveVGUI_Buttons[childs_panel.GameMenu.ActiveButton] == nil then
					childs_panel.GameMenu.ActiveButton = #childs_panel.GameMenu.ActiveVGUI_Buttons
				end
			end
		end
		childs_panel.ActiveMenu = childs_panel.GameMenu

		childs_panel.GameMenu.ActiveVGUI_Buttons = {}
		childs_panel.GameMenu.ActiveVGUI_Panels = {}

		childs_panel.GameMenu.SecondaryVGUI = {}
		childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP = vgui.Create("DLabel", childs_panel.GameMenu)
		childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP:SetText("UP [↑]\nDOWN [↓]\nENTER\n\nTO SELECT")
		childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP:SetFont("SOCIOPATHY_PROJECT_HUDFont")
		childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP:SizeToContents()
		f_AlignBottom(childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP,100)
		f_AlignLeft(childs_panel.GameMenu.SecondaryVGUI.HelpLabel_UP,5)

		

		function childs_panel.GameMenu:CreateMenu(buttons_table, is_back)
			if is_back != true then
				menu_now_tree = #menu_tree+1
				menu_tree[menu_now_tree] = buttons_table
			end

			for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Buttons) do
				v:Remove()
				v = nil
			end
			for k,v in pairs(childs_panel.GameMenu.ActiveVGUI_Panels) do
				if istable(v) or ispanel(v) then
					if v.Remove != nil then
						v:Remove()
					end
				end
				v = nil
			end
			childs_panel.GameMenu.ActiveVGUI_Buttons = {}
			childs_panel.GameMenu.ActiveVGUI_Panels = {}

			childs_panel.GameMenu.ActiveButton = 0

			if buttons_table[0] != nil then
				if buttons_table[0].on_menu_create != nil then
					buttons_table[0].on_menu_create(childs_panel.GameMenu.ActiveVGUI_Panels, childs_panel.GameMenu)
				end
			end

			local add_btns = {}
			for k,v in pairs(buttons_table) do
				if k == 0 then continue end
				add_btns[k] = v
			end
			if menu_now_tree > 1 then
				add_btns[#add_btns+1] = {
					title = "_BACK",
					on_click = function()

						if buttons_table[0] != nil then
							if buttons_table[0].on_menu_remove != nil then
								buttons_table[0].on_menu_remove(childs_panel.GameMenu.ActiveVGUI_Panels, childs_panel.GameMenu)
							end
						end

						local menu_now_tree_ = menu_now_tree - 1
						menu_tree[menu_now_tree] = nil
						menu_now_tree = menu_now_tree - 1
						childs_panel.GameMenu:CreateMenu(menu_tree[menu_now_tree_], true)
						
						return false
					end,
				}
			end

			for k,v in pairs(add_btns) do
				local button = vgui.Create("DPanel", childs_panel.GameMenu)
				f_SetSize(button,500,100)
				button.Hovered = false

				function button:IsActive()
					return self == childs_panel.GameMenu.ActiveVGUI_Buttons[childs_panel.GameMenu.ActiveButton]
				end
				function button:Paint(w,h)
					if self:IsActive() then
						surface.SetDrawColor(Color(255,0,0,100))
						surface.DrawRect(0,0,w,h)
					end
				end
				button.ID = k
				function button:OnClick()
					if v.on_click != nil then
						SOCIOPATHY_PROJECT.Sounds:PlaySound("Menu_Enter")
						local show_sub_menu, reset_menu = v.on_click(childs_panel.GameMenu.ActiveVGUI_Panels, childs_panel.GameMenu, self)
						if show_sub_menu then
							childs_panel.GameMenu:CreateMenu(v.SubButtons, reset_menu)
						end
					end
				end
				function button:SetActive()
					childs_panel.GameMenu.ActiveButton = k
				end
				f_AlignTop(button,120*(k-1)+120)
				button.DLabel = vgui.Create("DLabel", button)
				button.DLabel:SetText(v.title)
				button.DLabel:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
				button.DLabel:SizeToContents()
				button.DLabel:Center()
				button:CenterHorizontal()

				if buttons_table[0] != nil then
					if buttons_table[0].on_button_create != nil then
						buttons_table[0].on_button_create(childs_panel.GameMenu.ActiveVGUI_Panels, button)
					end
				end

				if v.on_create != nil then
					v.on_create(childs_panel.GameMenu.ActiveVGUI_Panels, childs_panel.GameMenu, button)
				end
				

				--[[ local x,y = button:GetPos()
				f_SetPos(button,x+0,y)--]] 

				childs_panel.GameMenu.ActiveVGUI_Buttons[k] = button
			end

			if buttons_table[0] != nil then
				if buttons_table[0].post_menu_create != nil then
					buttons_table[0].post_menu_create(childs_panel.GameMenu.ActiveVGUI_Panels, childs_panel.GameMenu)
				end
			end

			childs_panel.GameMenu.ActiveVGUI_Buttons[1]:SetActive()



		end

		if menu_type == "lose" then
			childs_panel.GameMenu:CreateMenu(childs_panel.GameMenu.EndScreenButtons)
		elseif menu_type == "win" then
			childs_panel.GameMenu:CreateMenu(childs_panel.GameMenu.WinScreenButtons)
		elseif menu_type == "generate" then
			childs_panel.GameMenu:CreateMenu(childs_panel.GameMenu.GenerateScreenButtons)
			
		else
			childs_panel.GameMenu:CreateMenu(childs_panel.GameMenu.SubButtons)
		end
	end


	local _CanInputInsidePanel = false  
	

	if menu_type == nil then
		timer.Simple(1, function()
			childs_panel.Label_1:SetVisible(true)
			SOCIOPATHY_PROJECT.Sounds:PlaySound("StartGame")
			childs_panel.Label_1:SetText("PRESS ENTER TO START")
			childs_panel.Label_1:SizeToContents()
			childs_panel.Label_1:Center()
			def_pos_x, def_pos_y = childs_panel.Label_1:GetPos()
			childs_panel.Label_1:CMove(true)



			childs_panel.Label_2 = vgui.Create("DLabel", childs_panel)
			childs_panel.Label_2:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
			childs_panel.Label_2:SetText("EPILEPSY WARNING")
			childs_panel.Label_2:SizeToContents()
			childs_panel.Label_2:Center()

			local x,y = childs_panel.Label_2:GetPos()
			f_SetPos(childs_panel.Label_2,x,y - 180*GetBased_H(), true)
			_CanInputInsidePanel = true
		end)
	end


	f_SetSize(panel,ScrW(), ScrH(),true)
	panel:Center()
	panel:MakePopup()
	panel:RequestFocus()

	panel:SetKeyBoardInputEnabled(true)

	panel.OnRemove = function()
		childs_panel:Remove()
	end

	function panel:Paint(w,h)
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(Material("materials/kishkixd/objects/intro_tv.png"))
		surface.DrawTexturedRect(0,0,w,h)
	end

	if menu_type != nil then
		childs_panel:ShowMainMenu()
		_CanInputInsidePanel = true
	end
	function panel:OnKeyCodePressed(key)
		if _CanInputInsidePanel then
			if childs_panel.ActiveMenu == nil then 
				if key == KEY_ENTER then
					childs_panel.Label_1:Remove()
					childs_panel.Label_2:Remove()

					childs_panel.Label_1 = vgui.Create("DLabel", childs_panel)
					childs_panel.Label_1:SetFont("SOCIOPATHY_PROJECT_HUDFont_2")
					childs_panel.Label_1:SetText("LOADING GAMEMODE:\n\nKISHKIXD\n\nBy FosterZ")
					childs_panel.Label_1:SizeToContents()
					childs_panel.Label_1:Center()

					_CanInputInsidePanel = false

					SOCIOPATHY_PROJECT.Sounds:PlaySound("Keyboard_Rem")

					timer.Simple(3, function()	
						childs_panel.Label_1:Remove()
						childs_panel:ShowMainMenu()
						_CanInputInsidePanel = true
					end)
				end
			else
				childs_panel.ActiveMenu.OnKeyCodePressed(childs_panel.ActiveMenu, key)
				hook.Call("V_VGUI_OnKeyCodePressed", nil, tonumber(key))
			end
		end
	end
	SOCIOPATHY_PROJECT.VGUI:AddVGUIToRender(panel, false)

	SOCIOPATHY_PROJECT.VGUI:AddVGUIToRender(childs_panel, true)


end



hook.Add( "ScoreboardShow", "SOCIOPATHY_PROJECT_ScoreboardShow", function()
	--SOCIOPATHY_PROJECT.VGUI:ShowMenu("continue")
	local cvar = GetConVar("kishki_render_eff_preset")
	local value = cvar:GetInt()
	value = value + 1
	if value > 10 then
		value = 1
	end
	cvar:SetInt(value)

	LocalPlayer():EmitSound("fosterz/kishkixd/menu_button.mp3")

	return true
end )

hook.Add( "InitPostEntity", "SOCIOPATHY_PROJECT_StartGameModeoNClient", function()	
	SOCIOPATHY_PROJECT.VGUI.ShowMenu()
end )

net.Receive("FosterZ_SendOpenMenu", function()
	SOCIOPATHY_PROJECT.VGUI.ShowMenu()
end)

net.Receive("FosterZ_LoseGame", function()
	SOCIOPATHY_PROJECT.VGUI:ShowMenu("lose")
end)
net.Receive("FosterZ_WinGame", function()
	SOCIOPATHY_PROJECT.VGUI:ShowMenu("win")
end)

concommand.Add("test", function()
	SOCIOPATHY_PROJECT.VGUI:ShowMenu()
end )


net.Receive("SendGenerateMSG", function()
	SOCIOPATHY_PROJECT.VGUI:ShowMenu("generate")
end)