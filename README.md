MVTimer
=======

Elders Scrolls Online Addon for buffs tracking made with love for my wife.

###Settings
To update text on bars and duration of each buff just open **MVTimerSettings.lua** (any text editor will do).

Text keys bellow are names for each energy bar, and time is how long the buff is active, so just update those keys, call /reloadui from chat window and you are done.

'''lua

MVTimerSettings[KEY_BUFF_X].text = "This is buff 1"
MVTimerSettings[KEY_BUFF_X].duration = 30

'''
