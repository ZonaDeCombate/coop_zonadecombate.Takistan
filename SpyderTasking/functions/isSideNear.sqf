params [["_side","WEST"],["_location",[0,0,0]],["_radius",1000],["_returnType",false]];
private ["_nearProfiles","_return"];

//-- Convert side to a string if it's not already
if !(typeName _side == "STRING") then {_side = str _side};

//-- Convert location to object location if it's not an array
if !(typeName _location == "ARRAY") then {_location = [_location] call ALiVE_fnc_getPos};

//-- Get profiles
_profileIDList = [ALIVE_profileHandler, "getProfilesBySide", _side] call ALIVE_fnc_profileHandler;
_profileList = [];
{
	_profileList pushBack ([ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler);
} forEach _profileIDList;
if (count _profileList == 0) exitWith {false};

//-- Sort for profiles within the radius of the location
_nearProfiles = 0;
{
	if (([_x, "position", [0,0,0]] call ALiVE_fnc_HashGet) distance2D _location <= _radius) then {
		_nearProfiles = _nearProfiles + 1;
	};
} forEach _profileList;

if (_returnType) exitWith {_nearProfiles};

//-- Get return value
if (_nearProfiles > 0) then {_return = true} else {_return = false};

_return;