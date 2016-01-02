/* -----------------------------------------------------------------------------------
filename: addInsurgencyMenu.sqf
Use: Adds an action menu to the ACE interaction menu if ACE is running. Otherwise, the actions are added to the action menu

Author: SpyderBlack723
----------------------------------------------------------------------------------- */
if (missionNamespace getVariable ["ace_common", false]) then {
	//--Main
	_Spyder_main = ["Spyder_main","Zona de Combate","data\images\InsurgencyIcon.paa",{},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _Spyder_main ] call ace_interact_menu_fnc_addActionToObject;

	//-- Earplugs
	//_Spyder_earPlugsIn = ["Spyder_earPlugsIn", "Coloque o earplugs", "data\images\Earplugs.paa", {1 fadeSound 0.15;player setVariable ["Earplugs",true]}, {!(player getVariable ["Earplugs",false])}] call ace_interact_menu_fnc_createAction;
	//[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_earPlugsIn] call ace_interact_menu_fnc_addActionToObject;

	//-- Earplugs out
	//_Spyder_earPlugsOut = ["Spyder_earPlugsOut", "Retirar earplugs", "data\images\Earplugs.paa", {1 fadeSound 1;player setVariable ["Earplugs",false]}, {player getVariable ["Earplugs",false]}] call ace_interact_menu_fnc_createAction;
	//[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_earPlugsOut] call ace_interact_menu_fnc_addActionToObject;

	//-- Create base
	_Spyder_createBase = ["Spyder_createBase", "Estabilizar Base", "data\images\BaseIcon.paa", {CreateDialog "Spyder_CreateBase"}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_createBase] call ace_interact_menu_fnc_addActionToObject;

	//-- Rallypoint
	//_Spyder_deployRallypoint = ["Spyder_deployRallypoint", "Estabelecer Ponto de encontro", "data\images\TentIcon.paa", {[] spawn Spyder_fnc_rallypoint}, {true}] call ace_interact_menu_fnc_createAction;
	//[player, 1, ["ACE_SelfActions", "Spyder_main"], _Spyder_deployRallypoint] call ace_interact_menu_fnc_addActionToObject;
//} else {
	//-- Rallypoint
	//player addAction ["Estabelecer Ponto de Encontro", "_this spawn Spyder_fnc_rallypoint", nil, 5, false, true, "", "_target == player"];

	//-- Create base
	player addAction ["Estabelecer Base", "CreateDialog 'Spyder_CreateBase'", nil, 0, false, true, "", "_target == player"];
};