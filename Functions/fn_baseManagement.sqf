params ["_operation"];

switch (_operation) do {
	case "create": {
		//-- Get objective name
		_objectiveName = ctrlText 828;

		//-- Create ALiVE objective on server
		[[[player,_objectiveName],{
			params ["_player","_objectiveID"];
			_objectiveID = [_objectiveID, " ", ""] call CBA_fnc_replace;

			_objectiveParams = [_objectiveID, getPos _player, 200,"MIL"];
			{
				[_x, "addObjective", _objectiveParams] call ALiVE_fnc_OPCOM;
			} forEach OPCOM_INSTANCES;
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;

		//-- Create location
		[[[player,_objectiveName] ,{
			params ["_player","_name"];
			_pos = getPos _player;

			_location = createLocation ["StrongpointArea", _pos, 200, 200];
			_location setText _name;

			if (isServer) then {
				_spawnPos = [side _player, _pos] call BIS_fnc_addRespawnPosition;
				_location setVariable ["RespawnPosition", _spawnPos];
			};

			if (!isNil "Spyder_UserMadeLocations") then {Spyder_UserMadeLocations pushBack _location} else {Spyder_UserMadeLocations = [_location]};
		}],"BIS_fnc_spawn",true] call BIS_fnc_MP;
	};
	case "delete": {
		//-- Get objective name
		_objectiveName = ctrlText 828;

		//-- Delete ALiVE objective
		[[[_objectiveName],{
			params ["_objectiveID"];
			_objectiveID = [_objectiveID, " ", ""] call CBA_fnc_replace;

			{
				[_x, "removeObjective", _objectiveID] call ALiVE_fnc_OPCOM;
			} forEach OPCOM_INSTANCES;
		}],"BIS_fnc_spawn",false] call BIS_fnc_MP;

		//-- Delete location
		[[[_objectiveName],{
			if (isNil "Spyder_UserMadeLocations") exitWith {};
			params ["_name"];

			//-- Delete location
			{
				_location = _x;
				if (text _location == _name) then {
					if (isServer) then {
						_spawnPos = _location getVariable "RespawnPosition";
						_spawnPos call BIS_fnc_removeRespawnPosition;
					};

					Spyder_UserMadeLocations = Spyder_UserMadeLocations - [_location];
					deleteLocation _location;
				};
			} forEach Spyder_UserMadeLocations;
		}],"BIS_fnc_spawn",true] call BIS_fnc_MP;
	};
};