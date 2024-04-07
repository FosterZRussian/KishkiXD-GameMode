local ItemConfig = SOCIOPATHY_PROJECT.GameLogic:GetBaseItemTable()
ItemConfig.ItemData.SystemName = "item_sonar"

if SERVER then
	SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("default").ItemsSpawnList["item_sonar"] = true -- add this item to base gamemode whitelist
end

ItemConfig.MetaData.ItemIcon = "sonar/icon"

ItemConfig.ItemData.CanBeUsedAsSlotItem = true



ItemConfig.MetaData.ItemName = "Sonar Device Ultra"
ItemConfig.MetaData.ItemDescription = "Allows you to scan the area using echolocation.\nMay be detrimental to health."


SOCIOPATHY_PROJECT.Sounds.List['addon_sonar_sonarPingAirClose1'] = {
	path = "addon_sonarium/base_sonarium/sonarPingAirClose1.mp3",
	volume = 1,
	pitch = 100,
}
SOCIOPATHY_PROJECT.Sounds.List['addon_sonar_sonarPingAirClose2'] = {
	path = "addon_sonarium/base_sonarium/sonarPingAirClose2.mp3",
	volume = 1,
	pitch = 100,
}
SOCIOPATHY_PROJECT.Sounds.List['addon_sonar_sonarPingAirFar1'] = {
	path = "addon_sonarium/base_sonarium/sonarPingAirFar1.mp3",
	volume = 1,
	pitch = 100,
}
SOCIOPATHY_PROJECT.Sounds.List['addon_sonar_sonarPingAirFar2'] = {
	path = "addon_sonarium/base_sonarium/sonarPingAirFar2.mp3",
	volume = 1,
	pitch = 100,
}
SOCIOPATHY_PROJECT.Sounds.List['addon_sonar_powerDown'] = {
	path = "addon_sonarium/base_sonarium/powerDown.mp3",
	volume = 1,
	pitch = 100,
}

ItemConfig.ItemData.SystemValues.LogicTables['ItemLogic'] = {
	_LastDrawCT = 0,
	_LastAnim = 1,
	_MaxAnim = 4,
	_IsEnabled = true,

	_CurrentAngle = 0,
	_DrawPoints = {},

	_SonarActiveMode = true,
	_SonarEnabled = false,
	_SonarCurrentSndDelay = 0,	
}


ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_FIRST] = function(item_config)
	item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarActiveMode = !item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarActiveMode
		
end


local SelfMeshes = {}

ItemConfig.ItemData.SystemValues.KeyFunctions[MOUSE_RIGHT] = function(item_config)
	
	item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarEnabled = !item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarEnabled

	if CLIENT then
		if !item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarEnabled then
			render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"])
			render.Clear(0,0,0,0)
			render.PopRenderTarget()
			for k,v in pairs(SelfMeshes) do
				v.need_update = true
				v.self_table = {}
			end
		end	
	end
	
	SOCIOPATHY_PROJECT.Sounds:PlaySound("addon_sonar_powerDown")
end



local CLR_INDEX = {
	['hunter'] = Color(255,0,0,255)
}

local SelfMesh

if SelfMesh == nil then
	if CLIENT then
		SelfMesh = Mesh()					
	end	
end


local ang = Angle(0,0,0)

local ActiveMeshID = 1
local ActiveMeshID_ID = 1
local function GetPosPositionOnSonarTex(pos)	
	local dist_vec = Vector(16384,16384,16384) + (pos)
	dist_vec = (dist_vec / 32768) 
	return dist_vec
end


