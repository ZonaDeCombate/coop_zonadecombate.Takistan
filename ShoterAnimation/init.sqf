#include "define.sqf"
waituntil {!isnil "bis_fnc_init"};

//Public variables to modify for mission makers
ShoterAnimation_EnableErrorMessages = false;
ShoterAnimation_EnableWarnings = false;
DEBUG = false;
//End of touchable region

#ifndef ADDON_VERSION
//Do not touch please?
INIT_FNC(ShoterAnimation_fnc_Message, "Message.sqf");
//INIT_FNC(ShoterAnimation_fnc_Update, "Update.sqf"); Po co to kurwa jest?
INIT_FNC(ShoterAnimation_fnc_Loop, "Loop.sqf");
INIT_FNC(ShoterAnimation_fnc_StringInArray, "StringInArray.sqf");
INIT_FNC(ShoterAnimation_fnc_EndAnimation, "endAnimation.sqf");
#endif
ShoterAnimation_InitCompleted = true;
BRUTE_STOP = false;


["ShoterAnimation init Completed", "WaRnInG"] call ShoterAnimation_fnc_Message;