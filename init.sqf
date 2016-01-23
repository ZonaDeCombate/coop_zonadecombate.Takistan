CHHQ_showMarkers = true;
execVM "R3F_LOG\init.sqf";

// test MKY sand EFX v003

// examples

/*
	1 - create global array
	2 - initialize the script

	MKY_arSandEFX = [];
	nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";

	RESULT - effect runs with default parameters (random strength)
*/

/*
	1. create global array and populate with some options
	2 - initialize the script

	MKY_arSandEFX = [0,"",true,false,true,true,true,1];
	nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";

	RESULT - effect runs with user defined parameters
*/

/*
	1 - create a mechanism that, through code, sets global array values
	2 - initialize the script

	if ((some value) != 4) then {
		MKY_arSandEFX = [0,"",true,false,true,true,true,1];
		nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
	};

*/

/*
	1 - create a mechanism that, through code, sets array values using mission parameters
	2 - initialize the script

	if ((paramsArray select 0) != 4) then {
		MKY_arSandEFX = [0,"",true,false,true,true,true,(paramsArray select 0)];
		nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
	};

	Or, if the mission maker wants something else, it might look like this:

	if ((paramsArray select 0) != 4) then {
		MKY_arSandEFX = []; // set as default
		switch (paramsArray select 0) do {
			case 0: {MKY_arSandEFX = [0,.8,true,true];};
			case 1: {MKY_arSandEFX = [0,"",true,false,true,true,true,1];};
			case 2: {MKY_arSandEFX = [0,.3,true,false,true,true,false,2];};
			case 3: {MKY_arSandEFX = [[0.23,0.021,100],"",true,false,true,true,true,3];};
		};
		nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
	};
*/

// the example below will work in single player and will create a "light" effect.
// if the mission is loaded as multiplayer coop, the option would be available at mission start.
// whatever value was chosen would be used.

if ((paramsArray select 0) != 4) then {
	// define the global sand parameter array
	//[fog,overcast,use ppEfx,allow rain,force wind,vary fog,use wind audio,EFX strength]
	MKY_arSandEFX = [0,"",true,false,true,true,true,(paramsArray select 0)];
	// init the EFX scripts
	nul = [] execVM "MKY\MKY_Sand_Snow_Init.sqf";
};

// Iniciando sistema de animações
call compile preprocessFileLineNumbers "ShoterAnimation\init.sqf";

//HandlessClient Inicialização
if (!hasInterface && !isDedicated) then {
  headlessClients = [];
  headlessClients pushBack player;
  publicVariable "headlessClients";
  isHC = true;
};

execVM "briefing.sqf";

//-- Initalize Spyder tasking system
["rhs_faction_usmc_d","LOP_ISTS"] execVM "SpyderTasking\init.sqf";


//-- Initialize Spyder civilian interraction
["init",["WEST","LOP_ISTS"]] call SCI_fnc_civilianInteraction;

//-- Initialize Spyder Ambiance
[true, true, 30, ["TAOR_US"], false] execVM "SpyderAmbiance\init.sqf";

//-- Spyder Framework
call compile preprocessFileLineNumbers "SpyderFramework\init.sqf";

//-- Change opcom settings
execVM "Scripts\ALiVESettings.sqf";


//TODO: Não tá funcionando direito. Rever.
/*if (! isDedicated) then
{

  zc_fnc_setRating = {
    _setRating = _this select 0;
    _unit = _this select 1;
    _getRating = rating _unit;
    _addVal = _setRating - _getRating;
    _unit addRating _addVal;
  };

  waituntil {
    _score = rating player;

    if (_score < 0) then {
      [0,player] call zc_fnc_setRating;
      hint parseText format["<t color='#ffff00'>Atenção %1: </t><br/>*** Evite ferir aliados e civis. ***",name player];
    };
    sleep 0.4;
    false
  };
};*/

waituntil {(player getvariable ["alive_sys_player_playerloaded",false])};

