_animation = [
			"HubStandingUA_move1",
			"HubStandingUB_move1",
			"HubStandingUC_move1"
		] call BIS_fnc_selectRandom ;
_selected = [];
if(_animation isEqualTo "HubStandingUA_move1") then
{
	_selected = [
	"HubStandingUA_move1",
	"HubStandingUA_move2",
	"HubStandingUA_idle1",
	"HubStandingUA_idle2",
	"HubStandingUA_idle3",
	"AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon",
	"AmovPercMstpSnonWnonDnon"
	];
};

if(_animation isEqualTo "HubStandingUB_move1") then
{
	_selected = [
	"HubStandingUB_move1",
	"HubStandingUB_idle1",
	"HubStandingUB_idle2",
	"HubStandingUB_idle3",
	"AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon",
	"AmovPercMstpSnonWnonDnon"
	];
};

if(_animation isEqualTo "HubStandingUC_move1") then
{
	_selected = [
	"HubStandingUC_move1",
	"HubStandingUC_move2",
	"HubStandingUC_idle1",
	"HubStandingUC_idle2",
	"HubStandingUC_idle3",
	"AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWrflDnon",
	"AmovPercMstpSnonWnonDnon"
	];
};

_selected