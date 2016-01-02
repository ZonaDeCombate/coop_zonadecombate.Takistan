_anim = [];

_animation = [
			"HubSittingChairA_move1",
			"HubSittingChairB_move1",
			"HubSittingChairC_move1",
			"HubSittingChairUA_move1",
			"HubSittingChairUB_move1",
			"HubSittingChairUC_move1"
		] call BIS_fnc_selectRandom ;
		switch _animation do {
			case "HubSittingChairA_move1" : {
				_anim = [
					"HubSittingChairA_move1",
					"HubSittingChairA_idle1",
					"HubSittingChairA_idle2",
					"HubSittingChairA_idle3"
				] ;
			} ;
			case "HubSittingChairB_move1" : {
				_anim = [
					"HubSittingChairB_move1",
					"HubSittingChairB_idle1",
					"HubSittingChairB_idle2",
					"HubSittingChairB_idle3"
				] ;
			} ;
			case "HubSittingChairC_move1" : {
				_anim = [
					"HubSittingChairC_move1",
					"HubSittingChairC_idle1",
					"HubSittingChairC_idle2",
					"HubSittingChairC_idle3"
				] ;
			} ;
			case "HubSittingChairUA_move1" : {
				_anim = [
					"HubSittingChairUA_move1",
					"HubSittingChairUA_idle1",
					"HubSittingChairUA_idle2",
					"HubSittingChairUA_idle3"
				] ;
			} ;
			case "HubSittingChairUB_move1" : {
				_anim = [
					"HubSittingChairUB_move1",
					"HubSittingChairUB_idle1",
					"HubSittingChairUB_idle2",
					"HubSittingChairUB_idle3"
				] ;
			} ;
			case "HubSittingChairUC_move1" : {
				_anim = [
					"HubSittingChairUC_move1",
					"HubSittingChairUC_idle1",
					"HubSittingChairUC_idle2",
					"HubSittingChairUC_idle3"
				] ;
			} ;
		};
player globalChat format ["abc %1", _anim];
_anim = _anim + ["AcrgPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon_getOutLow"];
_anim = _anim + ["AmovPercMstpSnonWnonDnon"];
_anim
