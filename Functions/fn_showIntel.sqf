//-- Only run on server
if (!isServer) exitWith {[_this, "Spyder_fnc_showIntel", false] call BIS_fnc_MP};

params ["_intelItem"];
private ["_objectiveList"];

//-- Delete intel item
_itemPosition = getPos _intelItem;
deleteVehicle _intelItem;

// Exit if OPCOMs are unavailable
if (isnil "OPCOM_instances" || {count OPCOM_instances == 0}) exitwith {};

//-- Get asymmetric objective list
_opcoms = [];
_objectiveList = [];
{
	if (!isNil {_x getVariable "moduleType"}) then {
		if(_moduleType == "ALIVE_OPCOM") then {
			_controlType = _x getVariable "controltype";

			if (_controlType == "asymmetric") then {
				_opcom = _x getVariable "handler";
				_opcoms pushBack _opcom;
				{_objectiveList pushBack _x} forEach ([_opcom,"objectives",[]] call ALiVE_fnc_HashGet);
			};
		};
	};
} forEach (entities "Module_F");

if (count _objectiveList == 0) exitWith {};

//-- Sort objectives for closest
_sortedObjectives = [_objectiveList,[_itemPosition],{_input0 distance ([_x,"center",[0,0,0]] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;

//-- Get installations
_found = 0;
_maxCount = floor random 3;
_markers = [];
for "_i" from 0 to 6 do {
	_objective = _sortedObjectives select _i;

	//-- Don't mark more than two objectives
	if (_found <= 2) then {
		{
			_id = [_objective,"objectiveID"] call ALiVE_fnc_HashGet;
 			_size = [_objective,"size"] call ALiVE_fnc_HashGet;

			//-- Get installations
			_factory = [_x,"convertObject",[_objective,"factory",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_HQ = [_x,"convertObject",[_objective,"HQ",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_ambush = [_x,"convertObject",[_objective,"ambush",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_depot = [_x,"convertObject",[_objective,"depot",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_sabotage = [_x,"convertObject",[_objective,"sabotage",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_ied = [_x,"convertObject",[_objective,"ied",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_suicide = [_x,"convertObject",[_objective,"suicide",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
			_roadblocks = [_x,"convertObject",[_objective,"roadblocks",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;

			//-- Mark installations
			if (alive _HQ && {_found <= _maxCount}) then {_markers append [[format ["hq_%1",_id],getposATL _HQ,"ICON", [0.5,0.5],"ColorRed","HQ Recrutamento", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];_found = _found + 1};
			if (alive _depot && {_found <= _maxCount}) then {_markers append [[format ["depot_%1",_id],getposATL _depot,"ICON", [0.5,0.5],"ColorRed","Depósito de Armas", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];_found = _found + 1};
			if (alive _factory && {_found <= _maxCount}) then {_markers append [[format ["factory_%1",_id],getposATL _factory,"ICON", [0.5,0.5],"ColorRed","Fábrica IED", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];_found = _found + 1};
			if (alive _ambush && {_found <= _maxCount}) then {_markers append [[format ["ambush_%1",_id],getposATL _ambush,"ICON", [0.5,0.5],"ColorRed","Emboscada", "hd_ambush", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal];_found = _found + 1};
			if (alive _sabotage && {_found <= _maxCount}) then {_markers append [[format ["sabotage_%1",_id],getposATL _sabotage,"ICON", [0.5,0.5],"ColorRed","Sabotagem", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];_found = _found + 1};

			if (alive _ied && {_found <= _maxCount}) then {
				_markers append [[format ["ied_%1",_id],getposATL _ied,"ELLIPSE", [_size,_size],"ColorRed","IED", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];
				_markers append [[format ["iedI_%1",_id],getposATL _ied,"ICON", [0.1,0.1],"ColorRed","IED", "mil_dot", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal];
				_found = _found + 1;
			};
			if (alive _suicide && {_found <= _maxCount}) then {
				_markers append [[format ["suicide_%1",_id],getposATL _suicide,"ELLIPSE", [_size,_size],"ColorRed","Homem suicida", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];
				_markers append [[format ["suicideI_%1",_id],getposATL _suicide,"ICON", [0.1,0.1],"ColorRed","Homem suicida", "mil_dot", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal];
				_found = _found + 1;
	       		 };
			if (alive _roadblocks && {_found <= _maxCount}) then {
				_markers append [[format ["roadblocks_%1",_id],getposATL _roadblocks,"ELLIPSE", [_size,_size],"ColorRed","Bloqueio de pista", "n_installation", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];
				_markers append [[format ["roadblocksI_%1",_id],getposATL _roadblocks,"ICON", [0.1,0.1],"ColorRed","Bloqueio de pista", "mil_dot", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal];
				_found = _found + 1;
			};
		} forEach _opcoms;
	};
};

if (count _markers > 0) then {
	_markers spawn {
	    
		waituntil {
			sleep 1;
			{_x setMarkerAlpha ((markeralpha _x)-0.01)} foreach _this;
			markeralpha (_this select 0) < 0.1
		};
	    
		{deletemarker _x} foreach _this;
	};
};