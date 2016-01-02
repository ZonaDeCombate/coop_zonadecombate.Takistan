//-- Add insurgency menu
execVM "Scripts\addInsurgencyMenu.sqf";

//-- Create locations for ALiVE custom objectives
//execVM "Scripts\createLocations.sqf";

// Falantes na Base
while {true} do {
    [] execVM "Scripts\loudspeakers.sqf";
    sleep 400;
};
