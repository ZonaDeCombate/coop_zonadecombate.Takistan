
// clients and servers may run this function
// return global array with data about the current world
// returning array because this function expected to grow in what it provides, thus array is proper


arInfoWorld_MKY = [];

// ** temp ** is a green world even needed ?? is that the default ??
arInfoWorld_MKY = ["green"];

// modify as needed, just remember to lowercase all values
if (isNil "varSandWorlds") then {
	varSandWorlds = ["mountains_acr","shapur_baf","takistan","zargabad","bmfayshkhabur","clafghan","fata","mcn_aliabad","mske","smd_sahrani_a3","pja306","tup_qom","queshkibrul","razani"];
};

if (isNil "varSnowWorlds") then {
	varSnowWorlds = ["klurs_land","pomegratskaya_w","saralite","plr_bulge","vostok_w","bet_hurtgensnow","bet_snowisland","chernarus_winter","utes_winter","thirskw","frankenwinter","wl_wroute191","esseker","anim_helvantis_v2","lostw"];
};

if (isNil "varGreenWorlds") then {
	// worlds that use woodland type camo
	// varGreenWorlds = [];
};

// if (toLower(worldName) in varGreenWorlds) exitWith {arInfoWorld_MKY = ["green"]};
if (toLower(worldName) in varSandWorlds) exitWith {arInfoWorld_MKY = ["sand"]};
if (toLower(worldName) in varSnowWorlds) exitWith {arInfoWorld_MKY = ["snow"]};

