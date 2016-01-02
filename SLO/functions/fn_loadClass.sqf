#define SLO_CLASSLIST 7217

private ["_unit","_loadout"];

//-- Retrieve loadout if none was passed
if (count _this == 0) then {
	_slot = lbCurSel SLO_CLASSLIST;
	_loadout = profileNameSpace getVariable format ["SLOLoadout_%1",_slot];
} else {
	_unit = _this select 0;
	_loadout = _this select 1;
};

if (isNil "_unit") then {_unit = player};

//-- Strip the unit down
RemoveAllWeapons _unit;
{_unit removeMagazine _x} foreach (magazines _unit);
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeGoggles _unit;
removeHeadGear _unit;
removeAllAssignedItems _unit;

//-- Define Gear
_uniform = _loadout select 1;
_vest = _loadout select 2;
_backpack = _loadout select 3;
_backpackitems = _loadout select 4;
_headgear = _loadout select 5;
_goggles = _loadout select 6;
_uniformitems = _loadout select 7;
_vestitems = _loadout select 8;
_weapons = _loadout select 9;
_primaryweaponitems = _loadout select 10;
_secondaryweaponitems = _loadout select 11;
_assigneditems = _loadout select 12;
_primaryWeaponMagazines = _loadout select 13;

//-- Add Gear
_unit addUniform _uniform;
_unit addVest _vest;
_unit addBackpack _backpack;
{_unit addItemToBackpack _x} forEach _backpackitems;
_unit addHeadgear _headgear;
_unit addGoggles _goggles;
{_unit addItemToUniform _x} forEach _uniformitems;
{_unit addItemToVest _x} forEach _vestitems;
{_unit addWeapon _x} forEach _weapons;
{_unit addPrimaryWeaponItem _x} forEach _primaryweaponitems;
{_unit addSecondaryWeaponItem _x} forEach _secondaryweaponitems;
{_unit linkItem _x} forEach _assigneditems; 
{_unit addMagazine _x} forEach _primaryWeaponMagazines;