//-- Example: this addAction ["Solicitação de Serviço", "[_object, _size, _delay] execVM 'Scripts\serviceVehicle.sqf'"];
params [
	["_object", objNull],
	["_size", 15],
	["_delay", 10]
];
private ["_position"];

//-- Exit if improper params
if (_object isEqualTo objNull) exitWith {hint "Nenhum objeto foi criado para definir o ponto de serviço"};

//-- Get position
switch (typeName _object) do {
	case "OBJECT": {_position = getPos _object};
	case "STRING": {_position = getMarkerPos _object};
	case "ARRAY": {_position = _object};
};

//-- Get nearest vehicle
_vehicles = nearestObjects [_position, ["AllVehicles"], _size];
if (count _vehicles == 0) exitWith {hint "Nenhum veículo estão perto do ponto de serviço"};

//-- Notify player that process is complete
titleText ["Manutenção do veículo começou", "PLAIN", .2];

//-- Empty vehicles
{
	_vehicle = _x;
	{
		doGetOut _x;
	} forEach crew _vehicle;

	waitUntil {crew _vehicle isEqualTo []};
	_vehicle setVehicleLock "LOCKED";
} forEach _vehicles;

//-- Service delay
sleep _delay;

//-- Repair vehicle
{
	_vehicle = _x;

	_vehicle setDamage 0;
	_vehicle setFuel 1;

	[[[_vehicle],{
		params ["_vehicle"];
		_vehicle setVehicleAmmoDef 1;
	}],"BIS_fnc_spawn",_vehicle,true,false] call BIS_fnc_MP;

	_vehicle setVehicleLock "UNLOCKED";
} forEach _vehicles;

//-- Notify player that process is complete
titleText ["Vehicle servicing complete", "PLAIN", .2];