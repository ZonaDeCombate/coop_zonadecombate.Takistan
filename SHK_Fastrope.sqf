/*
	SHK_Fastrope by Shuko (LDD Kyllikki)
	Version 1.0

	Inspired by v1g Fast Rope by [STELS]Zealot (modified by TheRick for Altis Life)
  
  Place following into initPlayerLocal.sqf
  
    #include "SHK_Fastrope.sqf"
*/


#define MAX_ALTITUDE_ROPES_AVAIL 70
#define MIN_ALTITUDE_ROPES_AVAIL 5
#define MAX_SPEED_ROPES_AVAIL 50

#define STR_TOSS_ROPES "Lançar cordas"
#define STR_FAST_ROPE "Decida tática"
#define STR_CUT_ROPES "Cortar cordas"

#define STR_JOIN_QUEUE_HINT "Você está na fila para a decida tática."

// ["ClassName",["Door_L","Door_R"],[[ropeAttachPosition1],[ropeAttachPosition2]]]
// Search for the chopper type is done from top to bottom. You can use vehicle base classes,
// but specific vehicles should be at the top because first match is used (which could be base class and not the subclass).
SHK_Fastrope_Helis = [
    // RHS: Armed Forces of Russian Federation
	["RHS_Mi8_base",[],[[0,-3,0]]],
	["RHS_Mi24_base",[],[[1.6,3.3,0],[-0.4,3.3,0]]],
	["RHS_Ka60_grey",[],[[1.4,1.35,0],[-1.4,1.35,0]]],

    //RHS: United States Armed Forces
	["RHS_CH_47F_base",[],[[0,-0.4,0]]],
	["RHS_UH60_base",[],[[1.44,1.93,-0.49]]],
	["RHS_UH1_base",[],[[0.95,3,-0.9],[-0.95,3,-0.9]]],
    
    // Arma 3
	["Heli_Light_01_unarmed_base_F",[],[[1.1,0.5,-0.5],[-1.1,0.5,-0.5]]], //Hummingbird
	["Heli_Transport_01_base_F",["door_L","door_R"],[[-1.01,2.5,0.25],[1.13,2.5,0.25]]], //Ghost Hawk
	["Heli_Transport_03_base_F",["Door_rear_source"],[[-1.35,-4.6,-0.5],[1.24,-4.6,-0.5]]], //Huron  Side doors: "Door_L_source","Door_R_source"
	["I_Heli_Transport_02_F",["CargoRamp_Open"],[[0,-5,0]]], //Mohawk
	["Heli_light_03_base_F",[],[[0.95,3,-0.9],[-0.95,3,-0.9]]], //Hellcat
	["Heli_Attack_02_base_F",["door_L","door_R"],[[1.3,1.3,-0.6],[-1.3,1.3,-0.6]]], //Kajman
	["Heli_Light_02_base_F",[],[[1.35,1.35,0],[-1.45,1.35,0]]], //Orca
	["O_Heli_Transport_04_covered_F",["Door_4_source","Door_5_source"],[[1.3,1.3,-0.1],[-1.5,1.3,-0.1]]], //Taru covered
	["O_Heli_Transport_04_bench_F",["Door_4_source","Door_5_source"],[[1.3,0.15,-0.1],[-1.5,0.15,-0.1]]] //Taru bench underneath

    
];

// Check if the player is allowed to drop the ropes
// Conditions: chopper speed low enough, no ropes attached yet, chopper altitude between given values
SHK_Fastrope_fnc_canCreate = {
	private ["_heli","_alt","_flag"];
	_heli = objectParent player;
	_alt = getPosATL _heli select 2;
	_flag = (_alt < MAX_ALTITUDE_ROPES_AVAIL) && (_alt > MIN_ALTITUDE_ROPES_AVAIL) && ((abs (speed _heli)) < MAX_SPEED_ROPES_AVAIL) && (count (_heli getVariable ["SHK_Fastrope_Ropes",[]]) == 0) && (_heli getCargoIndex player >= 0);
	_flag
};

// Check if the player is allowed to fastrope down
// Conditions: ropes attached to chopper, player is not in the queue, chopper altitude low enough, player in the cargo of the chopper
SHK_Fastrope_fnc_canFastrope = {
  private ["_heli","_alt","_flag"];
  _heli = objectParent player;
  _alt = getPosATL _heli select 2;
  _flag = (!(player in (_heli getVariable ["SHK_Fastrope_Queue",[]])) && (count (_heli getVariable ["SHK_Fastrope_Ropes",[]]) > 0) && (_alt < MAX_ALTITUDE_ROPES_AVAIL) && _heli getCargoIndex player > -1);
  _flag
};

