params ["_classname"];

#define VH_INFOBOX 7208
#define VH_PICTUREBOX 7207

//-- Clear Vehicle Info
lbClear VH_INFOBOX;

//-- Get config
_veh = configfile >> "CfgVehicles" >> _classname;

//-- Get picture
_vehPic = getText (_veh >> "picture");
ctrlSetText [7207, _vehPic];

//-- Get speed
_vehSpeed = getNumber (_veh >> "maxSpeed");
_vehSpeed = format ["Top Speed: %1", _vehSpeed];
lbAdd [VH_INFOBOX, _vehSpeed];

//-- Get armor
_vehArmor = getNumber (_veh >> "armor");
_vehArmor = format ["Armor: %1", _vehArmor];
lbAdd [VH_INFOBOX, _vehArmor];

//-- Get fuel
_vehFuel = getNumber (_veh >> "fuelCapacity");
_vehFuel = format ["Fuel Capacity: %1", _vehFuel];
lbAdd [VH_INFOBOX, _vehFuel];

//-- Get passenger seats
_vehCargo = getNumber (_veh >> "transportSoldier");
_vehCargo = format ["Passenger Seats: %1", _vehCargo];
lbAdd [VH_INFOBOX, _vehCargo];