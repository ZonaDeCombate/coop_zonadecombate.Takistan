#include "SHK_Fastrope.sqf"
//-- Add insurgency menu
execVM "Scripts\addInsurgencyMenu.sqf";

//-- Create locations for ALiVE custom objectives
//execVM "Scripts\createLocations.sqf";

// Falantes na Base
while {true} do {
    [] execVM "Scripts\loudspeakers.sqf";
    sleep 16470;
};

//-- Sistema de SQUAD da BI
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