SHK_Fastrope_fnc_createRopes = {
	params ["_heli","_ropesPos","_ropesObj","_rope"];
	
	_heli = objectParent player;
	_ropesPos = _heli getVariable ["SHK_Fastrope_Ropes",[]];
	
	// Ropes already exist
	if (count _ropesPos > 0) exitWith {};
	
	{
      if (_heli isKindOf (_x select 0)) exitWith {
			// Open doors
			{
				_heli animateDoor [_x,1];
			} forEach (_x select 1);
			
			// Rope attach positions
			_ropesPos = (_x select 2);
		};
	} forEach SHK_Fastrope_Helis;

	// Create ropes
	_ropesObj = [];
	{
		_rope = ropeCreate [_heli, _x, (getPosATL player select 2) + 3];
		_ropesObj pushBack _rope;
	} forEach _ropesPos;
	
	_heli setVariable ["SHK_Fastrope_Ropes", _ropesObj, true];
	_heli setVariable ["SHK_Fastrope_Queue", [], true];
	
	// Destroy ropes if chopper moves too fast
	_heli spawn {
		params ["_heli","_ropes"];
		waitUntil {_ropes = (_heli getVariable ["SHK_Fastrope_Ropes",[]]); abs (speed _heli) > MAX_SPEED_ROPES_AVAIL || (count _ropes == 0)};
		
		// Ropes already removed by call from addAction
		if (count _ropes > 0) then {
			_heli call SHK_Fastrope_fnc_cutRopes;
		};
	};
};

SHK_Fastrope_fnc_cutRopes = {
	private ["_heli","_ropes"];

	_heli = _this;
    
	// Function is called from addAction without helicopter parameter, use the chopper player is in.
	if (_this isEqualType []) then {
		_heli = objectParent player;
	};
	
	_ropes = _heli getVariable ["SHK_Fastrope_Ropes",[]];
	{
		ropeCut [_x,0];
	} forEach _ropes;
	
	_heli setVariable ["SHK_Fastrope_Ropes", [], true];
	_heli setVariable ["SHK_Fastrope_Queue", [], true];
	
	// Close doors
	{
		if (_heli isKindOf (_x select 0)) exitWith {
			{
				_heli animateDoor [_x,0];
			} forEach (_x select 1);
		};
	} forEach SHK_Fastrope_Helis;	
};

SHK_Fastrope_fnc_fastRope = {
	params ["_unit","_rope"];
	
	[_unit,_rope] spawn { // Wait for the unit to be move out of the chopper.
		params ["_unit","_rope","_ropePos","_heli"];
		_heli = objectParent _unit;
		
		waitUntil {isNull objectParent _unit};
		if (local _unit) then {
			_unit allowDamage false;
			_unit leaveVehicle _heli;
			_ropePos = (ropeEndPosition _rope) select 0;
			_unit setPosATL [(_ropePos select 0),(_ropePos select 1),(_ropePos select 2)-2];
			_unit switchMove "LadderRifleStatic";
			_unit setDir ([_heli,_unit] call BIS_fnc_dirTo);
			//_unit setDir (_unit getDir _heli); // Arma 3 version 1.55+
			_unit spawn  {
				params ["_unit"];
				while {alive _unit && (((getPos _unit) select 2) > 1.5)} do {
					_unit setVelocity [0,0,-8];
				};
				_unit setVelocity [0,0,0];
				_unit playMove "LadderRifleDownOff";
				_unit allowDamage true;
			};
		};
	};
	
    moveOut _unit;
	
	sleep 1.3;
};

SHK_Fastrope_fnc_processQueue = {
	params ["_heli","_queue","_ropes","_count","_rope",["_i",0]];
	
	_heli = objectParent player;
	_queue = _heli getVariable ["SHK_Fastrope_Queue",[]];
	_ropes = _heli getVariable ["SHK_Fastrope_Ropes",[]];
	_count = count _ropes;

	waitUntil {_queue find player == 0};
	hintSilent "";
	
	{
		// Player or an AI in player's group
		if (_x == player || (group _x == group player && !isPlayer _x)) then {
			_queue = _queue - [_x];
			if (_count > 0) then {
				if (_count == 2) then {
					_rope = _ropes select _i;
					if (_i == 0) then {	_i = 1 } else { _i = 0 };
				} else {
					_rope = _ropes select 0;
				};
				[_x,_rope] call SHK_Fastrope_fnc_fastRope;
			};
		};
	} forEach _queue;
	
	_heli setVariable ["SHK_Fastrope_Queue", _queue, true];
};

SHK_Fastrope_fnc_queueUp = {
	params ["_heli","_queue"];
	
	_heli = objectParent player;
	_queue = _heli getVariable ["SHK_Fastrope_Queue",[]];
	
	_queue pushBack player;
	hintSilent STR_JOIN_QUEUE_HINT;
	
	// If the player is a group leader, queue up his subordinate AIs
	if (player == leader group player) then {
		{
			if (!isPlayer _x && vehicle _x == vehicle player) then {
				_queue pushBack _x;
			};
		} forEach (units group player);
	};
	
	_heli setVariable ["SHK_Fastrope_Queue", _queue, true];
	
	_heli spawn SHK_Fastrope_fnc_processQueue;
};

player addAction["<t color='#ffff00'>"+STR_TOSS_ROPES+"</t>", SHK_Fastrope_fnc_createRopes, [], -1, false, false, '','call SHK_Fastrope_fnc_canCreate'];
player addAction["<t color='#ff0000'>"+STR_CUT_ROPES+"</t>", SHK_Fastrope_fnc_cutRopes, [], -1, false, false, '','count (objectParent player getVariable ["SHK_Fastrope_Ropes",[]]) > 0'];
player addAction["<t color='#00ff00'>"+STR_FAST_ROPE+"</t>", SHK_Fastrope_fnc_queueUp, [], 15, false, false, '','call SHK_Fastrope_fnc_canFastrope'];