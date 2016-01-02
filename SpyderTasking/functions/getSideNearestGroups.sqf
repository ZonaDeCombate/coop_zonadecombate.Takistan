params ["_location","_side","_count"];
_returnList = [];

//-- Convert side to a string if it's not already
if !(typeName _side == "STRING") then {_side = str _side};

//-- Get profiles
_profileIDList = [ALIVE_profileHandler, "getProfilesBySide", _side] call ALIVE_fnc_profileHandler;
_profileList = [];
{
	_profileList pushBack ([ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler);
} forEach _profileIDList;
if (count _profileList == 0) exitWith {_returnList};

//-- Sort profiles for distance from location
_sortedProfiles = [_profileList,[_location],{_Input0 distance2D ([_x, "position", [0,0,0]] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;

//-- Select nearest profiles
for "_i" from 0 to (count _sortedProfiles - 1) do {
	if !(count _returnList == _count) then {
		_returnList pushBack (_sortedProfiles select _i);
	};
};

_returnList;