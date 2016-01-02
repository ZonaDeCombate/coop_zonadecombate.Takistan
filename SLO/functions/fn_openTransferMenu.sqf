#define SLO_MAINCONTROLS allControls findDisplay 721;
#define SLO_UNITLIST 7199

disableSerialization;

_slotNum = format ['%1', [lbCurSel 7217] select 0];
_loadout = profileNamespace getVariable format ['SLOLoadout_%1',_slotNum];
if (isNil "_loadout") exitWith {hint "A classe selecionada não tem loadout salvou a ele"};
SLO_TransferLoadout = _loadout;

{
	ctrlShow [_x, false];
} forEach SLO_MAINCONTROLS;

CreateDialog "SLO_TransferLoadout";

_localPlayerName = name player;
_playerSide = playerSide;
_squad = [];
{
	if (!isPlayer _x) then {_squad pushBack _x};
} forEach units group player;

_index = 0;
{
	_unit = _x;
	_name = name _unit;

	if (side _unit == _playerSide) then {
		if (_name != _localPlayerName) then {
			lbAdd [SLO_UNITLIST, _name];
			lbSetData [SLO_UNITLIST, _index, _name];
			_index = _index + 1;
		};
	};
} forEach allPlayers + _squad;
