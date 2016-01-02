private ["_side","_selectedSide","_selectedOpcom","_selectedObjective","_description","_name","_randomNum","_objType","_stagingPos"];

_faction = [ST_Logic, "HostileFaction"] call ALiVE_fnc_hashGet;
_opcomID = [ST_Logic, "HostileOpcom"] call ALiVE_fnc_hashGet;
_opcom = [objNull, "getOPCOMbyid", _opcomID] call ALiVE_fnc_Opcom;

//-- Get enemy player opcom
_enemyData = [_opcom,true] call ST_fnc_getEnemyPlayerSide;
if (isNil {_enemyData select 1}) exitWith {[10] call ST_fnc_taskHandler};
_enemyData params ["_enemySide","_enemyOpcom"];
_insurgentOpcomPos = [_opcom, "position"] call ALiVE_fnc_HashGet;

//-- Get viable objectives
_objectives = [_enemyOpcom,"objectives",[]] call ALiVE_fnc_HashGet;
if (count _objectives == 0) exitWith {[10] call ST_fnc_taskHandler};
_enemyObjectives = [_objectives,_enemySide] call ST_fnc_getSideDominantObjectives;
_sortedObjectives = [_enemyObjectives,[_insurgentOpcomPos],{_input0 distance2D ([_x,"position",[0,0,0]] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;

//-- Select objective to attack
_randomNum = ceil (random (count _sortedObjectives * .15)); 
if (_randomNum <= 3) then {_randomNum = _randomNum + (2 + ceil random 2)};
_selectedObjective = _sortedObjectives select _randomNum;
_selectedObjectivePos = [_selectedObjective, "center"] call ALIVE_fnc_hashGet;

//-- Change task based on type of objective picked
if (([_selectedObjective, "type"] call ALIVE_fnc_hashGet) == "CIV") then {
	_description = format ["Recebemos informações que os insurgentes estão se movendo para atacar a cidade de %1. É vital que nós não perdemos esta cidade, mover para a área e repelir o ataque.", [_selectedObjectivePos] call ALIVE_fnc_taskGetNearestLocationName];
	_description = [_description, "Defenda a cidade", "Defenda a cidade"];
	_name = "Defenda a cidade";
} else {
	_description = format ["Recebemos informações que os insurgentes estão se preparando para assaltar %1. Mover-se para a base e montar uma defesa para impedir os insurgentes de capturar a FOB. ", [_selectedObjectivePos] call ALIVE_fnc_taskGetNearestLocationName];
	_description = [_description, "Defender a base", "Defender a base"];
	_name = "Defender a base";
};

//-- Assign task to players
[true,["SpyderAutoTask"],_description,_selectedObjectivePos,true,1,true,"",true] call BIS_fnc_taskCreate;

//-- Get groups to attack with
_insurgentSide = _faction call ALiVE_fnc_factionSide;
_nearGroups = [_selectedObjectivePos,_insurgentSide,ceil random 3] call ST_fnc_getSideNearestGroups;
if ((isNil "_nearGroups") or (count _nearGroups == 0)) exitWith {[10] call ST_fnc_taskHandler};

//-- Give move to staging position command to insurgents
{
	_profile = _x;

	//-- Free up profile
	[_profile,"busy",true] call ALIVE_fnc_hashSet;
	[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;
	[_profile, "clearActiveCommands"] call ALIVE_fnc_profileEntity;
	[_profile, "clearInactiveCommands"] call ALIVE_fnc_profileEntity;

	//-- Staging waypoint
	_profilePos = [_profile, "position", [0,0,0]] call CBA_fnc_HashGet;
	if (_profilePos distance2D _selectedObjectivePos > 300) then {
		_stagingDirection = [_selectedObjectivePos, _insurgentOpcomPos] call BIS_fnc_dirTo;
		_stagingPos = [_selectedObjectivePos, 500, _stagingDirection] call BIS_fnc_relPos;
		_nearStagingPos = [_stagingPos, 30] call CBA_fnc_randPos;
		_wp = [_nearStagingPos, 0, "MOVE","NORMAL", 50] call ALIVE_fnc_createProfileWaypoint;
		[_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
	};
} forEach _nearGroups;

//-- Wait will all of the groups reach the staging position
waitUntil {
	sleep 60;
	_goodGroups = [];
	_badGroups = [];
	{
		_profileID = [_x,"profileID"] call ALIVE_fnc_hashGet;	

		//-- Get groups at staging position
		if (count ([_x,"waypoints",[]] call ALIVE_fnc_hashGet) == 0 or
			{(([_x, "position", [0,0,0]] call CBA_fnc_HashGet) distance2D _stagingPos) < 100	
		}) then {_goodGroups pushBack _x};

		//-- Get groups that have died
		if !(_profileID in ([ALIVE_profileHandler, "getProfilesBySide", str _insurgentSide] call ALIVE_fnc_profileHandler)) then {
			_badGroups pushBack _x;
		};
	sleep 1;
	} forEach _nearGroups;
	count _goodGroups + count _badGroups == count _nearGroups;
};

_profilesLeft = [];
//-- All available profiles in position, move to attack
{
	if (([_x,"profileID"] call ALIVE_fnc_hashGet) in ([ALIVE_profileHandler, "getProfilesBySide", str _insurgentSide] call ALIVE_fnc_profileHandler)) then {
		//-- Assault waypoint
		_profilesLeft pushBack _x;
		_attackPos = [_selectedObjectivePos, 50] call CBA_fnc_randPos;
		_wp = [_attackPos, 0, "SAD","NORMAL",0,[0,0,0], "DELTA", "RED", "COMBAT"] call ALIVE_fnc_createProfileWaypoint;
		[_x,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;
	};
} forEach _nearGroups;

//-- If all groups killed, exit with reward
if (count _profilesLeft == 0) exitWith {
	["SpyderAutoTask","SUCCEEDED"] call BIS_fnc_taskSetState;
	// _playerFaction = [] call ST_fnc_getPlayerFaction;
	_friendlyFaction = [ST_Logic, "FriendlyFaction"] call ALiVE_fnc_hashGet;
	[_friendlyFaction,5] call ST_fnc_rewardForcepool;
	sleep 60;
	["SpyderAutoTask"] call BIS_fnc_deleteTask;
	[] call ST_fnc_taskHandler;
};

//-- Wait for assault to end
waitUntil {
	sleep 30;
	(([_insurgentSide,_selectedObjectivePos,700,true] call ST_fnc_isSideNear) == 0 or 
		{([str _enemySide,_selectedObjectivePos,700,true] call ST_fnc_isSideNear) == 0
	});
};

//-- No friendlies nearby objective, task failed
if (([str _enemySide,_selectedObjectivePos,700,true] call ST_fnc_isSideNear) == 0) exitWith {
	["SpyderAutoTask","FAILED"] call BIS_fnc_taskSetState;
	sleep 60;
	["SpyderAutoTask"] call BIS_fnc_deleteTask;
	[] call ST_fnc_taskHandler;
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