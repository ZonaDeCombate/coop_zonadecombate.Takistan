params ["_profile"];

//-- Get profile position
_position = [_profile, "position", []] call CBA_fnc_HashGet;

//-- Get sector
_sector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
_sectorData = (([_sector, "data"] call ALIVE_fnc_hashGet) select 2) select 6;

//-- Get sector's hills
_hills = [_sectorData, "exposedHills"] call ALIVE_fnc_hashGet;
if (count _hills == 0) exitWith {false};
_sortedHills = [_hills,[_road],{_Input0 distance2D _x},"ASCEND"] call BIS_fnc_sortBy;
_nearHills = [];
for "_i" from (ceil ((count _sortedHills) * .20)) to (ceil ((count _sortedHills) * .25)) do {
	_nearHills pushBack (_sortedHills select _i);
};

_fleePosition = _nearHills call BIS_fnc_selectRandom;


_fleePosition;