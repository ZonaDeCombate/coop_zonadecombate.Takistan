/* ----------------------------------------------------------------------------
Author: dixon13
Modified by: incontinenetia
---------------------------------------------------------------------------- */


params[["_unit",objNull]];
if (side _unit == EAST) then { [_unit] call compile preprocessFileLineNumbers "Intel\fnc_intelHandlerEast.sqf"; };
if (side _unit == RESISTANCE) then { [_unit] call compile preprocessFileLineNumbers "Intel\fnc_intelHandlerGuer.sqf"; };