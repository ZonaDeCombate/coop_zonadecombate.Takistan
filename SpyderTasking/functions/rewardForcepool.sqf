//-- Only run on server
if (!isServer) exitWith {
	//-- Execute on server
	[[_this,{
		_this call ST_fnc_rewardForcepool;
	}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
};

params ["_input","_amount"];
private ["_faction"];

//-- Get faction
if (typeName _input == "OBJECT") then {
	_faction = faction _input;
} else {
	if (typeName _input == "STRING") then {
		_faction = _input;
	};
};

if ((isNil {[ALIVE_globalForcePool, _faction] call ALIVE_fnc_hashGet}) or {isNil "_faction"}) exitWith {};
_forcePool = [ALIVE_globalForcePool, _faction] call ALIVE_fnc_hashGet;
[ALIVE_globalForcePool, _faction, (_forcePool + _amount)] call ALIVE_fnc_hashSet;
