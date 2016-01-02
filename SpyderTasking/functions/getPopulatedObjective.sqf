params ["_side",["_objType","CIV"],["_radius",500]];
private ["_opcom"];

//-- Validate side
if !(typeName _side == "STRING") then {_side = str _side};

//-- Validate objective type
if !(typeName _objType == "STRING") then {_objType = str (toUpper _objType)} else {_objType = toUpper _objType};

//-- Get opcom
{
	if (([_x,"side"] call ALiVE_fnc_HashGet) == _side) then {_opcom = _x};
} forEach OPCOM_instances;

//-- Get type objectives
_objectives = [_opcom,"objectives",[]] call ALiVE_fnc_HashGet;
_typeObjectives = [];
{
	if (([_x, "type"] call ALIVE_fnc_hashGet) == _objType) then {
		_typeObjectives pushBack _x;
	};
} forEach _objectives;

//-- Validate objectives
_populatedObjectives = [];
{
	_position = [_x, "center"] call ALiVE_fnc_HashGet;
	if (count ([_position, _radius, [_side,"entity"]] call ALIVE_fnc_getNearProfiles) > 0) then {
		_populatedObjectives pushBack _x;
	};
} forEach _typeObjectives;
if (count _populatedObjectives == 0) exitWith {false};

_populatedObjective = _populatedObjectives call BIS_fnc_selectRandom;

_populatedObjective