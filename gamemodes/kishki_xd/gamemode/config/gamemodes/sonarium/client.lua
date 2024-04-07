local GameModeTable = SOCIOPATHY_PROJECT.CONFIG.GAMEMODES:GetGameModeTable("sonarium")

function GameModeTable:PreDraw3D()
	render.CullMode(1)
	render.SetColorMaterial()

	local eye_pos = LocalPlayer():EyePos()

	for i = 0, 10 do
		render.DrawSphere(eye_pos, 110-i*2, 30, 3, Color( 0, 0, 0, 255-i*10) )	
	end
		
	render.CullMode(0)
end