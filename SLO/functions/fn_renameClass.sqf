#define SLO_CLASSLIST 7217
#define SLO_EDIT 7215

//-- Dialogue data
_slot = lbCurSel SLO_CLASSLIST;

//-- Get loadout
_loadout = profileNameSpace getVariable format ["SLOLoadout_%1",_slot];	
_loadout params ["_name","_uniform","_vest","_backpack","_backpackitems","_headgear","_goggles","_uniformitems","_vestitems","_weapons","_primaryweaponitems","_secondaryweaponitems","_assigneditems", "_primaryWeaponMagazines"];
_name = ctrlText SLO_EDIT;

//-- Save loadout with new name
profileNameSpace setVariable[format["SLOLoadout_%1", _slot],[_name, _uniform,_vest, _backpack, _backpackitems, _headgear, _goggles,_uniformitems, _vestitems, _weapons, _primaryweaponitems, _secondaryweaponitems, _assigneditems, _primaryWeaponMagazines]];

saveProfileNamespace;

//-- Build new list
[] spawn SLO_fnc_buildList;

lbSetCurSel [SLO_CLASSLIST, _slot];