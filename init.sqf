//SANDSTORM

// define which worlds may use sand EFX
// *** Altis added for testing, its not always a great sand/dust map ***
varSandWorlds = ["mountains_acr","shapur_baf","takistan","zargabad","bmfayshkhabur","clafghan","fata","mcn_aliabad","mske","smd_sahrani_a3","pja306","TUP_Qom","queshkibrul","Razani","altis"];

[] spawn {enableEnvironment false;};

// is this JIP ?
if (!isServer && isNull player) then {
	waitUntil {sleep 1;!(isNull player)};
	JIP_varSnowData = [player];
	publicVariableServer "JIP_varSnowData";
	JIP_varSandData = [player];
	publicVariableServer "JIP_varSandData";
};

// if server option is NOT set to disabled, process further
if ((paramsArray select 0) != 4) then {
	if (isServer) then {
		if !(toLower(worldName) in varSandWorlds) exitWith {true;};
		nul = [] execVM "MKY\sand\MKY_Sand_Server.sqf";
	};
	if (hasInterface) then {
		0 = [] spawn {
			if !(toLower(worldName) in varSandWorlds) exitWith {true;};
			waitUntil {sleep 5;!(isNil "varEnableSand")};
			// call the sand client script, using params array as input for type/strength of the EFX
			// look at MKY_Sand_Client.sqf for details on the parameters 
			0 = [0,"",true,false,true,true,true,(paramsArray select 0)] execVM "MKY\sand\MKY_Sand_Client.sqf";
		};
	};
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

enableSaving [false,false];

//-- Initalize Spyder tasking system
["rhs_faction_usmc_d","LOP_ISTS"] execVM "SpyderTasking\init.sqf";


//-- Initialize Spyder civilian interraction
["init",["WEST","LOP_ISTS"]] call SCI_fnc_civilianInteraction;

//-- Initialize Spyder Ambiance
[true, true, 30, ["TAOR_BLU"], false] execVM "SpyderAmbiance\init.sqf";

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

