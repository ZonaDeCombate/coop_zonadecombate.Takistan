#include "define.sqf"
private ["_object", "_animationType", "_animation"];

WAIT_FOR_INIT;

_object = [_this, 0, objNull, [objNull]] call Bis_fnc_param;
_animationType = [_this, 1, "", [""]] call Bis_fnc_param;
_parameters = [_this, 2, [], ["",[]]] call Bis_fnc_param;

_canInit = true;
_animEnded = _object getVariable "ShoterAnimation_var_animEnded";
if((isNil ("_animEnded")) isEqualTo false) then
{
	_canInit = (_object getVariable "ShoterAnimation_var_animEnded") isEqualTo false;
};

if(_canInit) then
{
	if(_object isEqualTo objNull OR _animationType isEqualTo "") then
		{
			["Error in ShoterAnimation. Wrong Parameters", "error"] call ShoterAnimation_fnc_Message;
		}
	else
		{
			_animation = LOAD_ANIMATION(_animationType);

			_object setVariable ["ShoterAnimation_var_animations", _animation, false];

			{_object disableAI _x} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"] ;

			_object playMoveNow (_animation select 0);
			_object setVariable ["ShoterAnimation_var_animDone", false, false];
			_object setVariable ["ShoterAnimation_var_animEnded", false, false];
			_object setVariable ["ShoterAnimation_var_startingPosition", position _object, false];

			_object addEventHandler ["AnimDone",
				{
					(_this select 0) setVariable ["ShoterAnimation_var_animDone", true, false];
				}
			];

			_object addEventHandler ["killed",
				{
					[(_this select 0)] spawn ShoterAnimation_fnc_EndAnimation;
				}
			];

			_object addEventHandler ["Hit",
				{
					[(_this select 0)] spawn ShoterAnimation_fnc_EndAnimation;
				}
			];

			_object addEventHandler ["FiredNear",
				{
					_unit = _this select 0;
					_firer = _this select 1;
					if(!(side _unit isEqualTo side _firer)) then
					{
						[_unit] spawn ShoterAnimation_fnc_EndAnimation;
					};
				}
			];

			[_object] spawn ShoterAnimation_fnc_Loop;


			if(DEBUG) then
			{
				_object addAction ["KILL", {(_this select 0) setDamage 1}];
				_object setVariable ["ShoterAnimation_deb_animationType", _animationType, false];
			};
		};
};