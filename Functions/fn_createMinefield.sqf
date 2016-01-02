params [
	["_pos", [0,0,0]],
	["_radius", 300],
	["_amount", 150],
	["_mines", ["APERSMine","ATMine"]]	//-- ["rhs_mine_pmn2","ATMine"];
];

_createdMines = [];

for "_x" from 0 to _amount do {
	_mineType = _mines call BIS_fnc_selectRandom;
	_mine = createMine [_mineType, _pos, [], _radius];
	_createdMines pushBack _mine;

	_marker = createMarker [str getPos _mine, getPos _mine];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "DOT";
};

_createdMines