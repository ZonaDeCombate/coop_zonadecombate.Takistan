#define SLO_CLASSLIST 7217
#define SLO_EDIT 7215

//-- Dialog data
_slot = lbCurSel SLO_CLASSLIST;
_name = ctrlText SLO_EDIT;

//-- Save gear
_uniform = uniform player;
_vest = vest player;
_backpack = backpack player;
_backpackitems = backpackItems player;
_headgear = headgear player;
_goggles = goggles player;
_uniformitems = uniformItems player;
_vestitems = vestItems player;
_weapons = weapons player;
_primaryweaponitems = primaryWeaponItems player;
_secondaryweaponitems = secondaryWeaponItems player;
_assigneditems = assignedItems player;
_primaryWeaponMagazines = primaryWeaponMagazine player;

//-- Save loadout
profileNameSpace setVariable [format ["SLOLoadout_%1", _slot],[_name, _uniform,_vest, _backpack, _backpackitems, _headgear, _goggles,_uniformitems, _vestitems, _weapons, _primaryweaponitems, _secondaryweaponitems, _assigneditems, _primaryWeaponMagazines]];

saveProfileNamespace;

//-- Build new list
[] call SLO_fnc_buildList;

lbSetCurSel [SLO_CLASSLIST, _slot];