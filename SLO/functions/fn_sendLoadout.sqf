#define SLO_CLASSLIST 2717
#define SLO_PLAYERLIST 7199

_loadout = SLO_TransferLoadout;

_playerSlot = lbCurSel SLO_PLAYERLIST;
_playerName = lbData [SLO_PLAYERLIST, _playerSlot];
_squad = [];
{
	if (!isPlayer _x) then {_squad pushBack _x};
} forEach units group player;

{
	_unit = _x;

	if (name _unit == _playerName) exitWith {
		if (isPlayer _unit) then {
			[[name player,_loadout], "SLO_fnc_receiveLoadout", owner _unit] call BIS_fnc_MP;
		} else {
			[_unit,_loadout] call SLO_fnc_loadClass;
		};
	};
} forEach allPlayers + _squad;