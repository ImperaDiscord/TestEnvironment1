RegisterCommand("id", function()
	local user = GetPlayerIdentifiers(source)

	TriggerEvent('chat:addMessage', {
		color = {255, 255, 255},
		multiline = true,
		args = {"Friendly System Message", 'Hey this shit is trying to run, can you run?'}
		})

	TriggerEvent('chat:addMessage', {
		color = {255, 255, 255},
		multiline = false,
		args = {'Friendly System Message', user} -- This used to ask for  "GetPlayerIdentifiers(source) as an arg"
		})
end, false)

RegisterCommand("idd", function()
		TriggerEvent('chatMessage', 'Friendly System Message', {0, 0, 204}, "Ayo nice")
end, false)


RegisterCommand("idalt", function()
	msg("[Colorful!! WOW!]", "This is just shit, but someday it will display an ID. Someday.")
	msg("[Colorful!! WOW!]", "Under this message, I want the player Source to appear")
	--msg(tostring(GetPlayerIdentifiers(source))
	msg("=ID=", tostring(source))
    	msg("The id is" + "so cool man" + source)


	for k,v in pairs(GetPlayerIdentifiers(source))do
    	msg("huh")
        
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamid = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xbl  = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			ip = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		end
      msg("Exited the loop")
    
  end	
	
end, false)


function msg(author, text)
	TriggerEvent('chatMessage', author, {255, 0, 0}, text)
end



--[[ # I was trying to make a special function that accepts infinite arguments
	 # so we can use it for debugging, like we could write lua code
	 # 		msg("Hi my name is ", characterName, ". My gang is ", ourUniqueGangAffiliationVariable, ".")
	 # and it might output like: Hi my name is Carlos. My gang is The Vagos.
function msg(...)
	local finalmsg = ""
	for i,v in ipairs(arg) do
		finalmsg = finalmsg .. tostring(v) .. 
	TriggerEvent('chatMessage', '[Scott is good coder!]', {255, 0, 0}, finalmsg)
end--]]