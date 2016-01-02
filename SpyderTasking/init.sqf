//-- Only run on server
if ((!isServer) or (!isNil "ST_Logic")) exitWith {};

//-- Parse variables
params ["_friendlyFaction","_hostileFaction"];
private ["_friendlyFaction","_hostileFaction","_friendlyOpcom","_hostileOpcom"];

//-- Convert factions to string
if (typeName _friendlyFaction != "STRING") then {_friendlyFaction = str _friendlyFaction};
if (typeName _hostileFaction != "STRING") then {_hostileFaction = str _hostileFaction};

//-- Init functions
ST_fnc_armIED = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\armIED.sqf";
ST_fnc_createIED = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\createIED.sqf";
ST_fnc_disarmIED = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\disarmIED.sqf";
ST_fnc_getEnemyPlayerSide = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getEnemyPlayerSide.sqf";
ST_fnc_getFleePosition = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getFleePosition.sqf";
ST_fnc_getPlayerFaction = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getPlayerFaction.sqf";
ST_fnc_getPopulatedObjective = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getPopulatedObjective.sqf";
ST_fnc_getSideDominantObjectives = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getSideDominantObjectives.sqf";
ST_fnc_getSideNearestGroups = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\getSideNearestGroups.sqf";
ST_fnc_isSideNear = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\isSideNear.sqf";
ST_fnc_rewardForcepool = compileFinal preprocessFileLineNumbers "SpyderTasking\functions\rewardForcepool.sqf";

//-- Init tasks
ST_fnc_taskAttack = compileFinal preprocessFileLineNumbers "SpyderTasking\tasks\taskAttack.sqf";
ST_fnc_taskDefense = compileFinal preprocessFileLineNumbers "SpyderTasking\tasks\taskDefense.sqf";
ST_fnc_taskEngage = compileFinal preprocessFileLineNumbers "SpyderTasking\tasks\taskEngage.sqf";
ST_fnc_taskIED = compileFinal preprocessFileLineNumbers "SpyderTasking\tasks\taskIED.sqf";
ST_fnc_taskHandler = compileFinal preprocessFileLineNumbers "SpyderTasking\taskHandler.sqf";

//-- Wait for ALiVE to initialize -- Exit if no opcoms are placed
waitUntil {!isNil "ALiVE_REQUIRE_INITIALISED"};
if ((isNil "OPCOM_Instances") or (count OPCOM_Instances == 0)) exitWith {hint "Either ALiVE is not running or no OPCOMs are present in the mission"};

//-- Initialize logic
ST_Logic = [] call ALIVE_fnc_hashCreate;
[ST_Logic, "FriendlyFaction", _friendlyFaction] call ALiVE_fnc_hashSet;
[ST_Logic, "HostileFaction", _hostileFaction] call ALiVE_fnc_hashSet;

//-- Get OPCOM
{
	_opcom = _x;
	_id = [_opcom, "opcomID"] call ALiVE_fnc_hashGet;
	_factions = [_x, "factions"] call ALiVE_fnc_HashGet;

	//-- Check for friendly faction
	if (_friendlyFaction in _factions) then {
		[ST_Logic, "FriendlyOpcom", _id] call ALiVE_fnc_hashSet;
	};

	//-- Check for hostile faction
	if (_hostileFaction in _factions) then {
		[ST_Logic, "HostileOpcom", _id] call ALiVE_fnc_hashSet;
	};
} forEach OPCOM_instances;

waitUntil {sleep 1;!isNil "ST_fnc_taskHandler"};
//-- Initialize task handler
[] call ST_fnc_taskHandler;