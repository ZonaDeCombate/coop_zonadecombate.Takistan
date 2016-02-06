//-----Logistica R3F --------//
execVM "R3F_LOG\init.sqf";

["INS_HINT_EH",{params [["_text",""]]; hintSilent format["%1",_text]; }] call CBA_fnc_addEventHandler;

// ----------------------------------------------------------------------
if(isServer) then {
	// -------------------------------------------------------------------------------------------------------------
	// override default data 
	// see script/staticData.sqf
	["MISSION INIT - Waiting"] call ALIVE_fnc_dump;
 
	waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};
 
	["MISSION INIT - Continue"] call ALIVE_fnc_dump;
 
	// override static data settings
	call compile (preprocessFileLineNumbers "Scripts\staticData.sqf");
 
	["MISSION INIT - Static data override loaded"] call ALIVE_fnc_dump;
 
	// -------------------------------------------------------------------------------------------------------------
};



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

