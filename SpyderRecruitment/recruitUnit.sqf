private ["_locality","_arguments"];
_locality = _this select 0;

switch (toLower (_locality)) do {

	//-- Get data from client and execute file on server
	case "client": {
		//-- Get selected unit
		_classname = lbData [574, lbCurSel 574];

		[[["server", [_classname, player]], "SpyderRecruitment\recruitUnit.sqf"], "BIS_fnc_execVM", false] call BIS_fnc_MP;
		
	};

	//-- Recieve client-sent data and create unit on server
	case "server": {
		private ["_arguments"];
		_arguments = _this select 1;
		_arguments params ["_classname","_player"];
	
		//-- Create unit
		_unit = (group _player) createUnit [_classname, position _player, [], 15, "FORM"];
	};
	
};