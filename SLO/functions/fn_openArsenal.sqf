private ["_closeButton"];
disableSerialization;

//-- Close Loadout Organizer
closeDialog 0;

//-- Open Arsenal
["Open",true] spawn BIS_fnc_arsenal;
waitUntil {!isNull findDisplay -1};
_closeButton = (findDisplay -1) displayCtrl 44448;
_closeButton buttonSetAction "CreateDialog 'SLO_SaveLoad'";
