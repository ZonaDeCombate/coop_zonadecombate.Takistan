/*  
=========================================================
Based on Simple Vehicle Respawn Script v1.6
by Tophe of �stg�ta Ops [OOPS]

Put this in the vehicles init line:
veh = [this, Delay] execVM "respawn.sqf"

Default respawn delay is 30 seconds, to set a custom
respawn delay time, put that in the init as well. 
Like this:
veh = [this, 15] execVM "respawn.sqf"

=========================================================
*/

private ["_hasname","_delay","_unit","_weapons","_mags","_unitname","_dir","_position","_type","_max","_run"];
if (!isServer) exitWith {};

// Define variables
_unit = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {30};

_hasname = false;
_unitname = vehicleVarName _unit;
if (_unitname == "") then {_hasname = false;} else {_hasname = true;};
_run = true;

if (_delay < 0) then {_delay = 0};

_dir = getDir _unit;
_position = getPosASL _unit;
_type = typeOf _unit;
_weapons = getWeaponCargo _unit;
_mags = getMagazineCargo _unit;

// Start monitoring the vehicle
while {_run} do {	
		sleep _delay;		
		if(getPosASL _unit distance _position > 10) then {
			_unit = _type createVehicle _position;
			_unit setPosASL _position;
			_unit setDir _dir;
			if (_hasname) then {
					_unit setVehicleVarName _unitname;
			};
		};
        clearWeaponCargo _unit;
        clearMagazineCargo _unit;
        
        _max = count(_weapons select 0);
        for "_i" from 0 to _max do {
                _unit addWeaponCargo [(_weapons select 0) select _i, (_weapons select 1) select _i];
        };
        
        _max = count(_mags select 0);
        for "_i" from 0 to _max do {
                _unit addMagazineCargo [(_mags select 0) select _i, (_mags select 1) select _i];
        };        
};
