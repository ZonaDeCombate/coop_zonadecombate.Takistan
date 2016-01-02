_loadout = profileNameSpace getVariable "SLOonRespawn";

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

//-- Strip the unit down

RemoveAllWeapons player;

{_unit removeMagazine _x} foreach (magazines player);

removeUniform player;

removeVest player;

removeBackpack player;

removeGoggles player;

removeHeadGear player;

removeAllAssignedItems player;

//-- Add Gear
player addUniform _uniform;
player addVest _vest;
player addBackpack _backpack;
{player addItemToBackpack _x} forEach _backpackitems;
player addHeadgear _headgear;
player addGoggles _goggles;
{player addItemToUniform _x} forEach _uniformitems;
{player addItemToVest _x} forEach _vestitems;
{player addWeapon _x} forEach _weapons;
{player addPrimaryWeaponItem _x} forEach _primaryweaponitems;
{player addSecondaryWeaponItem _x} forEach _secondaryweaponitems;
{player linkItem _x} forEach _assigneditems;
{player addMagazine _x} forEach _primaryWeaponMagazines;