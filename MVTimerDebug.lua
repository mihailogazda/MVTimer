-- 	Debug Functionality
--	

function MVTimer.d(message)
	if MVTimer.debugEnabled then
		d("MVTimer: " .. message)
	end
end

function MVTimer.toggleDebugMode()
	MVTimer.debugEnabled =  not MVTimer.debugEnabled
end


-- add slash commands
SLASH_COMMANDS["/mvtimer"] = function(extra) 
	MVTimer:Introduce(extra)
end

SLASH_COMMANDS["/mvtoggle"] = function(extra)
	MVTimer.toggleDebugMode()
end