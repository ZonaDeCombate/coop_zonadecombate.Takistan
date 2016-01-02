params [["_delay", 600 + (random 1200)]];

[ST_Logic, "Skip", true] call ALiVE_fnc_hashSet;
_handler = [{
	
	//-- Skip instantly executed loop
	if (!isNil {[ST_Logic, "Skip"] call ALiVE_fnc_hashGet}) exitWith {[ST_Logic, "Skip", nil] call ALiVE_fnc_hashSet};

	//-- Create task
	switch (str (floor random 3)) do {
		case "0": {[] spawn ST_fnc_taskDefense};	
		case "1": {[] spawn ST_fnc_taskAttack};			
		case "2": {[] spawn ST_fnc_taskEngage};			
	};

	//-- Remove perFrameHandler
	_handler = [ST_Logic, "perFrameID"] call ALiVE_fnc_hashGet;
	[_handler] call CBA_fnc_removePerFrameHandler;


}, _delay, []] call CBA_fnc_addPerFrameHandler;
[ST_Logic, "perFrameID", _handler] call ALiVE_fnc_hashSet;





/* ---------
		//-- Replace taskset with this once IED's are fixed
		case "0": {[] spawn ST_fnc_taskIED};
		case "1": {[] spawn ST_fnc_taskDefense};
		case "2": {[] spawn ST_fnc_taskAttack};
		case "3": {[] spawn ST_fnc_taskEngage};
--------- */