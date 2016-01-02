if (!isServer) exitWith {};

private ["_opcom","_weapons"];

waitUntil {!isNil "ALiVE_REQUIRE_INITIALISED"};

//-- Change opcom settings
_opcom = ["rhs_faction_usmc_wd"] call SF_fnc_getOpcoms;
if (count _opcom > 0) then {
	_opcom = _opcom select 0;
	[_opcom, "simultanobjectives",2] call ALiVE_fnc_HashSet;
	[_opcom, "reinforcements",.95] call ALiVE_fnc_HashSet;
};

//-- Set civilian weapons
_civilianFaction = "LOP_TAK_Civ";
_pistols = [["rhs_weap_makarov_pmm","rhs_mag_9x18_12_57N181S"]];

_RHS = configfile >> "CfgWeapons" >> "rhs_weap_ak74";
_HLCAKPack = configfile >> "CfgWeapons" >> "hlc_ak_base";

if (isClass _RHS) then {
	_weapons = [["rhs_weap_akms","rhs_30Rnd_762x39mm"],["rhs_weap_akm","rhs_30Rnd_762x39mm"]] + _pistols;
};

if (isClass _HLCAKPack) then {
	_weapons = [["hlc_rifle_ak74_dirty","hlc_30Rnd_545x39_B_AK"],["hlc_rifle_aks74","hlc_30Rnd_545x39_B_AK"],["hlc_rifle_akm","hlc_30Rnd_762x39_b_ak"],["hlc_rifle_aks74u","hlc_30Rnd_545x39_B_AK"]];
	if (isClass _RHS) then {
		_weapons = _weapons + _pistols;
	};
};

[ALIVE_civilianWeapons, _civilianFaction, _weapons] call ALIVE_fnc_hashSet;