/*
	m0nkey sand and snow EFX script
	v003 - 1/19/16

	to use:
	in init.sqf, on your condition of whether to use the sand EFX or not,
	define a global variable with parameters for the sand and snow EFX
	(see respective client scripts for syntax)

	examples:
	MKY_arSandEFX = [0,"",true,false,true,true,true,1];
	MKY_arSnowEFX = [[0.23,0.047,15],0.8,true];

	then, execute this script, like this
	nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";

	dedicated servers do not need MKY_arSandEFX/MKY_arSnowEFX arrays

	do NOT place in the initServer or initPlayerLocal files please

	here is a working example

	if (someVariable != 4) then {
		// define the global sand and snow parameter arrays
		MKY_arSandEFX = [0,"",true,false,true,true,true,1];
		MKY_arSnowEFX = [[0.23,0.047,15],0.8,true];
		// init the EFX scripts
		nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
	};

*/

// does the global data array exist?
if (isNil "arInfoWorld_MKY") then {
	nul = [] execVM "MKY\fnc\MKY_fnc_getInfoWorld.sqf";
	waitUntil {sleep 0.1; !(isNil "arInfoWorld_MKY")};
};

// is this a JIP client ?
if (!isServer && isNull player) then {
	waitUntil {sleep 1;!(isNull player)};
	JIP_varSandData = [player];
	publicVariableServer "JIP_varSandData";
};

// only servers execute this
if (isServer) then {
	if ((arInfoWorld_MKY select 0) == "sand") exitWith {nul = [] execVM "MKY\sand\MKY_Sand_Server.sqf";};
};

// any machine with an interface executes this
if (hasInterface) then {
	0 = [] spawn {

		if ((arInfoWorld_MKY select 0) == "sand") exitWith {
			waitUntil {sleep 5;!(isNil "varEnableSand")};
			if (isNil "MKY_arSandEFX") exitWith {true;};
			0 = MKY_arSandEFX execVM "MKY\sand\MKY_Sand_Client.sqf";
		};

	};
};
