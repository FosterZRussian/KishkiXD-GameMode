AddCSLuaFile()


ENT.Type			= "anim"
ENT.Spawnable		= true


ENT.DrawOnCT = CurTime()

ENT.TexSizeX = 32
ENT.TexSizeY = 32

function ENT:DrawColored()
	
	local inv_id = self:GetNWString("ItemID", "item_emp")
	if SOCIOPATHY_PROJECT.GameLogic.GameItems[inv_id] == nil then return end



	render.SetMaterial(Material("materials/kishkixd/effects/light.png"))
	render.DrawSprite( self:GetPos()+Vector(0,0,self.TexSizeY/2), self.TexSizeX*2, self.TexSizeY*2)

	local item_icon = Material("materials/kishkixd/objects/"..SOCIOPATHY_PROJECT.GameLogic.GameItems[inv_id].MetaData.ItemIcon .. ".png")

	render.SetMaterial(item_icon)
	render.DrawSprite( self:GetPos()+Vector(0,0,self.TexSizeY/2), self.TexSizeX, self.TexSizeY)
	--[[ if LocalPlayer() == nil then return end
	if CurTime() > self.DrawOnCT then return end

	

	local pos = self:GetPos()
	local draw_tb = pos:ToScreen()



	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(item_icon)
	local distance = pos:Distance(LocalPlayer():GetPos())
	local size = distance / 32
	local size_y = 2500 / size
	
	surface.DrawTexturedRect(draw_tb.x-size_y/2,draw_tb.y-size_y/2,size_y,size_y)--]] 
end	


function ENT:DrawModel()
end



function ENT:Draw(direct_Draw)


	self.DrawOnCT = CurTime() + 0.01
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 0
		dlight.g = 0
		dlight.b = 255
		dlight.brightness = 2
		dlight.Decay = 1000
		dlight.Size = 256
		dlight.DieTime = CurTime() + 1
	end



	--if 1 == 1 then return end
	--self.DrawOnCT = CurTime()



	
	--[[ local item_icon = Material("materials/kishkixd/objects/"..SOCIOPATHY_PROJECT.GameLogic.GameItems[inv_id].MetaData.ItemIcon .. ".png")
	local eye_ang = LocalPlayer():EyeAngles()
	

	local rt = SOCIOPATHY_PROJECT.Render.RT["RT_COLORED_ENTITIES"]
	render.PushRenderTarget(rt) 

		render.OverrideAlphaWriteEnable(true, true)

		cam.Start3D2D( self:GetPos(), Angle(0,eye_ang.y - 90,90) ,2 )		
			
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(item_icon)
			surface.DrawTexturedRect(-16/2,-16,16,16)	
		cam.End3D2D() 
		render.OverrideAlphaWriteEnable( false, false )
	render.PopRenderTarget()--]] 
end

function ENT:Touch(ent)
end

function ENT:Initialize()
	self:SetCollisionBounds(Vector(-16,-16,0), Vector(16,16,32))
	self:SetNoDraw(true)
	if CLIENT then
	else
		self:SetMoveType(MOVETYPE_FLYGRAVITY)
		self:SetSolid(SOLID_VPHYSICS)
		self:AddSolidFlags(FSOLID_NOT_STANDABLE)
		--self:SetCollisionGroup(1)

		self:SetTrigger(true)
		self:UseTriggerBounds(true, 1)
		--self:InitializeSV()
	end
end