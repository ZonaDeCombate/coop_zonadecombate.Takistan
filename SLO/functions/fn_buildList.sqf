#define SLO_CLASSLIST 7217

//-- Flush list
lbClear SLO_CLASSLIST;

//-- Build new list
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
