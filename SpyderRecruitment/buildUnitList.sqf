private ["_factions"];
_factions = _this;

//-- Get infantry units that belong to passed factions
_units = "(
	((getText (_x >> 'faction')) in _factions) and
	{(configName _x) isKindOf 'Man' and
	{!((getText (_x >> '_generalMacro') == 'B_Soldier_base_F'))
}})" configClasses (configFile >> "CfgVehicles");

//-- Build list with retrieved units
{
	lbAdd [574, (getText (_x >> "displayName"))];
	lbSetData [574, _forEachIndex, configName _x];
} forEach _units;

//-- Attach eventHandler to list
//-- Track group list selection
(findDisplay 570 displayCtrl 574)  ctrlAddEventHandler ["LBSelChanged","
	[] execVM 'SpyderRecruitment\updateGear.sqf';
"];