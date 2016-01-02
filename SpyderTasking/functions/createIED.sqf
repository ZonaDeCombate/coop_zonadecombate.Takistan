private ["_iedModel"];
params ["_location"];

//-- Change IED model based on if it's on a road or not
if (isOnRoad _location) then {
	_IEDModel = ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo"] call BIS_fnc_selectRandom;
} else {
	_IEDModel =["ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo"] call BIS_fnc_selectRandom;
};

//-- Create IED
_IED = _IEDModel createVehicle _location;
[_IED] spawn ST_fnc_armIED; //-- [_IED, typeOf _IED] call ALIVE_fnc_armIED;

_IED;