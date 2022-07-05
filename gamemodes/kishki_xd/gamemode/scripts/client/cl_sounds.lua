
AddCSLuaFile()
SOCIOPATHY_PROJECT.Sounds = {}
SOCIOPATHY_PROJECT.Sounds.List = {}
include("cl_sounds_list.lua")




SOCIOPATHY_PROJECT.Sounds._BGMSound = SOCIOPATHY_PROJECT.Sounds._BGMSound or nil

function SOCIOPATHY_PROJECT.Sounds:PlaySound(table_d, ply)

	if ply == nil && SERVER then return end



	local snd_data = SOCIOPATHY_PROJECT.Sounds.List[table_d]

	if isvector(ply) then
		sound.Play( "fosterz/kishkixd/" .. snd_data.path, ply, 100, snd_data.pitch, snd_data.volume )
	else
		ply = ply or LocalPlayer()
		ply:EmitSound( "fosterz/kishkixd/" .. snd_data.path , 0, snd_data.pitch or 100, snd_data.volume or 1)
	end
end






function SOCIOPATHY_PROJECT.Sounds:HideSound(fsound)
	if fsound == nil then return end
	local channel = SOCIOPATHY_PROJECT.Sounds.List[fsound].channel
	if channel == nil then
		channel = CHAN_AUTO
	end
	timer.Simple(0, function()
		LocalPlayer():EmitSound( "fosterz/kishkixd/" .. SOCIOPATHY_PROJECT.Sounds.List[fsound].path, 0, 100, 0, channel)
		LocalPlayer():StopSound( "fosterz/kishkixd/" .. SOCIOPATHY_PROJECT.Sounds.List[fsound].path)
	end)
end

function SOCIOPATHY_PROJECT.Sounds:GetSoundPath(fsound)
	return SOCIOPATHY_PROJECT.Sounds.List[fsound].duration or SoundDuration(SOCIOPATHY_PROJECT.Sounds.List[fsound].path)
end

function SOCIOPATHY_PROJECT.Sounds:StopBGMSound()
	if timer.Exists("bgm_snd_timer") then
		timer.Remove("bgm_snd_timer")
		SOCIOPATHY_PROJECT.Sounds:HideSound(SOCIOPATHY_PROJECT.Sounds._BGMSound)
	end
	SOCIOPATHY_PROJECT.Sounds._BGMSound = nil
	

end	

function SOCIOPATHY_PROJECT.Sounds:PlayBGMSound(sound, dontskip)
	
	if dontskip != true && sound == SOCIOPATHY_PROJECT.Sounds._BGMSound then return end

	SOCIOPATHY_PROJECT.Sounds:StopBGMSound()
	

	
	
	SOCIOPATHY_PROJECT.Sounds._BGMSound = sound
	SOCIOPATHY_PROJECT.Sounds:PlaySound(sound)
	local time = SOCIOPATHY_PROJECT.Sounds:GetSoundPath(sound)
	timer.Create("bgm_snd_timer", time, 0, function()
		SOCIOPATHY_PROJECT.Sounds:PlaySound(sound)
	end)	
	
	
end	



SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound = {

}


function SOCIOPATHY_PROJECT.Sounds:ClearAll_ControlledBGMSound()
	for k,v in pairs(SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound) do
		timer.Remove("bgm_snd_timer" .. k)
		SOCIOPATHY_PROJECT.Sounds:HideSound(k)
	end

end
function SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(str, dont_skip_sound)
	--print(SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str])
	--if SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str] == nil then return end

	local dist = SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str]
	if dist != nil then
		if CurTime() < dist then
			return
		end
	end
	if timer.Exists("bgm_snd_timer" .. str) then
		timer.Remove("bgm_snd_timer" .. str)
		if dont_skip_sound != true then
			SOCIOPATHY_PROJECT.Sounds:HideSound(str)
		end
		SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str] = nil
	end

end	

function SOCIOPATHY_PROJECT.Sounds:Play_ControlledBGMSound(str, min_dist)

	
	if SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str] != nil then return end

	SOCIOPATHY_PROJECT.Sounds:Stop_ControlledBGMSound(str)
	
	SOCIOPATHY_PROJECT.Sounds.ControlledBGMSound[str] = CurTime() + (min_dist or 0)

	SOCIOPATHY_PROJECT.Sounds:PlaySound(str)

	local time = SOCIOPATHY_PROJECT.Sounds:GetSoundPath(str)

	timer.Create("bgm_snd_timer" .. str, time, 0, function()
		SOCIOPATHY_PROJECT.Sounds:PlaySound(str)
	end)	
	
end	
