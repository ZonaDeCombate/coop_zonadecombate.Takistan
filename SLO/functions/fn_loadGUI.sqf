#define SLO_CLASSLIST 7217
#define SLO_GEARTITLE 72123

ctrlShow [SLO_GEARTITLE, false];

for "_i" from 0 to 15 do
{
	_loadout = profileNamespace getVariable format ["SLOLoadout_%1",_i];
	if(!isNil {_loadout select 0}) then {
		lbAdd [SLO_CLASSLIST, _loadout select 0];
	} else {
		_slotName = format ["Loadout %1", _i];
		lbAdd [SLO_CLASSLIST, _slotName];
	};
};

(findDisplay 721 displayCtrl SLO_CLASSLIST)  ctrlAddEventHandler ["LBSelChanged","
	_slotNum = format ['%1', [lbCurSel 7217] select 0];
	_loadout = profileNamespace getVariable format ['SLOLoadout_%1',_slotNum];

	if (!isNil '_loadout') then {
		_slotName = _loadout select 0;
		ctrlSetText [7215, _slotName];
	} else {
		_slotNum = format ['Loadout %1', [lbCurSel 7217] select 0];
		ctrlSetText [7215, _slotNum];
	};

	if (!isNil '_loadout') then {
		[_loadout] call SLO_fnc_displayGear;
		{ctrlEnable [_x, true]} forEach [7218, 7219, 72121, 72125, 72122];
	} else {
		[] call SLO_fnc_displayGear;
		{ctrlEnable [_x, false]} forEach [7218, 7219, 72121, 72125, 72122];
	};
"];


lbSetCurSel [SLO_CLASSLIST,0];