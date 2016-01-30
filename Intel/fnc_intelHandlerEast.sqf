/* ----------------------------------------------------------------------------
This function will add intel objects near dead bodies of the EAST side. This script is best used for regular, non-asymmetric forces. 

Authors: dixon13 and SpyderBlack723
Modified by: incontinenetia

edit _percentage = X to your preferred percentage chance of the object spawning

edit _intelObject = "XXXXXXXX" to change the object spawned
---------------------------------------------------------------------------- */

///this will reveal all spawned units on the INDEPENDENT side

params [["_unit",objNull]]; 
_unit addEventHandler["Killed", {
	params["_unit","_killer"];
        private _percentage = 1;
	if (_percentage > (random 100)) then {
	_pos = [_unit, (random 2), (random 360)] call BIS_fnc_relPos;
        _intelObject = "Land_Map_F" createVehicle _pos; 
        [-1, {
	        _this addAction ["<t color='#FF0000'>Pegar Intel</t>",{ 
			_intel = _this select 0;
			deleteVehicle _intel; 
			call compile preprocessFileLineNumbers "Intel\fnc_intelEastShort.sqf"; 
			if ((hasInterface) && !(isDedicated) && (local player) && (side player == WEST)) then { 
				["INS_HINT_EH",["Intel foi encontrado"]] call CBA_fnc_globalEvent; 
			}; 
		}]; 
	}, _intelObject] call CBA_fnc_globalExecute; 
	}; 
}];
