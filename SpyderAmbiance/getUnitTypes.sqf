/////////////////////////-- Manual Unit Selection --/////////////////////////
/*
Use: Manually set the units and vehicles which will be spawned in by Spyder Ambiance

How To: Insert unit classnames into the correct array
	Civilians --> _manCivType
	Terrorists --> _manTerroristType
	Vehicles --> _manVehicleType

Unit classnames must be wrapped in quotes, ex: "C_man_1"

Example arrays:
_manCivType = ["C_man_1", "C_man_polo_1_F", "C_man_polo_3_F"];
_manTerroristType = ["O_Soldier_GL_F","O_soldier_exp_F","O_soldier_M_F"];
_manVehicleType = ["C_Hatchback_01_F","C_Van_01_transport_F","C_SUV_01_F"];
*/
/////////////////////////////////////////////////////////////////////

//-- Custom unit selection
//-- Edit below here !!!!!!!!!!!!!!!!!!!!!!!

_manCivType = [];
_manTerroristType = [];
_manVehicleType = [];

//-- Stop editing here !!!!!!!!!!!!!!!!!!!!!!!


params ["_debug"];
private ["_civType","_vehType","_terroristType","_selectedFaction","_selectedCivilians","_selectedVehicles","_manCivType", "_manTerroristType", "_manVehicleType"];

_middleEastMaps = ["MCN_Aliabad","BMFayshkhabur","clafghan","fallujah","fata","hellskitchen","hellskitchens","MCN_HazarKot","praa_av","reshmaan","Shapur_BAF","Takistan","torabora","TUP_Qom","Zargabad","pja307","pja306","Mountains_ACR","tunba","Kunduz","pja308"];
_africanMaps = ["mak_Jungle","pja305","tropica","tigeria","tigeria_se","Sara","SaraLite","Sara_dbe1","Porto","Intro"];
_europeanMaps = ["Chernarus","Chernarus_Summer","FDF_Isle1_a","mbg_celle2","Woodland_ACR","Bootcamp_ACR","Thirsk","ThirskW","utes","gsep_mosch","gsep_zernovo","Bornholm","anim_helvantis_v2"];
_greakMaps = [];

_civType = [];
_vehType = [];
_terroristType = [];

//-- Leights Opfor Pack
if (isClass (configfile >> "CfgGroups" >> "West" >> "LOP_AA")) then {
	// Middle Eastern
	if (worldName in _middleEastMaps) then {
		_civType = ["LOP_Tak_Civ_Man_01","LOP_Tak_Civ_Man_02","LOP_Tak_Civ_Man_04"];
		_terroristType = ["LOP_AM_Infantry_AT","LOP_AM_Infantry_AR","LOP_AM_Infantry_Corpsman","LOP_AM_Infantry_GL","LOP_AM_Infantry_Engineer","LOP_AM_Infantry_Marksman","LOP_AM_Infantry_Rifleman"];

		_selectedFaction = "Leights Middle East";
		_selectedCivilians = "Leights Middle East";
	};
	// African
	if (worldName in _africanMaps) then {
		_civType = ["LOP_AFR_Civ_Man_01","LOP_AFR_Civ_Man_02","LOP_AFR_Civ_Man_03","LOP_AFR_Civ_Man_04","LOP_AFR_Civ_Man_05","LOP_AFR_Civ_Man_06"];
		_terroristType = ["LOP_AFR_Infantry_AT","LOP_AFR_Infantry_Corpsman","LOP_AFR_Infantry_GL","LOP_AFR_Infantry_IED","LOP_AFR_Infantry_AR","LOP_AFR_Infantry_Marksman","LOP_AFR_Infantry_Rifleman"];

		_selectedFaction = "Leights African";
		_selectedCivilians = "Leights African";
	};
};

