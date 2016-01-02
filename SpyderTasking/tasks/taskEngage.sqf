private ["_profile","_description","_name","_profileID","_profileIDList"];

_faction = [ST_Logic, "HostileFaction"] call ALiVE_fnc_hashGet;
_side = _faction call ALiVE_fnc_factionSide;

//-- Get profiles
_profileIDList = [ALIVE_profileHandler, "getProfilesBySide", str _side] call ALIVE_fnc_profileHandler;
if (count _profileIDList == 0) exitWith {[10] call ST_fnc_taskHander};
_profileID = _profileIDList call BIS_fnc_selectRandom;
_profile = [ALIVE_profileHandler, "getProfile", _profileID] call ALIVE_fnc_profileHandler;
_profilePosition = [_profile, "position"] call ALiVE_fnc_HashGet;
_assignments = ([_profile,"vehicleAssignments",["",[],[],nil]] call ALIVE_fnc_hashGet) select 1;

if ((([_profile,"type"] call ALIVE_fnc_HashGet) == "entity") and {count _assignments == 0}) then {
	_description = format ["Nós descobrimos o local de um grupo insurgente infantaria perto de %1. Mover para a área e eliminá-los.", [_profilePosition] call ALIVE_fnc_taskGetNearestLocationName];
	_description = [_description, "Eliminar insurgência", "Eliminar insurgência"];
	_name = "Eliminar insurgência";
} else {
	_description = format ["Temos conseguido informações sobre a localização de um grupo insurgente e um veículo operando perto de %1. Destrua os veículos o mais rápido possível antes que eles são capazes de causar qualquer baixa nas forças aliadas.", [_profilePosition] call ALIVE_fnc_taskGetNearestLocationName];
	_description = [_description, "Destruir veículos insurgentes", "Destruir veículos insurgentes"];
	_name = "Destruir veículos insurgentes";
};

//-- Assign task to players
[true,["SpyderAutoTask"],_description,_profilePosition,true,1,true,"",true] call BIS_fnc_taskCreate;

//-- Wait until the profile is dead
waitUntil {
	sleep 30;
	["SpyderAutoTask",[_profile, "position"] call ALiVE_fnc_HashGet] call BIS_fnc_taskSetDestination;
	!(_profileID in ([ALIVE_profileHandler, "getProfilesBySide", str _side] call ALIVE_fnc_profileHandler));
};

//-- Complete task
["SpyderAutoTask","SUCCEEDED"] call BIS_fnc_taskSetState;
// _playerFaction = [] call ST_fnc_getPlayerFaction;
_friendlyFaction = [ST_Logic, "FriendlyFaction"] call ALiVE_fnc_hashGet;
[_friendlyFaction,5] call ST_fnc_rewardForcepool;

//-- Reset tasking
sleep 60;
["SpyderAutoTask"] call BIS_fnc_deleteTask;
[] call ST_fnc_taskHandler;