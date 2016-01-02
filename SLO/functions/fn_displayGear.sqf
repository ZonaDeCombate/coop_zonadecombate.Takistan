#define SLO_GEARTITLE 72123
#define SLO_GEARLIST 72124

ctrlShow [SLO_GEARTITLE, true];
lbClear SLO_GEARLIST;

params [["_loadout", nil]];

if (isNil "_loadout") exitWith {
	lbClear SLO_GEARLIST;
	ctrlShow [SLO_GEARTITLE, false];
};

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

private ["_index"];
_index = 0;

//-- Weapons
{
	_configPath = configfile >> "CfgWeapons" >> _x;
	if (isClass _configPath) then {
		_displayName = getText (_configPath >> "displayName");
		_picture = getText (_configPath >> "picture");

		lbAdd [SLO_GEARLIST, _displayName];
		lbSetPicture [SLO_GEARLIST, _index, _picture];
		_index = _index + 1;
	};
} forEach _weapons;

//-- Weapon attachments
_attachments = _primaryweaponitems + _secondaryweaponitems;
{
	_item = _x;
	_configPath = configfile >> "CfgWeapons" >> _item;
	if (isClass _configPath) then {
		_displayName = getText (_configPath >> "displayName");
		_picture = getText (_configPath >> "picture");

		lbAdd [SLO_GEARLIST, _displayName];
		lbSetPicture [SLO_GEARLIST, _index, _picture];
		_index = _index + 1;
	};
} forEach _attachments;

//-- Uniform
_uniformConfigPath = configfile >> "CfgWeapons" >> _uniform;
if (isClass _uniformConfigPath) then {
	_displayName = getText (_uniformConfigPath >> "displayName");
	_picture = getText (_uniformConfigPath >> "picture");

	lbAdd [SLO_GEARLIST, _displayName];
	lbSetPicture [SLO_GEARLIST, _index, _picture];
	_index = _index + 1;
};

//-- Vest
_vestConfigPath = configfile >> "CfgWeapons" >> _vest;
if (isClass _vestConfigPath) then {
	_displayName = getText (_vestConfigPath >> "displayName");
	_picture = getText (_vestConfigPath >> "picture");

	lbAdd [SLO_GEARLIST, _displayName];
	lbSetPicture [SLO_GEARLIST, _index, _picture];
	_index = _index + 1;
};

//-- Headgear
_headgearConfigPath = configfile >> "CfgWeapons" >> _headgear;
if (isClass _headgearConfigPath) then {
	_displayName = getText (_headgearConfigPath >> "displayName");
	_picture = getText (_headgearConfigPath >> "picture");

	lbAdd [SLO_GEARLIST, _displayName];
	lbSetPicture [SLO_GEARLIST, _index, _picture];
	_index = _index + 1;
};

//-- Goggles
if (_goggles != "") then {
	_gogglesConfigPath = configfile >> "CfgGlasses" >> _goggles;
	if (isClass _gogglesConfigPath) then {
		_displayName = getText (_gogglesConfigPath >> "displayName");
		_picture = getText (_gogglesConfigPath >> "picture");

		lbAdd [SLO_GEARLIST, _displayName];
		lbSetPicture [SLO_GEARLIST, _index, _picture];
		_index = _index + 1;
	};
};

//-- Backpack
_backpackConfigPath = configfile >> "CfgVehicles" >> _backpack;
if (isClass _backpackConfigPath) then {
	_displayName = getText (_backpackConfigPath >> "displayName");
	_picture = getText (_backpackConfigPath >> "picture");

	lbAdd [SLO_GEARLIST, _displayName];
	lbSetPicture [SLO_GEARLIST, _index, _picture];
	_index = _index + 1;
};

//-- Backpack items
_itemArray = _uniformitems + _vestitems + _backpackitems + _primaryWeaponMagazines + _assigneditems;
{
	private ["_item","_count","_configPath"];
	_item = _x;
	_count = {_x == _item} count _itemArray;

	if !(_count == 0) then {
		for "_i" from 0 to _count step 1 do {_itemArray = _itemArray - [_item]};

		_configPath = configfile >> "CfgWeapons" >> _item;
		if !(isClass _configPath) then {_configPath = configfile >> "CfgMagazines" >> _item};
		if !(isClass _configPath) then {_configPath = configfile >> "CfgVehicles" >> _item};

		_displayName = getText (_configPath >> "displayName");
		_picture = getText (_configPath >> "picture");
		_itemInfo = format ["%1: %2", _displayName, _count];

		lbAdd [SLO_GEARLIST, _itemInfo];
		lbSetPicture [SLO_GEARLIST, _index, _picture];
		_index = _index + 1;

	};
} forEach _itemArray;

