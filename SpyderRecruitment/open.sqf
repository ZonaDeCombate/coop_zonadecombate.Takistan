//-- Exit if incorrect faction paramets passed
if (!(typeName _this == "ARRAY") or {count _this == 0}) exitWith {hint "Factions não foram passados corretamente. Por favor, garantir que você tenha cada facção dentro da mesma matriz e cada um está envolvido em aspas e separados por uma vírgula. Examplo: ['BLU_F','BLU_G_F']"};

//-- Open menu
CreateDialog "Spyder_RecruitmentMenu";

//-- Call onLoad with the passed factions
_this execVM "SpyderRecruitment\buildUnitList.sqf";