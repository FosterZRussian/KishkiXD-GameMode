AddCSLuaFile()



ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true



ENT.ClassConfig = ENT.ClassConfig or {}
ENT.ClassSetuped = false
ENT.CachedClass = nil

function ENT:SetupLogicTable(monster_class)
	self.CachedClass = monster_class
	if SERVER then
		self:SetNWString("monster_class", monster_class)
	end
	self.ClassConfig = table.Copy(SOCIOPATHY_PROJECT.GameLogic.GameMonsters[monster_class].ItemData.SystemValues)
	self.ClassConfig.Entity = self
	self:OnInitialize()
	self.ClassSetuped = true
	self:DrawShadow(false)
end

if CLIENT then
	net.Receive("FosterZ_InitMonster", function(len,pl)
		local ent = net.ReadEntity()
		ent:SetupLogicTable(net.ReadString())
	end)
end

function ENT:OnInitialize() -- init after sv setup
	self.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnSpawn", nil, self.ClassConfig)
	self.RenderOverride = function()
	end
end

function ENT:Think()
	
		
	if self.ClassSetuped then
		self.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnLogicFrame", nil, self.ClassConfig)
	else
		local class = self:GetNWString("monster_class", "")
		if class != "" then
			self:SetupLogicTable(class)
		end
	end
end

function ENT:DrawModel()
	return
end

function ENT:DrawTranslucent()

end

function ENT:Draw()
	if self.ClassSetuped then
		self.ClassConfig.SystemMethods.CallMethod("RenderMethods" , "OnWorldDraw", nil, self.ClassConfig)	
	end
	return true
end

