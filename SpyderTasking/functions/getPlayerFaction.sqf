private ["_allFactions","_playerFaction","_count"];

//-- Get factions of all players
_allFactions = [];
{
	_allFactions pushBack (faction _x);
} forEach allPlayers;

//-- Find faction that appears the most
_playerFaction = ["BLU_F", 0];
{
	_faction = _x;
	_count = {_x == _faction} count _allFactions;
	if (_count > (_playerFaction select 1)) then {_playerFaction = [_faction,_count]};
	for "_i" from 0 to _count do {_allFactions = _allFactions - [_faction]};
} forEach _allFactions;

(_playerFaction select 0);