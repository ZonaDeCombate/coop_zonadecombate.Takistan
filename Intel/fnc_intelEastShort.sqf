/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_markUnits

Author: ARJay
Modified by: incontinenetia

This script will temporarily mark all spawned units on the EAST side. 
---------------------------------------------------------------------------- */


private ["_m","_markers","_delay"];

[] spawn {

	_markers = [];
	_delay = 10;
	
	{
		_m = createMarkerLocal [str _x, position _x];
		_m setMarkerSizeLocal [.6,.6];
		_markers set [count _markers, _m];
        
		switch (side _x) do {
			case east: {
				_m setMarkerTypeLocal "o_unknown";
				_m setMarkerColorLocal "ColorOPFOR";
			};
		};
        
        if (isPlayer _x) then {
			_m setMarkerColorLocal "ColorBlack";
        };
	} forEach allUnits;

	_i = 1;
	waitUntil {
		sleep .75;
		_i = _i - .025;
		if (_i > 0) then {
			{
				_x setMarkerAlphaLocal _i;
			} forEach _markers;
		} else {
			{
				deleteMarkerLocal _x;
			} forEach _markers;
			true;
		};
	};
};