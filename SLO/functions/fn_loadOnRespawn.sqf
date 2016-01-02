#define SLO_CLASSLIST 7217

//-- Dialogue data
_slot = lbCurSel SLO_CLASSLIST;

//-- Get selected loadout
_loadout = profileNameSpace getVariable format ["SLOLoadout_%1",_slot];
_loadout params ["_name","_uniform","_vest","_backpack","_backpackitems","_headgear","_goggles","_uniformitems","_vestitems","_weapons","_primaryweaponitems","_secondaryweaponitems","_assigneditems", "_primaryWeaponMagazines"];

//-- Save loadout to onRespawn variable
profileNameSpace setVariable ["SLOonRespawn", [_name,_uniform,_vest,_backpack,_backpackitems,_headgear,_goggles,_uniformitems,_vestitems,_weapons,_primaryweaponitems,_secondaryweaponitems,_assigneditems,_primaryWeaponMagazines]];

saveProfileNamespace;

//-- Remove previous eventhandler if one exists
if (!isNil {player getVariable "SLO_onSpawnLoadoutIndex"}) then {
	_index = player getVariable "SLO_onSpawnLoadoutIndex";
	player removeEventHandler ["MPRespawn", _index];
	player setVariable ["SLO_onSpawnLoadoutIndex", nil];
};

_index = player addMPEventHandler ["MPRespawn", {_this spawn SLO_fnc_onSpawn}];
player setVariable ["SLO_onSpawnLoadoutIndex", _index];
