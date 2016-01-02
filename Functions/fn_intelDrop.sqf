//-- Only run on server
if (!isServer) exitWith {};

params ["_unit"];
if (_unit getVariable "intelSpawned") exitWith {};
_unit setVariable ["intelSpawned", true];

//-- Select random intel item
_intel = ["Land_HandyCam_F","Land_SatellitePhone_F","Land_Suitcase_F","Land_Ground_sheet_folded_OPFOR_F","Land_Laptop_unfolded_F"] call BIS_fnc_selectRandom;

//-- Spawn intel
_intelItem = _intel createVehicle position _unit;
_intelItem setPosATL (getPosATL _unit);

{
	if !(_x == _intelItem) then {
		deleteVehicle _x;
	};
} forEach (nearestObjects [player, ["Land_HandyCam_F","Land_SatellitePhone_F","Land_Suitcase_F","Land_Ground_sheet_folded_OPFOR_F","Land_Laptop_unfolded_F"], 10]);


//-- Add action to pickup intel
_intelItem addAction ["Pegar Intel","[_this select 0] spawn Spyder_fnc_showIntel"];


//-- Execute on server
[[_intelItem,{
	if (hasInterface) then {
		_this addAction ["Pegar Intel","openMap true;[_this select 0] spawn Spyder_fnc_showIntel"];
	};
}],"BIS_fnc_spawn",true] call BIS_fnc_MP;