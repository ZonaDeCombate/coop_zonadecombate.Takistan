


// init global array to hold wind values
MKY_arWind = [0,[0,-1]];

// server may need to send data to JIP client
"JIP_varSandData" addPublicVariableEventHandler {
	(owner (_this select 0)) publicVariableClient "varFadeIn";
	sleep 1;
	(owner (_this select 0)) publicVariableClient "varEnableSand";
	sleep 1;
	(owner (_this select 0)) publicVariableClient "MKY_arWind";
	sleep 1;
};

// server needs to find a bearing for the wind
MKY_fnc_getWind = {
	private ["_arBearing","_arSigns","_intWindIndex"];
	// array of cardinal bearings
	_arBearing = [0,45,90,135,180,225,270,315];
	// array of signed integers for wind (in order of bearings array)
	_arSigns = [[0,-1],[-1,-1],[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1]];
	// get a wind index value
	_intWindIndex = floor (random (7));
	// set the global/public bearing variable indices
	MKY_arWind set [0,(_arBearing select _intWindIndex)];
	MKY_arWind set [1,(_arSigns select _intWindIndex)];
	(true);
};


0 = [] spawn {
	// get wind details
	0 = [] call MKY_fnc_getWind;
	// publicize the variables for clients
	publicVariable "MKY_arWind";
	sleep 1;
	varEnableSand = true;
	publicVariable "varEnableSand";
};











