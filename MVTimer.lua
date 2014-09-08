-- Main application logic
--

--	Our main object
MVTimer = {}
MVTimer.name = "MVTimer"
MVTimer.player = "Player"
MVTimer.debugEnabled = true
MVTimer.initialized = false
MVTimer.ui = {}


-- enums
local KEY_BUFF_1, KEY_BUFF_2, KEY_BUFF_3, KEY_TIMER = 1, 2, 3, 4
local STATE_DISABLED, STATE_ENABLED = 1, 2

--	Timer prefix
local TIMER_PREFIX = "Timer:  " 

-- Register keybindings
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_1", "MVTimer Buff 1 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_2", "MVTimer Buff 2 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_3", "MVTimer Buff 3 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_4", "MVTimer Timer Key")


function MVTimer:Introduce(extra)
	--	simple bragg output
	d("MalaVrazica Buffs Timer 1.0.0")
end

function MVTimer:InitializeUIMap()

	--	Form array of UI objects for easier accessing 
	
	MVTimer.ui[KEY_BUFF_1] = {}
	MVTimer.ui[KEY_BUFF_1].bar = MVTimerControlUIStatusBar1
	MVTimer.ui[KEY_BUFF_1].text = MVTimerControlUIStatusText1
	MVTimer.ui[KEY_BUFF_1].state = STATE_DISABLED
	
	MVTimer.ui[KEY_BUFF_2] = {}
	MVTimer.ui[KEY_BUFF_2].bar = MVTimerControlUIStatusBar2
	MVTimer.ui[KEY_BUFF_2].text = MVTimerControlUIStatusText2
	MVTimer.ui[KEY_BUFF_2].state = STATE_DISABLED
	
	MVTimer.ui[KEY_BUFF_3] = {}
	MVTimer.ui[KEY_BUFF_3].bar = MVTimerControlUIStatusBar3
	MVTimer.ui[KEY_BUFF_3].text = MVTimerControlUIStatusText3
	MVTimer.ui[KEY_BUFF_3].state = STATE_DISABLED
	
	MVTimer.ui[KEY_TIMER] = {}
	MVTimer.ui[KEY_TIMER].bar = nil
	MVTimer.ui[KEY_TIMER].text = MVTimerControlUIStatusTimerText
	MVTimer.ui[KEY_TIMER].state = STATE_DISABLED
	MVTimer.ui[KEY_TIMER].value = 0

end

function MVTimer:InitializeUIValues()
	
	-- load position
	-- MVTimerSavedVariables
	
	-- Setup default UI text
	MVTimer.ui[KEY_TIMER].text:SetText(TIMER_PREFIX .. "0s")
	
	
	--	saved variables
	MVTimer.savedVariables = ZO_SavedVars:New("MVTimerSavedVariables", 1, nil, {})
	local left = MVTimer.savedVariables.left
	local top = MVTimer.savedVariables.top
 
	MVTimerControlUI:ClearAnchors()
	MVTimerControlUI:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
	
end

function MVTimer:OnIndicatorMoveStop()
	--	save position of object 
	MVTimer.d("Move stoped")
	
	MVTimer.savedVariables.left = MVTimerControlUI:GetLeft()
	MVTimer.savedVariables.top = MVTimerControlUI:GetTop()
	
end

function MVTimer:HandleInitialize()
	
	--	various initialization routines
	MVTimer:InitializeUIMap()
	MVTimer:InitializeUIValues()
	
	--	claim OK
	MVTimer.initialized = true
	
end

function MVTimer.HandleKeyDown(key)

	MVTimer.d("Down " .. tostring(key))	
	
end

function MVTimer.HandleKeyUp(key)
	MVTimer.d("Up " .. tostring(key))
	
	--	get object from key ID
	local object = MVTimer.ui[key]
	
	--	 check if already active
	if object.bar then
		object.bar:SetValue(100)
	end
	
	--	check timer state
	if key == KEY_TIMER then
		if object.state == STATE_DISABLED then
			object.value = 0
			object.state = STATE_ENABLED
		else
			object.state = STATE_DISABLED
		end
	end
	
end

function MVTimer:Update()
	
	if not MVTimer.initialized then end
	
	local delta = GetFrameDeltaTimeSeconds()
	
	--	Update timer
	local timer = MVTimer.ui[KEY_TIMER]
	if timer then 
		if timer.state == STATE_ENABLED then
			timer.value = timer.value + delta
			timer.text:SetText(TIMER_PREFIX .. string.format("%0.2fs", timer.value))
		end
	end
	
end
