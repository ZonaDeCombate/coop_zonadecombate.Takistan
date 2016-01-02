#include "define.sqf"
private ["_object", "_stopAnimation", "_animations", "_stopAnimation", "_animationPhase", "_phases"];

WAIT_FOR_INIT;

_object = [_this, 0, objNull, [objNull,[]]] call Bis_fnc_param;


_animations = _object getVariable "ShoterAnimation_var_animations";
_stopAnimation = false;
_animationPhase = 0;
_phases = (count _animations) - 2;


while {_stopAnimation isEqualTo false} do {

if (behaviour _object == "COMBAT" or !alive _object or (getDammage _object)  > 0 or (_object getVariable "ShoterAnimation_var_animEnded") isEqualTo true)  exitWith {true;};

	if(!([animationState _object, _animations] call ShoterAnimation_fnc_StringInArray)) then
		{
			//replay current animation
			_object switchMove CURRENT_MOVE;
		};

if(_object getVariable "ShoterAnimation_var_animDone") then
		{
			if(_animationPhase isEqualTo 0) then
			{
				_object setPos (_object getVariable "ShoterAnimation_var_startingPosition");
			};
			NEXT_MOVE;
			_object switchMove CURRENT_MOVE;
			_object setVariable ["ShoterAnimation_var_animDone", false, false];
		};



		if(DEBUG) then
			{
				_animType = _object getVariable "ShoterAnimation_deb_animationType";
				if(tolower _animType isEqualTo "patrol") then
				{
					player globalChat format ["%1%2",getDir _object];
				};
			};

	if(BRUTE_STOP isEqualTo true) exitWith
	{
		//TODO INSERT HERE SOME KIND OF ACTION TO STOP SOLDIER REGARDLESS ANYTHING. Maybe in future :DD
	};


    sleep 1;
};

[_object] call ShoterAnimation_fnc_EndAnimation;

