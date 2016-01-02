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



if (! isDedicated) then
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
};

waituntil {(player getvariable ["alive_sys_player_playerloaded",false])};