private ["_searchRange","_nearProfiles","_sortedProfiles","_selectedProfile","_selectedProfileCommands","_array","_data","_road"];
		
//-- Select random objective
_faction = [ST_Logic, "HostileFaction"] call ALiVE_fnc_hashGet;
_side = _faction call ALiVE_fnc_factionSide;
_opcomID = [ST_Logic, "HostileOpcom"] call ALiVE_fnc_hashGet;
_opcom = [objNull, "getOPCOMbyid", _opcomID] call ALiVE_fnc_Opcom;
_objectives = [_opcom,"objectives"] call ALiVE_fnc_HashGet;
_selectedObjectivePos = [(_objectives call BIS_fnc_selectRandom),"center",[]] call CBA_fnc_HashGet;

//-- Get road position
_roads = _selectedObjectivePos nearRoads 500;
if (count _roads == 0) exitWith {[10] call ST_fnc_taskHander};
_road = getPos (_roads call BIS_fnc_selectRandom);

//-- Get nearby profiles
_searchRange = 1000;
while {
	_nearProfiles = [_road, _searchRange, [str _side,"entity"]] call ALIVE_fnc_getNearProfiles;
	  ((count _nearProfiles == 0) && {_searchRange <= 4000});
} do {_searchRange = _searchRange + 1000};
if (count _nearProfiles == 0) exitWith {[10] call ST_fnc_taskHander};
		
//-- Assign task to players
_description = format ["Recebemos informações de insurgentes que se deslocam para plantar uma bomba caseira perto de %1. Proteger a área e desarmar o IED antes que cause qualquer vítima.", [_road] call ALIVE_fnc_taskGetNearestLocationName];
_description = [_description, "Desarmar IED", "Desarmar IED"];
[true,["SpyderAutoTask"],_description,_road,true,1,true,"",true] call BIS_fnc_taskCreate;

//-- Sort for closest
_sortedProfiles = [_nearProfiles,[_road],{_input0 distance2D ([_x,"position",[0,0,0]] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;
_selectedProfile = _sortedProfiles select 0;
_profileID = [_selectedProfile,"profileID"] call ALIVE_fnc_hashGet;

//-- Set the unit to busy so it is not used by OPCOM
[_selectedProfile,"busy",true] call ALIVE_fnc_hashSet;
[_selectedProfile, "clearWaypoints"] call ALIVE_fnc_profileEntity;
[_selectedProfile, "clearActiveCommands"] call ALIVE_fnc_profileEntity;
[_selectedProfile, "clearInactiveCommands"] call ALIVE_fnc_profileEntity;

//-- Add waypoint to road position
_wp = [_road, 0, "MOVE","FULL",0] call ALIVE_fnc_createProfileWaypoint;
[_selectedProfile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

waitUntil {sleep 20;
	count ([_selectedProfile,"waypoints",[]] call ALIVE_fnc_hashGet) == 0 or 
		{!(_profileID in ([ALIVE_profileHandler, "getProfilesBySide", str _side] call ALIVE_fnc_profileHandler)) or
			{(([_selectedProfile, "position", [0,0,0]] call CBA_fnc_HashGet) distance2D _road) < 30
}}};

//-- Check if profile died
if !(_profileID in ([ALIVE_profileHandler, "getProfilesBySide", str _side] call ALIVE_fnc_profileHandler)) exitWith {
	//-- Complete task
	["SpyderAutoTask","SUCCEEDED"] call BIS_fnc_taskSetState;
	// _playerFaction = [] call ST_fnc_getPlayerFaction;
	_friendlyFaction = [ST_Logic, "FriendlyFaction"] call ALiVE_fnc_hashGet;
	[_friendlyFaction,5] call ST_fnc_rewardForcepool;
	sleep 60;
	[] call ST_fnc_taskHander;
	["SpyderAutoTask"] call BIS_fnc_deleteTask;
};

sleep 15;
_roadPos = getPos ((_road nearRoads 50) call BIS_fnc_selectRandom);
_iedPos =  [_roadPos, 6] call CBA_fnc_randPos;
[_iedPos] call ST_fnc_createIED;

//-- Random course of action
switch (str (floor random 3)) do {

	//-- Flee
	case "0": {
		_fleePosition = [_selectedProfile] call ST_fnc_getFleePosition;
		_wp = [_fleePosition, 0, "MOVE","FULL",0] call ALIVE_fnc_createProfileWaypoint;
		[_selectedProfile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
	};

	//-- Secondary IED
	case "1": {
		_secondaryPosition = getPos ((_road nearRoads 75) call BIS_fnc_selectRandom);
		[_secondaryPosition] call ST_fnc_createIED;

		_fleePosition = [_selectedProfile] call ST_fnc_getFleePosition;
		_wp = [_fleePosition, 0, "MOVE","FULL",0] call ALIVE_fnc_createProfileWaypoint;
		[_selectedProfile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
	};


	//-- Ambush	
	case "2": {
		_newPosition = [_road,250,120,10] call BIS_fnc_findOverwatch;
		_wp = [_newPosition, 0, "MOVE","FULL",0] call ALIVE_fnc_createProfileWaypoint;
		[_selectedProfile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

		[_selectedProfile,_road] spawn {
			params ["_profile","_iedPos"];
			waitUntil {sleep 5; [_profile,"active"] call ALiVE_fnc_HashGet};

			_group = _profile select 2 select 13;
			waitUntil {sleep 2;unitReady (leader _group)};
			_units = +(units _group);
			_group setbehaviour "AWARE";
			_group setSpeedmode "NORMAL";
			{
				_x commandWatch _iedPos;
				_x setUnitPos "DOWN";
			} forEach _units;
		};
	};
};

//-- Wait until all nearby IED's have been cleared
waitUntil {sleep 15; count (nearestObjects [_road, ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo"], 100]) == 0};

//-- Hand profile back to OPCOM
if (_profileID in ([ALIVE_profileHandler, "getProfilesBySide", str _side] call ALIVE_fnc_profileHandler)) then {[_selectedProfile,"busy",false] call ALIVE_fnc_hashSet};

//-- Complete task
["SpyderAutoTask","SUCCEEDED"] call BIS_fnc_taskSetState;
// _playerFaction = [] call ST_fnc_getPlayerFaction;
_friendlyFaction = [ST_Logic, "FriendlyFaction"] call ALiVE_fnc_hashGet;
[_friendlyFaction,5] call ST_fnc_rewardForcepool;

//-- Reset tasking
sleep 60;
["SpyderAutoTask"] call BIS_fnc_deleteTask;
[] call ST_fnc_taskHandler;