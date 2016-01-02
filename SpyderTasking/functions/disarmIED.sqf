//-- Only execute on server
if (!isServer) exitWith {
	[_this,{_this spawn ST_fnc_disarmIED},"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
};

params ["_IED"];

//-- Delete IED and it's triggers
{
	deleteVehicle _x;
} forEach [(_IED getVariable "ST_NonSpecialistTrigger"),(_IED getVariable "ST_SpecialistTrigger"),_IED];