_faction = [ST_Logic, "HostileFaction"] call ALiVE_fnc_hashGet;
_side = _faction call ALiVE_fnc_factionSide;

// - Obter campos viáveis para atacar
_objective = [_side,"MIL"] call ST_fnc_getPopulatedObjective;
if (typeName _objective == "BOOL") exitWith {[10] call ST_fnc_taskHander};
_objectivePosition = [_objective, "center"] call ALiVE_fnc_HashGet;

// - Atribuir tarefa a jogadores
_description = format ["Temos localizada a posição de uma base insurgente próximo de %1. Mover para a área e eliminar todas as forças inimigas. ", [_objectivePosition] call ALIVE_fnc_taskGetNearestLocationName];
_description = [_description, "Assalto a base insurgente", "Assalto a base insurgente"];
[true,["SpyderAutoTask"],_description,_objectivePosition,true,1,true,"",true] call BIS_fnc_taskCreate;


// - Aguarde até que todos os insurgentes nas proximidades perto do acampamento estão mortos
waitUntil {
	sleep 30;
	!([_side,_objectivePosition,300] call ST_fnc_isSideNear);
};


// - Tarefa completa

["SpyderAutoTask","SUCCEEDED"] call BIS_fnc_taskSetState;
// _playerFaction = [] call ST_fnc_getPlayerFaction;
_friendlyFaction = [ST_Logic, "FriendlyFaction"] call ALiVE_fnc_hashGet;
[_friendlyFaction,5] call ST_fnc_rewardForcepool;

// - Redefinir tasking

sleep 60;
["SpyderAutoTask"] call BIS_fnc_deleteTask;
[] call ST_fnc_taskHandler;