local function InsertVertex(trace, eye_pos, u_eye_ang)--, eye_ang)

	local v_ang = (eye_pos - trace.HitPos):Angle() + Angle(90,0,0)-- eye_ang 

	if ActiveMeshID == 15 then
		ActiveMeshID = 1
	end
	SelfMeshes[ActiveMeshID] = SelfMeshes[ActiveMeshID] or {
		self_mesh = Mesh(),
		self_table = {},
		need_update = true
	}



	local pix_scale = eye_pos:Distance(trace.HitPos) * 0.0075



	local v1 = Vector(0,0,0) 
	v1:Rotate(v_ang)
	local v2 = Vector(10,0,0) 
	v2:Rotate(v_ang)
	local v3 = Vector(10,10,0)
	v3:Rotate(v_ang)


	local dist = trace.HitPos:Distance(eye_pos)


	local a_depth = (300/dist)*255
	local b_depth = dist/25

	local m_color

	if trace.IsForceEnemy then
		m_color = Color(255,0,0,255)
	else
		if trace.HitWorld then
			m_color = Color(0,a_depth,math.Clamp(b_depth, 0, 230),255)
		else
			m_color = Color(a_depth,math.Clamp(b_depth, 0, 230),0,255)	 		
	 	end
	end

	SelfMeshes[ActiveMeshID].self_table[ActiveMeshID_ID] = {
		pos = pix_scale * v1 + trace.HitPos,
		color = m_color,
		u = 0,
		v = 0,
	}
	SelfMeshes[ActiveMeshID].self_table[ActiveMeshID_ID+1] = {
		pos = pix_scale * v2 + trace.HitPos,
		color = m_color,
		u = 0,
		v = .5,
	}
	SelfMeshes[ActiveMeshID].self_table[ActiveMeshID_ID+2] = {
		pos = pix_scale * v3 + trace.HitPos,
		color = m_color,
		u = .5,
		v = .5,
	}

	SelfMeshes[ActiveMeshID].need_update = true

	local dist_vec = GetPosPositionOnSonarTex(trace.HitPos) * 4096

	render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"])
		cam.Start2D()
			if trace.IsForceEnemy then
				surface.SetDrawColor(m_color)
				surface.DrawRect(dist_vec.x-25,dist_vec.y-25,50,50)
			else
				surface.SetDrawColor(Color(math.Clamp(b_depth, 0, 230),a_depth,math.Clamp(b_depth, 0, 230),255))
				surface.DrawRect(dist_vec.x,dist_vec.y,4,4)
			end
		cam.End2D()
	render.PopRenderTarget()

	ActiveMeshID_ID = ActiveMeshID_ID + 3
	if ActiveMeshID_ID >= 3000 then
		ActiveMeshID = ActiveMeshID + 1
		ActiveMeshID_ID = 1
	end


			
end

local last_updated_mesh = 1
local last_updated_mesh_ct = 0
ItemConfig.ItemData.SystemValues.ThinkFunctions["MeshRebuild"] = function(self, item_config)
	if SERVER then return end
	local tb_data = item_config.ItemData.SystemValues.LogicTables['ItemLogic']
	local tb = tb_data._DrawPoints



	local eye_pos = LocalPlayer():EyePos()
	local eye_ang = LocalPlayer():EyeAngles()

	local offset = math.random(-2,2)

	if tb_data._SonarEnabled then

		render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"])
			cam.Start2D()
				surface.SetDrawColor(0,0,0,2)
				surface.DrawRect(0,0,4096,4096)
			cam.End2D()
		render.PopRenderTarget()


		if tb_data._SonarActiveMode then
			
			for i = -4, 9 do
				local trace = util.QuickTrace(eye_pos, Angle(i*2+offset,offset+item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle,0):Forward()*32000, function(ent)
					if ent == LocalPlayer() then return false end					
					return true
				end)	
	

				
				CLR_INDEX[trace.HitTexture] = CLR_INDEX[trace.HitTexture] or Color(math.random(0,255),math.random(0,255),math.random(0,255))
				if trace.Hit && trace.HitSky == false then
					timer.Simple((1+i)*0.01, function()
						InsertVertex(trace, eye_pos, eye_ang)						
					end)		
				end
			end
		else
			for i = -4, 8 do
				local trace = util.QuickTrace(eye_pos, Angle((i+offset)*3,offset+item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle,0):Forward()*32000, function(ent)
					if ent == LocalPlayer() then return false end
					return true
				end)		
				CLR_INDEX[trace.HitTexture] = CLR_INDEX[trace.HitTexture] or Color(math.random(0,255),math.random(0,255),math.random(0,255))

				if trace.Hit && trace.HitSky == false then
					timer.Simple((1+i)*0.01, function()
						InsertVertex(trace, eye_pos, eye_ang)											
					end)		
				end
			end
		end

		item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle = item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle + 3		

		
		if item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle % 180 == 0 then
			
			if tb_data._SonarActiveMode then 
				net.Start("FosterZ_ItemCode")
				net.WriteString("ping")
				net.SendToServer()
				for k,v in pairs(ents.FindInSphere(eye_pos, 300)) do
					if v:GetClass() == "npc_hunter" then
						InsertVertex({
							HitPos = v:GetPos(),
							IsForceEnemy = true,
						}, eye_pos)						
					elseif v:GetClass() == "item_dropped" then
						InsertVertex({
							HitPos = v:GetPos(),
							IsForceEnemy = true,
						}, eye_pos)
					end
				end	

				SOCIOPATHY_PROJECT.Sounds:PlaySound("addon_sonar_sonarPingAirClose" .. math.random(1,2))			
			else
				SOCIOPATHY_PROJECT.Sounds:PlaySound("addon_sonar_sonarPingAirFar" .. math.random(1,2))			
			end
		end			
	end



	local tb_data = item_config.ItemData.SystemValues.LogicTables['ItemLogic']
	local tb = tb_data._DrawPoints


	if CurTime() > last_updated_mesh_ct then
		local _mesh_data = SelfMeshes[last_updated_mesh]		
		if _mesh_data != nil then
			if _mesh_data.need_update then
				_mesh_data.self_mesh:Destroy()
				_mesh_data.self_mesh = Mesh()
				_mesh_data.self_mesh:BuildFromTriangles(_mesh_data.self_table)
				_mesh_data.need_update = false
			end
		end
		last_updated_mesh = last_updated_mesh + 1
		if SelfMeshes[last_updated_mesh] == nil then
			last_updated_mesh = 1
		end
		last_updated_mesh_ct = CurTime() + 0.05
	end
	
