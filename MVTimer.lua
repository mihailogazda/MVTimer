-- Main application logic
--

MVTimer = {}
MVTimer.name = "MVTimer"
MVTimer.player = "Player"
MVTimer.debugEnabled = true

-- enum
local KEY_BUFF_1, KEY_BUFF_2, KEY_BUFF_3, KEY_TIMER = 0, 1, 2, 3

-- Register keybindings
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_1", "MVTimer Buff 1 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_2", "MVTimer Buff 2 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_3", "MVTimer Buff 3 Key")
ZO_CreateStringId("SI_BINDING_NAME_ACTIVATE_POWERUP_4", "MVTimer Timer Key")


function MVTimer:Introduce(extra)
	MVTimer.d("MalaVrazica Buffs Timer 1.0.0")
end

function MVTimer:HandleInitialize()
	
end

function MVTimer.HandleKeyDown(key)
	MVTimer.d("Down " .. tostring(key))
end

function MVTimer.HandleKeyUp(key)
	MVTimer.d("Up " .. tostring(key))
end

function MVTimer:Update()
	
end
