--	Handling events 
--	

--	Addon was loaded
function MVTimer.OnAddonLoaded(eventCode, addonName)
	--if (MVTimer.name ~= addOnName) then return end
	
	--	do initialization
	MVTimer:HandleInitialize()
	
	-- we are loaded, disable the event
	EVENT_MANAGER:UnregisterForEvent(MVTimer.name, EVENT_ADD_ON_LOADED)
end

-- Loaded event
EVENT_MANAGER:RegisterForEvent(MVTimer.name, EVENT_ADD_ON_LOADED, MVTimer.OnAddonLoaded)
