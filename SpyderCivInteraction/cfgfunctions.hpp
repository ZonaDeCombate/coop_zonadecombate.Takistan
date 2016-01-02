/*
Author:

	SpyderBlack723


Description:

	Creates and appends SCI_fnc to each function listed.

______________________________________________________*/

class SCI
{
	tag = "SCI";
	class functions
	{
		class civilianInteraction {
			description = "Manipulador principal para a interação civil";
			file = "SpyderCivInteraction\fn_civilianInteraction.sqf";
			recompile = RECOMPILE;
		};

		class commandHandler {
			description = "Manipulador principal de comandos";
			file = "SpyderCivInteraction\fn_commandHandler.sqf";
			recompile = RECOMPILE;
		};
		class questionHandler {
			description = "Recupera as respostas para a pergunta passou";
			file = "SpyderCivInteraction\fn_questionHandler.sqf";
			recompile = RECOMPILE;
		};

	};
};