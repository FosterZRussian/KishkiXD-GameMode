include("shared.lua")






function ENT:RunBehaviour()	
	if self.ClassSetuped then
		self.ClassConfig.SystemMethods.CallMethod("LogicMethods" , "OnRunBehaviour", nil, self.ClassConfig)	
	end

end	
