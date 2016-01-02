//-- Clear any existing data
lbClear 576;

//-- Get currently selected unit
_class = lbData [574, lbCurSel 574];

//-- Get config entry
_configClass = configfile >> "CfgVehicles" >> _class;
_weapons = getArray (_configClass >> "weapons");
_magazines = getArray (_configClass >> "magazines");
_items = getArray (_configClass >> "Items");

//-- Populate weapons and items
{
	if !((_x == "Throw") or (_x == "Put")) then {
		_text = getText (configfile >> "CfgWeapons" >> _x >> "displayName");
		lbAdd [576, _text];
	};
} forEach _weapons + _items;

//-- Populate magazines
{
	_item = _x;
	_count = {_x == _item} count _magazines;
	if (_count > 0) then {
		for "_i" from 0 to _count step 1 do {_magazines = _magazines - [_item]};

		_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName");
		_magazineInfo = format ["%1: %2", _displayName,_count];
		lbAdd [576,_magazineInfo];
	};
} forEach _magazines;
