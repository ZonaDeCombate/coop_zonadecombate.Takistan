params ["_logic","_operation"];

_logicPos = getPos _logic;
_debug = _logic getVariable "Debug";
_animals = _logic getVariable "Herds";
_terrorists = _logic getVariable "Terrorists";

switch (_operation) do {

	//-- Activate
	case "Activate": {

		//-- Create herds
		if (_animals) then {
			_objects = _logic getVariable "Objects";

			//-- Create the herd
			for "_x" from 0 to (floor random 2) step 1 do {
				if (random 100 > 40) then {
					_spawnPos = [_logicPos, 0, 400, 21, 0, 1, 0] call BIS_fnc_findSafePos;	
					_newGroup = createGroup civilian;
					_herdType = ["Goat_Random_F","Sheep_random_F"] call BIS_fnc_selectRandom;
					for "_i" from 0 to 6 + floor(random 12) step 1 do {
						_animal = _newGroup createUnit [_herdType, _spawnPos, [], 20, "NONE"];
						_objects pushBack _animal;
						sleep .2;
					};
					sleep .5;
				};
			};

			_logic setVariable ["Objects", _objects];
		};

		//-- Create Vehicles
		if (_terrorists) then {
			private ["_unit","_seats","_objects"];
			_objects = _logic getVariable "Objects";
			_roads = _logicPos nearRoads 500;
			if (count _roads == 0) exitWith {};

			_unitData = SpyderAmbiance_UnitData;
			_unitData params ["_civType","_vehType","_terroristType"];


			for "_i" from 0 to (floor random 2) step 1 do {
				if (floor random 100 > 50) then {
					_selectedRoad = _roads call BIS_fnc_selectRandom;
					_veh = (_vehType call BIS_fnc_selectRandom) createVehicle (getPos _selectedRoad);
					_objects pushBack _veh;
					sleep .5;
					//-- Create units
					if (floor random 100 > 25) then {
						_group = createGroup civilian;
						_unit = _group createUnit [(_civType call BIS_fnc_selectRandom), getPos _veh, [], 5, "NONE"];
						_unit assignAsDriver _veh;
						_unit moveInDriver _veh;
						_objects pushBack _unit;
						_seats = _veh emptyPositions "cargo";
						if (_seats >= 5) then {_seats  = 2};
						for "_i" from 0 to (floor random _seats) step 1 do {
							_unit = _group createUnit [(_civType call BIS_fnc_selectRandom), getPos _veh, [], 5, "NONE"];
							_unit assignAsCargo _veh;
							_unit moveInCargo _veh;
							_objects pushBack _unit;
							sleep .3;
						};
						_group setBehaviour "CARELESS";

						[_group] spawn {
							params ["_group"];
							_roads = (getPos (leader _group)) nearRoads 800;
							for "_i" from 0 to 4 step 1 do {
								_road = _roads call BIS_fnc_selectRandom;
								if (!isNil "_road") then {
									_wp =_group addWaypoint [getPos _road, 0];
									_wp setWaypointSpeed "Limited";
									if (_i == 4) then {_wp setWaypointType "CYCLE"} else {_wp setWaypointType "MOVE"};
								};
							};
						};
					} else {
						_insurgentSide = [([(getNumber (configfile >> "CfgVehicles" >> (_terroristType call BIS_fnc_selectRandom) >> "side"))] call ALIVE_fnc_sideNumberToText)] call ALIVE_fnc_sideTextToObject;
						_group = createGroup _insurgentSide;
						_unit = _group createUnit [(_terroristType call BIS_fnc_selectRandom), getPos _veh, [], 5, "NONE"];
						_unit assignAsDriver _veh;
						_unit moveInDriver _veh;
						_objects pushBack _unit;
						_seats = _veh emptyPositions "cargo";
						if (_seats >= 6) then {_seats  = floor random 7};
						for "_i" from 0 to (floor random _seats) step 1 do {
							_unit = _group createUnit [(_terroristType call BIS_fnc_selectRandom), getPos _veh, [], 5, "NONE"];
							_unit assignAsCargo _veh;
							_unit moveInCargo _veh;
							_objects pushBack _unit;
							sleep .3;
						};
						_group setBehaviour "CARELESS";
						//-- Create waypoints and attach trigger
						[_group,_debug] spawn {
							_this params ["_group","_debug"];
							_roads = (getPos (leader _group)) nearRoads 800;
							for "_i" from 0 to 4 step 1 do {
								_selectedRoad = _roads call BIS_fnc_selectRandom;
								if (!isNil "_road") then {
									_wp =_group addWaypoint [getPos _selectedRoad, 0];
									_wp setWaypointSpeed "Limited";
									if (_i == 4) then {_wp setWaypointType "CYCLE"} else {_wp setWaypointType "MOVE"};
								};
							};

							waitUntil {({(_x distance2D getPos (leader _group)) < 50} count ([] call BIS_fnc_listPlayers)) > 0};

							//-- Player detected nearby, choose random action
							_action = round(random 6);

							If (_action > 4) then {
								if (_group getVariable "Decided") exitWith {};
								if (_debug) then {["Spyder Ambiance: Flee action chosen"] call ALIVE_fnc_dumpR};
								_group setVariable ["Decided", True];
								_vehicle = vehicle (leader _group);
								_retreatPos = [_vehicle, 300, ((getDir _vehicle) - 180)] call BIS_fnc_relPos;
								(driver (vehicle (leader _group))) doMove _retreatPos;
								_group setCombatMode "BLUE";
								(driver (vehicle (leader _group))) forceSpeed 50;
							};
							
							If (_action == 4) then {
								if (_group getVariable "Decided") exitWith {};
								if (_debug) then {["Spyder Ambiance: VBIED action chosen"] call ALIVE_fnc_dumpR};
								_group setVariable ["Decided", True];
								_leader = leader _group;
								_vehicle = vehicle _leader;
								_targets = [];
								_returnedPlayers = [] call BIS_fnc_listPlayers;
								{
									if (_x distance _vehicle < 65) then {
									_targets pushBack _x;
								};
								} forEach _returnedPlayers; 
								_target = _targets call BIS_fnc_selectRandom;
								[_vehicle,_target] spawn {
									_this params ["_vehicle","_target"];
									waitUntil {sleep 1;(_vehicle distance _target < 15)};
									"Bo_Mk82" createVehicle (getPos _vehicle);
								};
								(driver _vehicle) forceSpeed 60;
								while {(_vehicle distance _target >= 4) && (alive _target)} do {
									sleep 1; 
									(driver _vehicle) domove getposATL _target;
								};
							};
							
							If (_action == 3) then {
								if (_group getVariable "Decided") exitWith {};
								if (_debug) then {["Spyder Ambiance: Surrender action chosen"] call ALIVE_fnc_dumpR};
								_group setVariable ["Decided", True];
								_group setCombatMode "BLUE";
								{
									_x leaveVehicle (vehicle _x);
									waitUntil {vehicle _x == _x};
									_x action ["DROPWEAPON", _x, primaryWeapon _x];
									_x setCaptive true;
									_x switchmove "";
									_x playActionNow "Surrender";
								} foreach units _group;
							};
							
							If (_action < 3) then {
								if (_group getVariable "Decided") exitWith {};
								if (_debug) then {["Spyder Ambiance: Fight action chosen"] call ALIVE_fnc_dumpR};
								_group setVariable ["Decided", True];
								_group setBehaviour "COMBAT";
								_group leaveVehicle (vehicle (leader _group));
							};
							
						};
					};
					sleep .5;
				};
			};

			sleep 1;
			_logic setVariable ["Objects", _objects];

		};

		//-- Activate
		_logic setVariable ["Active", true];
	};

	//-- Deactivate
	case "Deactivate": {

		//-- Delete vehicles (Terrorists)
		params ["_logic"];

		_objects = _logic getVariable "Objects";
		{deleteVehicle _x} forEach _objects;
		_logic setVariable ["Objects", []];



		//-- Deactivate
		_logic setVariable ["Active", false];
	};

};