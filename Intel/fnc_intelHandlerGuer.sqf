/* ----------------------------------------------------------------------------
This function will add three tiers of intel objects near dead bodies of the INDEPENDENT side. This script is best used for asymmetric factions. 

Authors: dixon13 and SpyderBlack723
Modified by: incontinenetia

edit _percentage = X to your preferred percentage chance of the object spawning

edit _intelObject = "XXXXXXXX" to change the object spawned
---------------------------------------------------------------------------- */

///this will temporarily reveal all OPCOM installations within an 800 meter radius

params [["_unit",objNull]]; 
_unit addEventHandler["Killed", {
	params["_unit","_killer"];
        private _percentage = 10;
	if (_percentage > (random 100)) then {
	_pos = [_unit, (random 1), (random 360)] call BIS_fnc_relPos;
        _intelObject = "Land_MobilePhone_old_F" createVehicle _pos; 
        [-1, {
	        _this addAction ["<t color='#FF0000'>Analisar intel</t>",{ 
			_intel = _this select 0;
			deleteVehicle _intel; 
			[getPos _intel,800] call ALIVE_fnc_OPCOMToggleInstallations;
			if ((hasInterface) && !(isDedicated) && (local player) && (side player == WEST)) then { 
				["INS_HINT_EH",["Intel foi encontrado"]] call CBA_fnc_globalEvent; 
			}; 
		}]; 
	}, _intelObject] call CBA_fnc_globalExecute; 
	}; 
}];

sleep 0.1;

///this will temporarily reveal all spawned units on the EAST side

params [["_unit",objNull]]; 
_unit addEventHandler["Killed", {
	params["_unit","_killer"];
        private _percentage = 3;
	if (_percentage > (random 100)) then {
	_pos = [_unit, (random 1), (random 360)] call BIS_fnc_relPos;
        _intelObject = "Land_MobilePhone_smart_F" createVehicle _pos; 
        [-1, {
	        _this addAction ["<t color='#FF0000'>Analisar intel</t>",{ 
			_intel = _this select 0;
			deleteVehicle _intel; 
			call compile preprocessFileLineNumbers "Intel\fnc_intelGuerShort.sqf"; 
			if ((hasInterface) && !(isDedicated) && (local player) && (side player == WEST)) then { 
				["INS_HINT_EH",["Intel foi encontrado"]] call CBA_fnc_globalEvent; 
			}; 
		}]; 
	}, _intelObject] call CBA_fnc_globalExecute; 
	}; 
}];

sleep 0.1;

///this will temporarily reveal all OPCOM installations within a 2000 meter radius

params [["_unit",objNull]]; 
_unit addEventHandler["Killed", {
	params["_unit","_killer"];
        private _percentage = 1;
	if (_percentage > (random 100)) then {
	_pos = [_unit, (random 2), (random 360)] call BIS_fnc_relPos;
        _intelObject = "Land_File1_F" createVehicle _pos; 
        [-1, {
	        _this addAction ["<t color='#FF0000'>Analisar intel</t>",{ 
			_intel = _this select 0;
			deleteVehicle _intel; 
			[getPos _intel,2000] call ALIVE_fnc_OPCOMToggleInstallations;
			if ((hasInterface) && !(isDedicated) && (local player) && (side player == WEST)) then { 
				["INS_HINT_EH",["Intel foi encontrado"]] call CBA_fnc_globalEvent; 
			}; 
		}]; 
	}, _intelObject] call CBA_fnc_globalExecute; 
	}; 
}];