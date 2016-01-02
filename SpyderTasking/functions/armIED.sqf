params ["_IED"];


//-- Attach damage handler
_Charge = createVehicle ["ALIVE_DemoCharge_Remote_Ammo",getposATL _IED, [], 0, "CAN_COLLIDE"];
_Charge attachTo [_IED, [0,0,.05]];
_Charge hideObjectGlobal true;


_ehID = _Charge addeventhandler ["HandleDamage",{
	private ["_nearTriggers","_IED"];

	//-- Explode
	if (isPlayer (_this select 3)) then {
		_IED = attachedTo (_this select 0);
		([["M_Mo_120mm_AT","M_Mo_120mm_AT_LG","M_Mo_82mm_AT_LG","R_60mm_HE","Bomb_04_F","Bomb_03_F"],[4,8,2,1,1,1]] call BIS_fnc_selectRandomWeighted) createVehicle [(getpos (_this select 0)) select 0, (getpos (_this select 0)) select 1,0];
		deletevehicle (_this select 0);
		deleteVehicle _IED;

		//-- Delete trigger created by ALiVE_fnc_armIED
		_nearTriggers = (position (_this select 0)) nearObjects ["EmptyDetector", 10];
		{deleteVehicle _x} foreach _nearTriggers;
	};
}];


//-- Arming delay
sleep 30;


//-- Add proximity trigger
_trigger1 = createTrigger ["EmptyDetector", getPosATL _IED, true];
_trigger1 setTriggerArea [(8 + random 12), (8 + random 12), 0, false];
_trigger1 setTriggerActivation ["WEST", "PRESENT", false];
_trigger1 setTriggerStatements [
//-- Condition
"this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8) && !('MineDetector' in (items _x)) && (getText (configFile >> 'cfgVehicles' >> typeof _x >> 'displayName') != 'Explosive Specialist') && ([vehicleVarName _x,'EOD'] call CBA_fnc_find == -1)} count ([] call BIS_fnc_listPlayers) > 0)",

//-- On activation
"{deleteVehicle _x} forEach (nearestObjects [getPos thisTrigger, ['IEDUrbanSmall_F','IEDUrbanBig_F','IEDLandSmall_F','IEDLandBig_F'], 10]);
([['M_Mo_120mm_AT','M_Mo_120mm_AT_LG','M_Mo_82mm_AT_LG','R_60mm_HE','Bomb_04_F','Bomb_03_F'],[4,8,2,1,1,1]] call BIS_fnc_selectRandomWeighted) createVehicle (getPos thisTrigger);
{deleteVehicle _x) forEach (nearestObjects [getPos thisTrigger, ['EmptyDetector'], 7])",

//-- On de-activation
""];


//-- Explosive Specialist proximity trigger
_trigger2 = createTrigger["EmptyDetector", getposATL _IED, true];
_trigger2 setTriggerArea[1.5,1.5,0,false];
_trigger2 setTriggerActivation["ANY","PRESENT",false];
_trigger2 setTriggerStatements[
//-- Condition
"this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8)} count ([] call BIS_fnc_listPlayers) > 0)",

//-- On activation
"{deleteVehicle _x} forEach (nearestObjects [getPos thisTrigger, ['IEDUrbanSmall_F','IEDUrbanBig_F','IEDLandSmall_F','IEDLandBig_F'], 10]);
([['M_Mo_120mm_AT','M_Mo_120mm_AT_LG','M_Mo_82mm_AT_LG','R_60mm_HE','Bomb_04_F','Bomb_03_F'],[4,8,2,1,1,1]] call BIS_fnc_selectRandomWeighted) createVehicle (getPos thisTrigger);
{deleteVehicle _x) forEach (nearestObjects [getPos thisTrigger, ['EmptyDetector'], 7])",

//-- On de-activation
""];

_IED setVariable ["ST_NonSpecialistTrigger", _trigger1];
_IED setVariable ["ST_SpecialistTrigger", _trigger2];


//-- Add Disarm action
_IED addAction ["<t color='#ff0000'>Disarm IED</t>","(_this select 0) spawn ST_fnc_disarmIED;(_this select 1) playActionNow 'PutDown'", "", 6, true, true,"", "_target distance2D _this < 3"];