end
 

 


local function RenderSonar(item_config)
	
	

	

	local eye_pos = LocalPlayer():EyePos()
	render.CullMode(1)

	render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["VEX_POINT"])
	for k,v in pairs(SelfMeshes) do
		v.self_mesh:Draw()
	end
	render.CullMode(0)
	for k,v in pairs(SelfMeshes) do
		v.self_mesh:Draw()		
	end
	
	--render.DrawSphere( Vector(-37.833241,-1216.316284,-79.968750), 25, 30, 30, Color( 255,0,0, 255 ) )


	
	
	--render.CullMode(1)	
	--[[ --]] 
	--render.CullMode(0)	 
	--[[ render.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["VEX_POINT"])	
	mesh.Begin( MATERIAL_TRIANGLES, #tb ) 
		for k,v in pairs(tb) do

		
			mesh.Position( v.v1 )
			mesh.TexCoord( 0, 0, 0) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 

			mesh.Position( v.v2 )
			mesh.TexCoord( 0, 1, 0 ) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 

			mesh.Position( v.v3 )
			mesh.TexCoord( 0, 1, 1 ) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 
		end		
	mesh.End() 	

	render.CullMode(1)	

	mesh.Begin( MATERIAL_TRIANGLES, #tb ) 
		for k,v in pairs(tb) do
			mesh.Position( v.v1 )
			mesh.TexCoord( 0, 0, 0) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 

			mesh.Position( v.v2 )
			mesh.TexCoord( 0, 1, 0 ) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 

			mesh.Position( v.v3 )
			mesh.TexCoord( 0, 1, 1 ) 
			mesh.Color(0,255,0,255)
			mesh.AdvanceVertex() 
		end		
	mesh.End() 	
	render.CullMode(0)	--]] 

	
	render.PushRenderTarget(SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS"])
		render.Clear(10,30,30,0)	

		render.DrawTextureToScreen (SOCIOPATHY_PROJECT.Render.RT["MAIN_RENDER_FOR_ITEMS_2"])

		cam.Start2D()	
		--[[ surface.SetDrawColor(0,0,0,105)
		surface.DrawRect(0,0,4096,4096)--]] 		


		--[[ for k,v in pairs(item_config.ItemData.SystemValues.LogicTables['ItemLogic']._DrawPoints) do
			local x = (eye_pos.x - v.pos.x) * 1
			local y = (eye_pos.y - v.pos.y) * 1
			
			local b_depth = 255*v.depth
			local a_depth = 255*(1-v.depth)
			surface.SetDrawColor(0,a_depth+b_depth,0,255)

			surface.DrawRect(512+x,512+y,4,4)
		end 	--]] 


		local offsetvec = GetPosPositionOnSonarTex(eye_pos)*4096



		local x,y = SOCIOPATHY_PROJECT.GameLogic:Rotate2DPoint(1,1,LocalPlayer():EyeAngles().y-90+45)

		local cx,cy = offsetvec.x, offsetvec.y


		surface.SetDrawColor(255,255,0,255)
		surface.DrawRect(cx-2048,cy,4096,4)
		surface.DrawRect(cx-10,0,2,4096)


		
		surface.SetDrawColor(255,255,0,255)
		surface.DrawRect(cx+x*100,cy+y*100,25,25)


		x,y = SOCIOPATHY_PROJECT.GameLogic:Rotate2DPoint(1,1,item_config.ItemData.SystemValues.LogicTables['ItemLogic']._CurrentAngle-45)


		surface.SetDrawColor(255,0,0,255)
		surface.DrawRect(cx+x*100,cy+y*100,25,25)

		surface.DrawLine( cx,cy, cx+x*300+1,cy+y*300+1)

	
		cam.End2D()
	render.PopRenderTarget()

	

	--[[ if item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarCurrentDist == 2100 then
		item_config.ItemData.SystemValues.LogicTables['ItemLogic']._SonarCurrentDist = 30
	end--]] 

end


		
ItemConfig.ItemData.SystemFunctions.OnNetCode['ping'] = function(item)
	local ply = item.ItemData.SystemValues.ItemOwner
	local float = ply:GetNWFloat("Game_Stress", 100)
	ply:SetNWFloat("Game_Stress", math.Clamp(float-15,0,100))
end 
function ItemConfig.ItemData.SystemFunctions:ScreenDraw_PreDraw3D(item_config,W,H)	

	

	RenderSonar(item_config)
	--[[ render.SetColorMaterial()	
	SelfMesh:Draw()--]] 

	--[[ if 1 == 1 then return end
	cam.Start2D()
	--render.SetColorMaterial()
	for k,v in pairs(item_config.ItemData.SystemValues.LogicTables['ItemLogic']._DrawPoints) do		

--		render.DrawSprite( v.pos, 5, 4, Color(CLR_INDEX[v.tex].r,CLR_INDEX[v.tex].g,CLR_INDEX[v.tex].b) )

		 local hitpos = v.pos:ToScreen()

		--if !(hitpos.x > 0 && hitpos.x < W && hitpos.y > 0 && hitpos.y < H) then continue end
		--surface.SetDrawColor(0,255*v.depth,0,255)
		local b_depth = 255*v.depth
		local a_depth = 255*(1-v.depth)
		--surface.SetDrawColor(CLR_INDEX[v.tex],a_depth,b_depth,255)
		if v.depth > 1 then
			surface.SetDrawColor(Color(CLR_INDEX[v.tex].r,CLR_INDEX[v.tex].g,CLR_INDEX[v.tex].b))
		else
			surface.SetDrawColor(Color(CLR_INDEX[v.tex].r*v.depth,CLR_INDEX[v.tex].g*v.depth,CLR_INDEX[v.tex].b*v.depth))
		end
		

		surface.DrawRect(hitpos.x,hitpos.y,12,12) 
	end 	
	cam.End2D() --]] 
end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_PreDraw(item_config,W,H)

	
	
end


local offc = .1
function ItemConfig.ItemData.SystemFunctions:ScreenDraw_First(item_config,W,H)

	local att_table = item_config.ItemData.SystemValues.LogicTables['ItemLogic']

	local TexSize = H*1
	local x,y = (W-TexSize/2), item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.3




	surface.SetDrawColor(Color(255,255,255))

	surface.SetMaterial(Material("kishkixd/objects/sonar/base.png"))
	surface.DrawTexturedRectRotated(x,y, TexSize*2,TexSize*1.2, 0)


	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )


	if att_table._SonarEnabled then

		
	

		if att_table._SonarActiveMode then
			surface.SetDrawColor(Color(255,0,0))
		else			
			surface.SetDrawColor(Color(0,255,200))
		end

		surface.SetMaterial(Material("kishkixd/objects/sonar/base_light.png"))
		surface.DrawTexturedRectRotated(x,y, TexSize*2,TexSize*1.2, 0)
	end

	local x,y = (W-TexSize/2)-TexSize*0.4, item_config.ItemData.SystemValues.LogicTables.VisualMoving._LastRenderYPos*(H*.025) + H-TexSize*0.52






	local offsetvec = GetPosPositionOnSonarTex(LocalPlayer():EyePos())

	
	surface.SetMaterial(SOCIOPATHY_PROJECT.Render.MAT["MAIN_RENDER_FOR_ITEMS"])
	

	surface.DrawTexturedRectUV(x,y, TexSize*0.65,TexSize*0.375, offsetvec.x-offc,offsetvec.y-offc,offsetvec.x+offc,offsetvec.y+offc)

	if att_table._SonarEnabled then
		if att_table._SonarActiveMode then
			surface.SetTextColor(Color(255,0,0))
		else
			surface.SetTextColor(Color(0,255,200))
		end
	else
		surface.SetTextColor( 255, 255, 255, 50 )
	end
	surface.SetTextPos( x,y ) 
	if att_table._SonarActiveMode then
		surface.DrawText( "ACV" )
	else
		surface.DrawText( "PSV" )
	end





end

function ItemConfig.ItemData.SystemFunctions:ScreenDraw_UI(item_config,W,H)
	surface.SetFont( "SOCIOPATHY_PROJECT_HUDFont" )
	surface.SetTextColor( 255, 255, 255, 50 )
	surface.SetTextPos( W-300, H-100 ) 
	surface.DrawText( "[MOUSE 1/2]" )
end

SOCIOPATHY_PROJECT.GameLogic:RegisterItem(ItemConfig)