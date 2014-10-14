-- Main application logic
--

--	Our main object
MVTimer = {}
MVTimer.name = "MVTimer"
MVTimer.player = "Player"
MVTimer.debugEnabled = false
MVTimer.initialized = false
MVTimer.ui = {}


-- enums and globals
KEY_TIMER_START, KEY_TIMER_STOP = 1, 2
local STATE_DISABLED, STATE_ENABLED = 1, 2
local DISABLED_ALPHA_TEXT, ENABLED_ALPHA_TEXT = 0, 1

-- Register keybindings
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_TIMER", "MVTimer Start timer / reset")
ZO_CreateStringId("SI_BINDING_NAME_DISABLE_TIMER", "MVTimer Hide timer")

function MVTimer:Introduce(extra)
	--	simple bragg output
	d("MalaVrazica Buffs Timer 1.2.0")
end

function MVTimer:InitializeUIMap()
	--	Form array of UI objects for easier accessing 
	MVTimer.ui.bar = nil
	MVTimer.ui.text = MVTimerControlUIStatusTimerText
	MVTimer.ui.state = STATE_DISABLED
	MVTimer.ui.value = 0
end

function MVTimer:InitializeUIValues()
	-- load position
	-- MVTimerSavedVariables
	
	-- Setup default UI text
	MVTimer.ui.text:SetText("00:00:00")
	MVTimer.ui.text:SetAlpha(DISABLED_ALPHA_TEXT)
	
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
	
	--	check timer state
	if key == KEY_TIMER_START then
		if MVTimer.ui.state == STATE_DISABLED then
			MVTimer.ui.value = 0
			MVTimer.ui.state = STATE_ENABLED
			MVTimer.ui.text:SetAlpha(ENABLED_ALPHA_TEXT)
		else
			MVTimer.ui.value = 0
		end
	else
	--	hide 
		MVTimer.ui.state = STATE_DISABLED
		MVTimer.ui.text:SetAlpha(DISABLED_ALPHA_TEXT)
	end
end

function MVTimer:GetTimeShort(s)
	--return string.format("%.2d:%.2d:%.2d", s/(60*60), s/60%60, s%60)
	
	local val = ""
	local hours = s/(60*60)
	local minutes = s/60%60
	local seconds = s%60
	
	if hours >= 1 then
		val = string.format("%.2d:", hours)
	end
	if minutes >= 1 then
		val = val .. string.format("%.2d:", minutes)
	end	
	
	val = val .. string.format("%.2d", seconds)
	
	return val
end

function MVTimer:Update()
	if not MVTimer.initialized then end
	
	local delta = GetFrameDeltaTimeSeconds()
	
	--	Update timer
	if MVTimer.ui.state == STATE_ENABLED then
		MVTimer.ui.value = MVTimer.ui.value + delta
		MVTimer.ui.text:SetText(MVTimer:GetTimeShort(MVTimer.ui.value))
	end
end
