#define SLO_CLASSLIST 7217

//-- Get class
_slot = lbCurSel SLO_CLASSLIST;

//-- Save loadout
profileNameSpace setVariable [format ["SLOLoadout_%1", _slot], nil];

saveProfileNamespace;

//-- Build new list
[] call SLO_fnc_buildList;

lbSetCurSel [SLO_CLASSLIST, _slot];