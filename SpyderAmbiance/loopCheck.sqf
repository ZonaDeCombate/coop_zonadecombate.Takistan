params ["_animals","_terrorists","_delay","_blacklists","_debug"];

//-- Get locations and create logic points
_cities = [];
_locations = configfile >> "CfgWorlds" >> worldName >> "Names";
_cityTypes = ["NameVillage","NameCity","NameCityCapital","NameLocal"];

for "_x" from 0 to (count _locations - 1) do {
		private["_cityPos","_cityType","_inBlacklist"];

		_randomLoc = _locations select _x;
		_cityPos = getArray(_randomLoc >> "position");
		_cityType = getText(_randomLoc >> "type");

		//-- Validate that location is in _cityTypes and are not in any blacklist markers
		_inBlacklist = false;
		if (_cityType in _cityTypes) then {

			{
				_x setMarkerAlpha 0;
				if ([_x, _cityPos] call BIS_fnc_inTrigger) exitWith {
					_inBlacklist = true;
				};
			} forEach _blacklists;
			if !(_inBlacklist) then {_cities pushBack [_cityPos]};
		};	
};

//-- Debug
if (_debug) then {
	_message = format ["Spyder Ambiance: %1 locations found", count _cities];
	[_message] call ALIVE_fnc_dumpR;
};

//-- Create logics at locations
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
SpyderAmbiance_LogicPoints = [];

{
	//-- Create logic points
	_logic = _logicGroup createUnit ["Logic", (_x select 0), [], 0, "NONE"];
	_logic setVariable ["Active", false];
	_logic setVariable ["Objects", []];
	_logic setVariable ["Herds", _animals];
	_logic setVariable ["Terrorists", _terrorists];
	_logic setVariable ["Debug", _debug];
	SpyderAmbiance_LogicPoints pushBack _logic;

	//-- Create debug markers
	if (_debug) then {

		_pos = position _logic;
		_marker = createMarker [str _pos,_pos];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerText "SpyderAmbiance_City";
	};
} forEach _cities;

//-- Debug
if (_debug) then {
	_message = format ["Spyder Ambiance: %1 logic points created", count SpyderAmbiance_LogicPoints];
	[_message] call ALIVE_fnc_dumpR;
};

_perFrameID = [{
	private ["_activated","_deactivated"];
	_activated = 0;
	_deactivated = 0;

	if (!isNil "SpyderAmbiance_PerFrameID") exitWith {
		SpyderAmbiance_PerFrameID = nil;
	};

	{
		_logic = _x;
		if (({(_x distance2D getPos _logic) < 1000} count ([] call BIS_fnc_listPlayers)) == 0) then {
			if (_logic getVariable "Active") then {
				[_logic,"Deactivate"] execVM "SpyderAmbiance\SpyderAmbiance.sqf";
				_deactivated = _deactivated + 1;
			};
		} else {
			if !(_logic getVariable "Active") then  {
				[_logic,"Activate"] execVM "SpyderAmbiance\SpyderAmbiance.sqf";
				_activated = _activated + 1;
			};
		};
	} forEach SpyderAmbiance_LogicPoints;

	if (SpyderAmbiance_Debug) then {
		_message = format ["Spyder Ambiance: %1 zones activated, %2 zones deactivated", _activated,_deactivated];
		[_message] call ALIVE_fnc_dumpR;
	};
}, _delay, [_debug]] call CBA_fnc_addPerFrameHandler;

SpyderAmbiance_PerFrameID = _perFrameID;