/////////////////////////////////////////////////////////////////////////////////////////////-- Input Vehicle Classnames Here -- /////////////////////////////////////////////////////////////////////////////////////////////
//-- Define vehicles
_vehicles = ["rhsusf_m1025_d_m2","rhsusf_m1025_d_Mk19","rhsusf_m1025_d","rhsusf_m113d_usarmy","RHS_M2A2_BUSKI","RHS_M6","rhsusf_rg33_d","rhsusf_rg33_m2_d","rhsusf_m1a1fep_d","rhsusf_M1078A1P2_d_fmtv_usarmy","rhsusf_M1078A1P2_d_open_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_fmtv_usarmy","rhsusf_M1078A1P2_B_M2_d_fmtv_usarmy","B_Heli_Light_01_F","B_Heli_Light_01_armed_F","RHS_UH60M_d","RHS_UH1Y_FFAR_d","RHS_CH_47F_10","RHS_AH1Z_CS","RHS_AH64D_CS","RHS_A10"];


/////////////////////////////////////////////////////////////////////////////////////////////-- Do not edit below here -- /////////////////////////////////////////////////////////////////////////////////////////////

#define VH_VEHICLELIST 7203
#define VH_SPAWNBUTTON findDisplay 720 displayCtrl 7206

_this params [
	["_object", nil],
	["_passedVehicles", []],
	["_combined", false]
];
private ["_vehicleList","_position","_direction"];
disableSerialization;

//-- Create dialog
CreateDialog "Spyder_VehicleMenu";

if (isNil "_object") exitWith {hint "No object was specified for the vehicles to spawn at"};

_passedVehicles1 = [];
{
	if (typeName _x != "STRING") then {_passedVehiclesChanged pushBack str _x};
} forEach _passedVehicles;

if (_combined) then {_vehicleList = _vehicles + _passedVehicles1} else {_vehicleList = _vehicles};
//-- Create List
{
	_className = _x;
	
	_veh = configfile >> "CfgVehicles" >> _classname;
	_vehName = getText (_veh >> "displayName");
	lbAdd [VH_VEHICLELIST, _vehName];
	lbSetData [VH_VEHICLELIST, _forEachIndex, _classname];
} forEach _vehicleList;

//-- Track change in selection
(findDisplay 720 displayCtrl 7203)  ctrlAddEventHandler ["LBSelChanged","
	_classname = lbData [7203, (lbCurSel 7203)];
	[_classname] spawn VH_fnc_vehicleInfo;
"];

//-- Get object position
switch (typeName _object) do {
	case "OBJECT": {
		_position = getPos _object;
		_direction = getDir _object;
	};
	case "STRING": {
		_position = getMarkerPos _object;
		_direction = markerDir _object;
	};
	case "ARRAY": {
		_position = _object;
		_direction = 0;
	};

	default {
		_position = [0,0,0];
		_direction = 0;
	};
};

//-- Initialize logic
VH_Logic = [_position,_direction];