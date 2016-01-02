/* ----------------------------------------------------------------------------
Function: SCI_fnc_civilianCommands

Description:
Main handler for civilian commands

Parameters:
String - Operation
Array - Arguments

Returns:
none

Examples:
(begin example)
["Detain"] call SCI_fnc_commandHandler; //-- Detain civ
["getDown"] call SCI_fnc_commandHandler //-- Order civ to get down
["goAway"] call SCI_fnc_commandHandler //-- Order civ to go away
(end)

See Also:
- nil

Author:
SpyderBlack723

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

params [
	["_operation", ""],
	["_arguments", []]
];

//-- Get civilian
if (isNil {[SCI_Logic, "CurrentCivilian"] call ALiVE_fnc_hashGet}) exitWith {};
_civ = [SCI_Logic, "CurrentCivilian"] call ALiVE_fnc_hashGet;

switch (_operation) do {

	//-- Detain
	case "Detain": {
		//-- Function is exactly the same as ALiVE arrest/release --> Author: Highhead
		//Detained Animation:
		//ACE_AmovPercMstpScapWnonDnon - Is there one that doesn't require ACE
		closeDialog 0;

		if !(_civ getVariable ["detained", false]) then {
			//-- Join caller group
			[_civ] joinSilent (group player);
			_civ setVariable ["detained", true, true];
		} else {
			//-- Join civilian group
			[_civ] joinSilent (createGroup civilian);
			_civ setVariable ["detained", false, true];
		};
	};

	//-- Get down
	case "getDown": {
		//-- Command get down
		closeDialog 0;

		[_civ] spawn {
			params ["_civ"];
			sleep 2;
			_civ setUnitPos "DOWN";
			sleep (10 + (ceil random 20));
			_civ setUnitPos "AUTO";
		};
	};

	//-- Go away
	case "goAway": {
		//-- Move to random nearby position
		closeDialog 0;

		[_civ] spawn {
			params ["_civ"];
			sleep 1;
			_fleePos = [position _civ, 30, 50, 1, 0, 1, 0] call BIS_fnc_findSafePos;
			_civ doMove _fleePos;
		};
	};

};