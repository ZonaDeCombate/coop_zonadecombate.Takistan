params ["_opcom","_returnOpcom"];
private ["_selectedSide","_selectedOpcom"];

//-- Get enemy sides
_enemySides = [_opcom, "sidesenemy"] call ALIVE_fnc_hashGet;

//-- Convert side string to side object
_sideArray = [];
{
	if (_x == "WEST") then {_sideArray pushBack WEST};
	if (_x == "EAST") then {_sideArray pushBack EAST};
	if (_x == "GUER") then {_sideArray pushBack GUER};
} forEach _enemySides;

//-- Get player side
if (count _sideArray == 1) then {_selectedSide = _sideArray select 0};
if (((_sideArray select 0) countSide allPlayers) > ((_sideArray select 1) countSide allPlayers)) then {
	_selectedSide = _sideArray select 0;
} else {
	_selectedSide = _sideArray select 1;
};

if !(_returnOpcom) exitWith {_selectedSide};

//-- Get OPCOM
{
	if (([_x, "side"] call ALiVE_fnc_HashGet) == str _selectedSide) then {_selectedOpcom = _x};
} forEach OPCOM_instances;
if (isNil "_selectedOpcom") exitWith {false};

[_selectedSide,_selectedOpcom];


