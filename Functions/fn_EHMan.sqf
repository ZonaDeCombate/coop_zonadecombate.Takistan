//-- Only run on server
if (!isServer) exitWith {};

params ["_unit"];

if !(_unit isKindOf "Man") exitWith {};

if ((toLower str (side _unit)) == "guer") then {
	//-- Only attach to squadleaders
	if ((leader (group _unit)) == _unit) then {
		//-- 45% chance
		if (random 100 <= 45) then {
			_unit addEventHandler ["Killed", {_this call Spyder_fnc_intelDrop}];
		};
	};
};

if (side _unit == civilian) then {
	//-- Add interact action
	[[[_unit],{
		if (hasInterface) then {
			params ["_unit"];
			_unit addAction ["interagir", "['openMenu', [_this select 0]] call SCI_fnc_civilianInteraction", "", 50, true, false, "", "alive _target"];
		};
	}],"BIS_fnc_spawn",true] call BIS_fnc_MP;

/*
	//-- Check if civ has a role
	private ["_role"];
	{
		if (_unit getvariable [_x,false]) then {
			_role = _x
		};
	} foreach ["townelder","major","priest","muezzin","politician"];

	//-- Redress civ if he has a role
	if (!isNil "_role") then {[_unit,_role] execVM "Scripts\redressCivilian.sqf"};
*/
};