#include "define.sqf"
private ["_object", "_animationType", "_animation"];

WAIT_FOR_INIT;
sleep random 0.3;
_object = [_this, 0, objNull, [objNull]] call Bis_fnc_param;



_animations = _object getVariable "ShoterAnimation_var_animations";
_stopAnimation = false;
_animationPhase = 0;
_phases = (count _animations) - 2;
_doAnimation = (_object getVariable "ShoterAnimation_var_animEnded") isEqualTo false;

if(([animationState _object, _animations, _phases] call ShoterAnimation_fnc_StringInArray)) then
	{
		//replay current animation
		_doAnimation = true;
	};


if (alive _object) then
{
	if(_doAnimation) then
		{
			if(DEBUG) then
			{
				_animType = _object getVariable "ShoterAnimation_deb_animationType";
				if(tolower _animType isEqualTo "talk") then
				{
					player globalChat _animType;
				};
			};
			if(typeName END_MOVE isEqualTo "STRING") then
			{_object switchMove END_MOVE;}
			else
			{
				//CODE Here
				[_object] call END_MOVE;
			};
		};
}
else
{
	if(_doAnimation) then
		{
			if(typeName DEAD_MOVE isEqualTo "STRING") then
			{_object switchMove DEAD_MOVE;}
			else
			{
				//CODE Here
				[_object] call DEAD_MOVE;
			};
		};
};

{_object enableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"] ;

if(isServer) then
{
	_object setVariable ["ShoterAnimation_var_animEnded", true, true];
} else
{
	_object setVariable ["ShoterAnimation_var_animEnded", true, false];
};
