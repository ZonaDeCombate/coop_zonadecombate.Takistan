["AmovPercMstpSnonWnonDnon_exercisePushup",
{
	_soldier = (_this select 0) ;
	if ((_soldier selectionPosition "Head" select 2) <= 0.5) then {
		_soldier switchMove "AinjPpneMstpSnonWnonDnon" ;
	} else {
		_soldier switchMove "AmovPercMstpSnonWnonDnon";
	} ;
}
,
{
	_soldier = _this select 0;
if ((_soldier selectionPosition "Head" select 2) <= 0.5) then {
			if (alive _soldier and primaryWeapon _soldier != "") then {
				_soldier switchMove "AinjPpneMstpSnonWrflDnon_rolltofront" ;
				_soldier playMove "AmovPpneMstpSrasWrflDnon" ;
			} ;
			if (alive _soldier and primaryWeapon _soldier == "") then {
				_soldier switchMove "AinjPpneMstpSnonWnonDnon_rolltofront" ;
				_soldier playMove "AmovPpneMstpSnonWnonDnon" ;
			} ;
		} else {
			if (alive _soldier and primaryWeapon _soldier != "") then {
				_soldier switchMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon" ;
				_soldier playMove "AmovPpneMstpSrasWrflDnon" ;
			} ;
			if (alive _soldier and primaryWeapon _soldier == "") then {
				_soldier switchMove "AmovPercMstpSnonWnonDnon" ;
				_soldier playMove "AmovPpneMstpSnonWnonDnon" ;
			} ;
		};
}
]