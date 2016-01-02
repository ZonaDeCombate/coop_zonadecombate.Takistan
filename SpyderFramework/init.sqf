//-- Execute only on server
if (!isServer) exitWith {};

//-- Asymmetric
SF_fnc_getPositionSideHostility = compileFinal preprocessFileLineNumbers "SpyderFramework\asymmetric\getPositionSideHostility.sqf";

//-- Logistics
SF_fnc_addForcepool = compileFinal preprocessFileLineNumbers "SpyderFramework\logistics\addForcepool.sqf";

//-- Misc
SF_fnc_getFactionMostPlayers = compileFinal preprocessFileLineNumbers "SpyderFramework\misc\getFactionMostPlayers.sqf";

//-- Objectives
SF_fnc_createObjective = compileFinal preprocessFileLineNumbers "SpyderFramework\objectives\createObjective.sqf";
SF_fnc_createObjective = compileFinal preprocessFileLineNumbers "SpyderFramework\objectives\createObjective.sqf";
SF_fnc_getSideDominantObjectives = compileFinal preprocessFileLineNumbers "SpyderFramework\objectives\getSideDominantObjectives.sqf";

//-- Opcom
SF_fnc_getOpcoms = compileFinal preprocessFileLineNumbers "SpyderFramework\opcom\getOpcoms.sqf";
SF_fnc_getAsymmOpcoms = compileFinal preprocessFileLineNumbers "SpyderFramework\opcom\getAsymmOpcoms.sqf";

//-- Profiles