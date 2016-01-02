params ["_classname"];
VH_Logic params ["_position","_direction"];

_veh = _classname createVehicle _position;
_veh setDir _direction;