//-- RDS European Civilians
if (isClass (configfile >> "CfgVehicles" >> "RDS_Worker")) then {
	if (worldName in _europeanMaps) then {
		_civType = ["RDS_Citizen1","RDS_Citizen2","RDS_Citizen3","RDS_Citizen4","RDS_Profiteer1","RDS_Profiteer2","RDS_Profiteer3","RDS_Villager4","RDS_Worker4","RDS_Worker2"];
	};
	_vehType = ["RDS_Van_01_fuel_F","RDS_Gaz24_Civ_03","RDS_Gaz24_Civ_03","RDS_Gaz24_Civ_03","RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_01","RDS_Hatchback_01_F","RDS_Ikarus_Civ_01","RDS_Ikarus_Civ_01","RDS_Ikarus_Civ_02","RDS_S1203_Civ_01","RDS_S1203_Civ_01","RDS_SUV_01_F","RDS_Van_01_transport_F","RDS_Van_01_box_F","RDS_Lada_Civ_01","RDS_Lada_Civ_03","RDS_Lada_Civ_02"];

	_selectedCivilians = "RDS";
	_selectedVehicles = "RDS";
};

//-- CAF Aggressors
if (isClass (configfile >> "CfgGroups" >> "East" >> "caf_ag_me_t")) then {
	if (worldName in _middleEastMaps) then {
		_civType = ["CAF_AG_ME_CIV","CAF_AG_ME_CIV_02","CAF_AG_ME_CIV_03","CAF_AG_ME_CIV_04"];
		_terroristType = ["CAF_AG_ME_T_AK47","CAF_AG_ME_T_AK74","CAF_AG_ME_T_GL","CAF_AG_ME_T_PKM","CAF_AG_ME_T_RPG","CAF_AG_ME_T_RPK74","CAF_AG_ME_T_SVD"];
       
		_selectedFaction = "CAF Middle East";
		_selectedCivilians = "CAF Middle East";
	};
};

//-- Defaults
if ((count _civType == 0) and (worldName in _africanMaps)) then {
	_civType = ["C_man_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_shorts_1_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro"];
	_selectedCivilians = "Default Jungle";
};
if (count _civType == 0) then {
	_civType = ["C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F"];
	_selectedCivilians = "Default";
};
if (count _vehType == 0) then {
	_vehType = ["C_Offorad_01_F","C_Hatchback_01_F","C_Van_01_transport_F","C_Van_01_box_F"];
	_selectedVehicles = "Default";
};
//-- RHS Insurgents
if ((isClass (configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents")) and (count _terroristType == 0)) then {
	_terroristType = ["rhs_g_Soldier_F2","rhs_g_Soldier_F3","rhs_g_Soldier_F","rhs_g_Soldier_LAT_F","rhs_g_Soldier_lite_F","rhs_g_Soldier_AT_F"];
	_selectedFaction = "RHS Insurgents";
};
if (count _terroristType == 0) then {
	_terroristType = ["I_Soldier_F","I_Soldier_LAT_F","I_Soldier_lite_F","I_Soldier_SL_F","I_Soldier_M_F","I_Soldier_GL_F","I_Soldier_AR_F"];
	_selectedFaction = "Default";
};

//-- Use custom units if any are defined
if !(count _manCivType == 0) then {
	_civType = _manCivType;
	_selectedCivilians = "Custom";
};

if !(count _manTerroristType == 0) then {
	_terroristType = _manTerroristType;
	_selectedFaction = "Custom";
};

if !(count _manVehicleType == 0) then {
	_selectedVehicles = "Custom";
	_vehType = _manVehicleType;
};

//-- Debug
if (_debug) then {
	_message = format ["Spyder Ambiance: unit data gathered, %1 insurgents selected. %2 vehicles selected. %3 civilians selected", _selectedFaction, _selectedVehicles, _selectedCivilians];
	[_message] call ALIVE_fnc_dumpR;
};

SpyderAmbiance_UnitData = [_civType,_vehType,_terroristType];