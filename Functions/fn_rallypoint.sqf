/*-------------------------------------------

Function: Spyder_fnc_rallypoint


Description: Places a rallypoint at the player's location. A new spawn point for the player's side is also created.


Example:
	player addAction ["
	Rallypoint", "_this spawn Spyder_fnc_rallypoint", nil, 5, false, true, "", "_target == player"];
	[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_deployRallypoint] call ace_interact_menu_fnc_addActionToObject;


Author: SpyderBlack723

-------------------------------------------*/
params ["_target","_unit","_id"];
_delay = 600;

//-- Check for valid position
_pos = ATLtoASL (player modelToWorld [0,2,0]);
while {lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]]} do {
	_pos set [2, (_pos select 2) - 0.1];
};

while {!lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]] && _pos select 2 > getTerrainHeightASL _pos} do {
	_pos set [2, (_pos select 2) - 0.1];
};

if (_pos select 2 < getTerrainHeightASL _pos) then {
	_pos set [2, getTerrainHeightASL _pos];
};

while {lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]]} do {
	_pos set [2, (_pos select 2) + 0.01];
};

if (lineIntersects [getPosASL player, _pos]) exitWith {
	systemChat "No suitable position found";
	false
};

//-- Delete existing rallypoint
if (!isNil {player getVariable "Spyder_Rallypoint"}) then {
	_rallypoint = player getVariable "Spyder_Rallypoint";
	_rallypointData = _rallypoint getVariable "Data";
	_rallypointData params ["_marker","_spawnPos"];

	//-- Remove all existing data
	deleteVehicle _rallypoint;
	deleteMarker _marker;
	_spawnPos call BIS_fnc_removeRespawnPosition;

	//-- Reset vars
	player setVariable ["Spyder_Rallypoint", nil];
};

//-- Play animation
player playActionNow "PutDown";
sleep .7;

//-- Create rallypoint
_safePos = ASLtoATL _pos;
_rallypoint = createVehicle ["Land_TentDome_F", _safePos, [], 0, "CAN_COLLIDE"];
_pos = getPos player;
_marker = [str _pos, _pos, "ICON", [1, 1], "ColorBlack", "Rallypoint", "mil_flag"] call ALIVE_fnc_createMarkerGlobal;
_spawnPos = [faction player call ALiVE_fnc_factionSide, _pos] call BIS_fnc_addRespawnPosition;

//-- Remove action
if (missionNamespace getVariable ["ace_common", false]) then {
	[player,1,["ACE_SelfActions", "Spyder_main","Spyder_deployRallypoint"]] call ace_interact_menu_fnc_removeActionFromObject;
} else {
	params ["_target","_unit","_id"];
	player removeAction _id;
};

//-- Set vars
_rallypoint setVariable ["Data", [_marker, _spawnPos]];
player setVariable ["Spyder_Rallypoint", _rallypoint];
player setVariable ["Spyder_Rallypoint_Skip", true];
player addEventHandler ["killed", "
	_unit = _this select 0;
	if (!isNil {_unit getVariable 'SpyderInsurgency_RallypointFrameHandler'}) then {_handler = _unit getVariable 'SpyderInsurgency_RallypointFrameHandler';[_handler] call CBA_fnc_removePerFrameHandler};
	if (!isNil {_unit getVariable 'Spyder_Rallypoint_Skip'}) then {_unit setVariable ['Spyder_Rallypoint_Skip', nil]};
"];

//-- Add actions to rallypoint
[[[_rallypoint],{
	params ["_rallypoint"];

	if (hasInterface) then {
		//-- Virtual Arsenal
		_rallypoint addAction ["Acessar Loadout Manager", "CreateDialog 'SLO_SaveLoad'"];
	};
}],"BIS_fnc_spawn",true] call BIS_fnc_MP;

//-- Add action again
_handler = [{
	if (player getVariable "Spyder_Rallypoint_Skip") exitWith {player setVariable ["Spyder_Rallypoint_Skip", nil]};

	if (missionNamespace getVariable ["ace_common", false]) then {
		_Spyder_deployRallypoint = ["Spyder_deployRallypoint", "Deploy Rallypoint", "data\images\TentIcon.paa", {[] spawn Spyder_fnc_rallypoint}, {true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_deployRallypoint] call ace_interact_menu_fnc_addActionToObject;
	} else {
		player addAction ["Deploy Rallypoint", "_this spawn Spyder_fnc_rallypoint", nil, 5, false, true, "", "_target == player"];
	};

	//--Remove perFrameHandler
	_handler = player getVariable "SpyderInsurgency_RallypointFrameHandler";
	[_handler] call CBA_fnc_removePerFrameHandler;
}, _delay, []] call CBA_fnc_addPerFrameHandler;

player setVariable ["SpyderInsurgency_RallypointFrameHandler", _handler];