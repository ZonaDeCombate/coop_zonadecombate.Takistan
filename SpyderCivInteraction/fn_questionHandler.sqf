/* ----------------------------------------------------------------------------
Function: SCI_fnc_questionHandler

Description:
Main handler for questions

Parameters:
String - Question

Returns:
none

Examples:
(begin example)
["Home"] call SCI_fnc_questionHandler; //-- Ask where they live
["Insurgents"] call SCI_fnc_questionHandler; //-- Ask if they've seen any insurgents
["StrangeBehavior"] call SCI_fnc_questionHandler; //-- Ask if they've seen any strange behavior
(end)

Notes:
Civilians will stay stay hostile throughout a conversation
Civilians may become annoyed when you keep asking questions, which will raise their hostility
Some responses are shared by the hostile and non-hostile sections, this is done to keep a gray line between hostile and non-hostile

See Also:
- nil

Author:
SpyderBlack723

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_civData","_civInfo","_hostile","_hostility","_asked","_civ","_answerGiven"];
params [
	["_question", ""]
];

//-- Define control ID's
#define MAINCLASS SCI_fnc_civilianInteraction
#define QUESTION_HANDLER SCI_fnc_questionHandler
#define SCI_ResponseList (findDisplay 923 displayCtrl 9239)

//-- Get civ hostility
_hostile =  false;
_civData = [SCI_Logic, "CurrentCivData"] call ALiVE_fnc_hashGet;
_civInfo = [_civData, "CivInfo"] call ALiVE_fnc_hashGet;_civInfo = _civInfo select 0;
_civ = [SCI_Logic, "CurrentCivilian"] call ALiVE_fnc_hashGet;
_civName = name _civ;

//-- Set questions asked
_asked = ([_civData, "Asked"] call ALiVE_fnc_hashGet) + 1;
[_civData, "Asked", _asked] call ALiVE_fnc_hashSet;

if (!isNil {[_civData, "Hostile"] call ALiVE_fnC_hashGet}) then {
	_hostile = true;
} else {
	_hostility = _civInfo select 1;
	if (random 100 < _hostility) then {
		_hostile = true;
		[_civData, "Hostile", true] call ALiVE_fnc_hashSet;
	};
};

//-- Hash new data to logic
[SCI_Logic, "CurrentCivData", _civData] call ALiVE_fnc_hashSet;

//-- Get previous responses
_answersGiven = [_civData, "AnswersGiven"] call ALiVE_fnc_hashGet;

//-- Clear previous responses
SCI_ResponseList ctrlSetText "";

//-- Check if question has already been answered
if ((_question in _answersGiven) and (floor random 100 < 75)) exitWith {
	_response1 = "Eu não estou dizendo a você novamente.";
	_response2 = "Não já discutimos isso?";
	_response3 = "Eu já respondi isso.";
	_response4 = "Por que você está me perguntando novamente.";
	_response5 = "Você já me perguntou isso.";
	_response6 = "Você está começando a me irritar com essa pergunta.";
	_response7 = "Eu não posso falar sobre isso.";
	_response8 = "Você ter começado suas respostas já.";
	_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8] call BIS_fnc_selectRandom;
	SCI_ResponseList ctrlSetText _response;

	//-- Check if civilian is irritated
	["isIrritated", [_hostile,_asked,_civ]] call MAINCLASS;
};

switch (_question) do {

	//-- Where is your home located
	case "Home": {
		_homePos = _civInfo select 0;

		if (!(_hostile) and (floor random 100 > 15)) then {
			_response1 = format ["Eu vivo lá, eu vou lhe mostrar (%1's casa foi marcado no mapa).", _civName];
			_response2 = format ["Eu vivo nas proximidades (a casa de %1's foi marcado no mapa).", _civName];
			_response3 = format ["Eu vou indicá-lo para você (a casa de %1's foi marcado no mapa).", _civName];
			_response4 = format ["Eu moro logo ali (a casa de %1's foi marcado no mapa).", _civName];
			_response = [_response1,_response2,_response3,_response4] call BIS_fnc_selectRandom;
			SCI_ResponseList ctrlSetText _response;

			//-- Create marker on home
			_answersGiven pushBack "Home";_answerGiven = true;
			_markerName = format ["casa do %1's", _civName];
			_marker = [str _homePos, _homePos, "ICON", [.35, .35], "ColorCIV", _markerName, "mil_circle", "Solid", 0, .5] call ALIVE_fnc_createMarkerGlobal;
			_marker spawn {sleep 30;deleteMarker _this};
		} else {
			_response1 = "Sinto muito, mas eu não me sinto confortável dando essa informação para fora.";
			_response2 = "Eu não quero compartilhar isso com você.";
			_response3 = "Eu não te devo nada.";
			_response4 = "Por favor, deixe-me só.";
			_response5 = "Por favor saia.";
			_response6 = "Saia daqui!";
			_response = [_response1,_response2,_response3,_response4,_response5,_response6] call BIS_fnc_selectRandom;
			SCI_ResponseList ctrlSetText _response;
		};
	};

	//-- What town do you live in
	case "Town": {
		_homePos = _civInfo select 0;
		_town = [_homePos] call ALIVE_fnc_taskGetNearestLocationName;

		if !(_hostile) then {
			if (floor random 100 > 15) then {
				_response1 = format ["Eu vivo por %1.", _town];
				_response2 = format ["Eu vivo por %1.", _town];
				_response3 = format ["Eu vivo na aldeia de %1.", _town];
				_response4 = format ["Minha cidade natal é %1.", _town];
				_response5 = "Você não deveria estar aqui.";
				_response6 = "Eles não gostam de mim falando com você.";
				_response = [_response1, _response2, _response3, _response4, _response5, _response6] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "Town";_answerGiven = true;
			} else {
				_response1 = "Sinto muito, mas eu não me sinto confortável dando essa informação para você.";
				_response2 = "Desculpe, eu não quero responder a isso.";
				_response3 = "Eu não deveria compartilhar isso com você.";
				_response4 = "Eu só quero ser deixado sozinho.";
				_response5 = "Por favor, deixe minha comunidade em paz.";
				_response = [_response1,_response2,_response3,_response4,_response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		} else {
			_response1 = "Sinto muito, mas eu não me sinto confortável dando essa informação para você.";
			_response2 = "Eu não deveria compartilhar isso com você.";
			_response3 = "Eu não te devo nada.";
			_response4 = "Você não deveria estar aqui.";
			_response5 = "Por favor, deixe-me só.";
			_response6 = "Eu não vou te dizer onde eu vivo!";
			_response7 = "Você não vai aterrorizar minha cidade!";
			_response = [_response1, _response2, _response3, _response4, _response5, _response6, _response7] call BIS_fnc_selectRandom;
			SCI_ResponseList ctrlSetText _response;
		};
	};

	//-- Have you seen any IED's nearby
	case "IEDs": {

		_IEDs = [];
		{
			if (_x distance2D (getPos _civ) < 1000) then {_IEDs pushBack _x};
		} forEach allMines;

		if (count _IEDs == 0) then {
			if !(_hostile) then {
				if (floor random 100 > 25) then {
					_response1 = "Não há IEDs nas proximidades.";
					_response2 = "Desculpe, eu não vi nenhum.";
					_response3 = "Não que eu saiba, me desculpe.";
					_response4 = "Não colocados IEDs aqui perto.";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "IEDs";_answerGiven = true;
				} else {
					_response1 = "Desculpe, eu não sei.";
					_response2 = "Eu não posso dar esse tipo de informação para você.";
					_response3 = "Eu seria morto se eu lhe dissesse.";
					_response4 = "Por favor, deixe, eles não podem me ver falando com você.";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Como eu iria dizer-lhe.";
				_response2 = "Apenas me deixe sozinho agora.";
				_response3 = "Você vai ter que descobrir isso por si mesmo.";
				_response4 = "Cuidado com o degrau.";
				_response5 = "Talvez eu devesse ter plantado algumas.";
				_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};

		} else {
			_iedLocation = getPos (_IEDs call BIS_fnc_selectRandom);

			if !(_hostile) then {
				if (floor random 100 > 25) then {
					_response1 = "Sim, eu vi uma antes (local marcado no mapa).";
					_response2 = "Deixe-me mostrar-lhe um (local marcado no mapa).";
					_response3 = "Eu acho que sei um ponto (local marcado no mapa).";
					_response4 = "Eu vi uma planta insurgente (Location marcado no mapa).";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "IEDs";_answerGiven = true;

					//-- Create marker on IED
					_iedPos = getPos (_IEDs call BIS_fnc_selectRandom);
					_iedPos = [_iedPos, (25 + ceil random 15)] call CBA_fnc_randPos;
					_marker = [str _iedPos, _iedPos, "ELLIPSE", [40, 40], "ColorRed", "IED", "n_installation", "FDiagonal", 0, 0.5] call ALIVE_fnc_createMarkerGlobal;
					_text = [str (str _iedPos),_iedPos,"ICON", [0.1,0.1],"ColorRed","IED", "mil_dot", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal;
					[_marker,_text] spawn {sleep 30;deleteMarker (_this select 0);deleteMarker (_this select 1)};
				} else {
					_response1 = "Desculpe, eu não sei.";
					_response2 = "Eu não posso dar esse tipo de informação para você.";
					_response3 = "Eu seria morto se eu lhe dissesse.";
					_response4 = "Por favor, deixe, eles não podem me ver falando com você.";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Como eu iria dizer-lhe.";
				_response2 = "Apenas me deixe sozinho agora.";
				_response3 = "Você terá que descobrir por conta própria.";
				_response4 = "Cuidado com o degrau .";
				_response5 = "Talvez eu devesse ter plantado algumas.";
				_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};

		};
	};

	//-- Have you seen any insurgent activity lately
	case "Insurgents": {

		_insurgentFaction = [SCI_Logic, "InsurgentFaction"] call ALiVE_fnc_hashGet;
		_pos = getPos _civ;
		_town = [_pos] call ALIVE_fnc_taskGetNearestLocationName;

		//-- Get nearby insurgents
		_insurgents = [];
		{
			_leader = leader _x;

			if ((faction _leader == _insurgentFaction) and {_leader distance2D _pos < 1100}) then {
				_insurgents pushBack _leader;
			};
		} forEach allGroups;

		if (count _insurgents == 0) then {
			//-- Insurgents are not nearby
			if !(_hostile) then {
				if (floor random 100 > 40) then {
					_response1 = "Desculpe, eu não vi nenhum.";
					_response2 = "Não, não há nenhum por perto.";
					_response3 = "Não recentemente, desculpe.";
					_response4 = "Felizmente não.";
					_response5 = "Eu não vi nenhum.";
					_response = [_response1, _response2, _response3, _response4,_response5] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Insurgents";_answerGiven = true;
				} else {
					_response1 = "Por favor, me deixe em paz.";
					_response2 = "Eu não quero falar sobre isso.";
					_response3 = "Eu não quero falar com você.";
					_response4 = "Eu não posso te dizer.";
					_response5 = "Eles não gostam de mim falando com você.";
					_response = [_response1, _response2, _response3, _response4,_response5] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Como se eu iria dizer-lhe.";
				_response2 = "Saia de perto de mim.";
				_response3 = "Por favor, me deixe em paz.";
				_response4 = "Eu não quero falar sobre isso.";
				_response5 = "Eu não quero falar com você.";
				_response = [_response1, _response2, _response3, _response4,_response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		} else {
			//-- Insurgents are nearby
			if !(_hostile) then {
				//-- Random chance to reveal insurgents
				if (floor random 100 > 50) then {
					//-- Reveal location
					_response1 = format ["Alguns insurgentes estão perto de %1.", _town];
					_response2 = "Não dá informações em mim (Insurgentes marcado no mapa).";
					_response3 = "Sim, deixe-me mostrar-lhe onde eu os vi (Insurgentes marcado no mapa).";
					_response4 = "Sim, mas você deve manter este segredo (Insurgentes marcado no mapa).";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Insurgents";_answerGiven = true;

					//-- Create marker on insurgent group
					_insurgentPos = getPos (_insurgents call BIS_fnc_selectRandom);
					_insurgentPos = [_insurgentPos, (75 + ceil random 25)] call CBA_fnc_randPos;
					_marker = [str _insurgentPos, _insurgentPos, "ELLIPSE", [100, 100], "ColorEAST", "Insurgents", "n_installation", "FDiagonal", 0, 0.5] call ALIVE_fnc_createMarkerGlobal;
					_text = [str (str _insurgentPos),_insurgentPos,"ICON", [0.1,0.1],"ColorRed","Insurgents", "mil_dot", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal;
					[_marker,_text] spawn {sleep 30;deleteMarker (_this select 0);deleteMarker (_this select 1)};
				} else {
					//-- Don't reveal location
					_response1 = "Eles não iria querer me ver falando com você.";
					_response2 = "Você não pode fazer perguntas como essa.";
					_response3 = "Você está louco?";
					_response4 = "Por favor, me deixe em paz.";
					_response5 = "Eu não quero falar sobre isso.";
					_response6 = "Eu não quero falar com você.";
					_response = [_response1, _response2, _response3, _response4] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Como se eu iria dizer-lhe.";
				_response2 = "Saia de perto de mim.";
				_response3 = "Por favor, me deixe em paz.";
				_response4 = "Eu não quero falar sobre isso.";
				_response5 = "Eu não quero falar com você.";
				_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		};

	};

	//-- Do you know the location of any insurgent hideouts
	case "Hideouts": {
		_installations = [_civData, "Installations"] call ALiVE_fnc_hashGet;
		_actions = [_civData, "Actions"] call ALiVE_fnc_hashGet;
		_installations params ["_factory","_HQ","_depot","_roadblocks"];
		_actions params ["_ambush","_sabotage","_ied","_suicide"];

		if ((_factory isEqualTo []) and (_HQ isEqualTo []) and (_depot isEqualTo []) and (_roadblocks isEqualTo [])) then {
			if !(_hostile) then {
				if (floor random 100 > 30) then {
					_response1 = "Os insurgentes não tenham estabelecido quaisquer instalações aqui.";
					_response2 = "Felizmente, não.";
					_response3 = "Não eu não tenho.";
					_response4 = "Não há bases insurgentes aqui.";
					_response5 = "Não há esconderijos insurgentes aqui.";
					_response6 = "Os insurgentes não tenham tomado sobre esta área ainda.";
					_response7 = "Não há esconderijos aqui.";
					_response8 = "Não há instalações aqui.";
					_response9 = "Ainda estamos livres de seu dominio.";
					_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8,_response9] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Hideouts";_answerGiven = true;
				} else {
					_response1 = "Você está louco.";
					_response2 = "Eu não posso falar sobre isso.";
					_response3 = "Você quer me matar?";
					_response4 = "Eu não vou me colocar em perigo.";
					_response5 = "Eu não vou me colocar em risco.";
					_response = [_response1,_response2,_response3,_response4,_response5] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Eu não tenho tempo para isso.";
				_response2 = "Eu não posso falar sobre isso agora.";
				_response3 = "Você está louco.";
				_response4 = "Por que você me pergunta tal questão.";
				_response5 = "Essa é uma pergunta louca para se fazer.";
				_response6 = "Você quer me matar?";
				_response7 = "Eu não vou me colocar em perigo.";
				_response8 = "Por que você pergunta isso?";
				_response9 = "Eu não posso te ajudar com isso.";
				_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8,_response9] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		} else {
			private ["_installation","_type","_typeName","_installationData"];
			for "_i" from 0 to 3 do {
				_installationArray = _installations call BIS_fnc_selectRandom;

				if (!(_installationArray isEqualTo []) and (isNil "_installation")) then {
					_index = _installations find _installationArray;
					switch (str _index) do {
						case "0": {_typeName = "Fábrica IED";_type = "IED factory"};
						case "1": {_typeName = "Posto de recrutamento";_type = "recruitment HQ"};
						case "2": {_typeName = "Depósito de munições";_type = "munitions depot"};
						case "3": {_typeName = "Bloqueio de estrada";_type = "roadblocks"};
					};
					_installation = _installationArray;
				};
			};

			if ((isNil "_type") or (isNil "_installation")) exitWith {
				_response1 = "Eu não posso falar sobre isso.";
				_response2 = "Eles iriam me matar.";
				_response3 = "Você está louco.";
				_response4 = "Você quer me matar.";
				_response5 = "Eu não posso colocar minha família em risco, respondendo a isso.";
				_response = [_response1,_response2,_response3,_response4,_response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "Hideouts";_answerGiven = true;
			};

			if !(_hostile) then {
				if (floor random 100 > 60) then {
					if (floor random 100 > 60) then {
						_response1 = format ["Notei um %1 nas proximidades (%2 marcado no mapa).", _type,_typeName];
						_response2 = format ["Alguém me disse que havia um %1 por perto (%2 marcado no mapa).", _type,_typeName];
						_response3 = format ["Observei insurgentes criação de um %1 (%2 marcado no mapa)", _type,_typeName];
						_response4 = format ["Eu sei que a localização de um %1 (%2 marcado no mapa).", _type,_typeName];
						_response5 = format ["Os insurgentes estabeleceu um %1 (%2 marcado no mapa).", _type,_typeName];
						_response6 = format ["Posso mostrar-lhe a localização de um %1 (%2 marcado no mapa).", _type,_typeName];
						_response7 = format ["Você deve manter isso em segredo (%2 marcado no mapa).", _type,_typeName];
						_response8 = format ["Você deve prometer me proteger (%2 marcado no mapa).", _type,_typeName];
						_response9 = format ["Por favor, remova a %1 da área e restaurar a paz (%2 marcado no mapa).", _type,_typeName];
						_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8,_response9] call BIS_fnc_selectRandom;
						SCI_ResponseList ctrlSetText _response;
						_answersGiven pushBack "Hideouts";_answerGiven = true;

						if (floor random 100 > 30) then {
							//-- Create marker on general installation location
							_installationPos = getPos _installation;
							_installationPos = [_installationPos, (75 + ceil random 25)] call CBA_fnc_randPos;
							_marker = [str _installationPos, _installationPos, "ELLIPSE", [100, 100], "ColorEAST", _typeName, "n_installation", "FDiagonal", 0, 0.5] call ALIVE_fnc_createMarkerGlobal;
							_text = [str (str _installationPos),_installationPos,"ICON", [0.1,0.1],"ColorRed",_typeName, "mil_dot", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal;
							[_marker,_text] spawn {sleep 30;deleteMarker (_this select 0);deleteMarker (_this select 1)};
						} else {
							hint "Exact Marker";
							//-- Create marker on installation location
							_installationPos = getPos _installation;
							_marker = [str _installationPos, _installationPos, "ICON", [.35, .35], "ColorRed", _type, "n_installation", "Solid", 0, .5] call ALIVE_fnc_createMarkerGlobal;
							_marker spawn {sleep 30;deleteMarker _this};
						};
					} else {
						_response1 = format ["Notei um %1 nas proximidades.", _type];
						_response2 = format ["Alguém me disse que havia um %1 por perto.", _type];
						_response3 = format ["Observei insurgentes na criação de um %1.", _type];
						_response4 = format ["Os insurgentes prepararam um %1 nas proximidades.", _type];
						_response5 = format ["Os insurgentes estabeleceu um %1 aqui por perto.", _type];
						_response6 = format ["As pessoas já mencionaram um %1 por perto.", _type];
						_response7 = format ["Os insurgentes criaram um %1 nas proximidades.", _type];
						_response8 = format ["Restaurar a paz a esta área, há um %1 por aqui.", _type];
						_response9 = format ["Eu não sei onde ele está, mas os insurgentes estão operando a %1 em algum lugar por aqui.", _type];
						_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8,_response9] call BIS_fnc_selectRandom;
						SCI_ResponseList ctrlSetText _response;
						_answersGiven pushBack "Hideouts";_answerGiven = true;
					};
				} else {
					_response1 = "Eu não posso falar sobre isso.";
					_response2 = "Eles iriam me matar.";
					_response3 = "Você está louco.";
					_response4 = "Você quer me matar.";
					_response5 = "Eu não posso colocar minha família em risco, respondendo a isso.";
					_response = [_response1,_response2,_response3,_response4,_response5] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Hideouts";_answerGiven = true;
				};
			} else {
				if (floor random 100 > _hostility) then {
		  		_response1 = format ["Notei um %1 nas proximidades.", _type];
		  		_response2 = format ["Alguém me disse que havia um %1 por perto.", _type];
		  		_response3 = format ["Observei insurgentes na criação de um %1.", _type];
		  		_response4 = format ["Os insurgentes prepararam um %1 nas proximidades.", _type];
		  		_response5 = format ["Os insurgentes estabeleceu um %1 aqui por perto.", _type];
		  		_response6 = format ["As pessoas já mencionaram um %1 por perto.", _type];
			  	_response7 = format ["Os insurgentes criaram um %1 nas proximidades.", _type];
	  			_response8 = format ["Restaurar a paz a esta área, há um %1 por aqui.", _type];
		  		_response9 = format ["Eu não sei onde ele está, mas os insurgentes estão operando a %1 em algum lugar por aqui.", _type];
					_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7,_response8,_response9] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Hideouts";_answerGiven = true;
				} else {
					_response1 = "Eu não posso falar sobre isso.";
					_response2 = "Eles iriam me matar.";
					_response3 = "Você está louco.";
					_response4 = "Você quer me matar.";
					_response5 = "Eu não posso colocar minha família em risco, respondendo a isso.";
					_response6 = "Saia daqui!";
					_response7 = "Saia de perto de mim";
					_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "Hideouts";_answerGiven = true;
				};
			};
		};
	};

	//-- Have you noticed any strange behavior lately
	case "StrangeBehavior": {
		_hostileCivInfo = [_civData, "HostileCivInfo"] call ALiVE_fnc_hashGet;	//-- [_civ,_homePos,_activeCommands]
		//-- Check if data exists
		if (count _hostileCivInfo == 0) then {
			if !(_hostile) then {
				if (floor random 100 > 25) then {
					_response1 = "Não vi nada.";
					_response2 = "Desculpe, eu não tenho.";
					_response3 = "Não eu não tenho.";
					_response4 = "Não houve qualquer comportamento suspeito ultimamente.";
					_response5 = "Tudo é calmo aqui.";
					_response6 = "Nós somos uma comunidade pacífica.";
					_response = [_response1, _response2, _response3, _response4, _response5, _response6] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "StrangeBehavior";_answerGiven = true;
				} else {
					_response1 = "Eu não vou me colocar em risco.";
					_response2 = "Eles me matariam se eu lhe disse.";
					_response3 = "Eu não posso falar sobre isso.";
					_response4 = "Não houve qualquer comportamento suspeito ultimamente.";
					_response5 = "Eles não iria querer me falando com você.";
					_response6 = "Eu não deveria estar falando sobre isso.";
					_response = [_response1, _response2, _response3, _response4, _response5,_response6] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
				};
			} else {
				_response1 = "Eu não posso falar sobre isso";
				_response2 = "Eles não iria querer me falando com você";
				_response3 = "Eu não posso ajudar-te";
				_response4 = "Não eu não tenho";
				_response5 = "Eu não vi nada ultimamente";
				_response6 = "Não há nenhum perigo aqui";
				_response7 = "Eu não tenho tempo para isso";
				_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "StrangeBehavior";_answerGiven = true;
			};
		} else {
			_hostileCivInfo params ["_hostileCiv","_homePos","_activeCommands"];
			_activeCommand = _activeCommands call BIS_fnc_selectRandom;
			_activeCommand = _activeCommand select 0;
			_activePlan = ["getActivePlan",_activeCommand] call MAINCLASS;

			if (isNil "_activePlan") exitWith {SCI_ResponseList ctrlSetText "I can't talk about this right now."};

			if (!(_hostile) and (floor random 100 > 30)) then {
				_response1 = format ["Ouvi de um %1 em %2.", name _hostileCiv, _activePlan];
				_response2 = format ["Alguém me disse que era um %1 em %2.", name _hostileCiv, _activePlan];
				_response3 = format ["Vi que era %1 em %2.", name _hostileCiv, _activePlan];
				_response4 = format ["Acho que  %1 em %2.", name _hostileCiv, _activePlan];
				_response5 = format ["Fui informado de %1 em %2.", name _hostileCiv, _activePlan];
				_response6 = format ["Me disseram de um %1 em %2.", name _hostileCiv, _activePlan];
				_response = [_response1, _response2, _response3, _response4, _response5, _response6] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "StrangeBehavior";_answerGiven = true;

				if (floor random 100 < 35) then {
					switch (str floor random 2) do {
						case "0": {
							_response1 = " Eu ouviu onde estava (posição marcada no mapa).";
							_response2 = " Alguém me disse onde estava (posição marcada no mapa).";
							_response3 = " Eu o vi antes (posição marcada no mapa).";
							_response4 = " Eu acho que eu sei onde você pode encontrá-lo (posição marcada no mapa).";
							_response = [_response1, _response2, _response3,_response4] call BIS_fnc_selectRandom;
							SCI_ResponseList ctrlSetText ((ctrlText SCI_ResponseList) + _response);

							//-- Create marker on hostile civ location
							_civPos = [getPos _hostileCiv, (10 + ceil random 8)] call CBA_fnc_randPos;
							_markerName = format ["%1's location", name _hostileCiv];
							_marker = [str _civPos, _civPos, "ELLIPSE", [40, 40], "ColorRed", _markerName, "n_installation", "FDiagonal", 0, 0.5] call ALIVE_fnc_createMarkerGlobal;
							_text = [str (str _civPos),_civPos,"ICON", [0.1,0.1],"ColorRed",_markerName, "mil_dot", "FDiagonal",0,0.5] call ALIVE_fnc_createMarkerGlobal;
							[_marker,_text] spawn {sleep 30;deleteMarker (_this select 0);deleteMarker (_this select 1)};
						};
						case "1": {
							_response1 = " Eu vou te mostrar onde vive (Casa marcada no mapa).";
							_response2 = " Eu sei onde ele mora (Casa marcada no mapa).";
							_response3 = " Alguém me disse onde ele vive (Casa marcada no mapa).";
							_response4 = " Eu vou te mostrar onde você pode encontrá-lo (Casa marcada no mapa).";
							_response = [_response1, _response2, _response3,_response4] call BIS_fnc_selectRandom;
							SCI_ResponseList ctrlSetText ((ctrlText SCI_ResponseList) + _response);

							//-- Create marker on hostile civ location
							_markerName = format ["casa do %1's", name _hostileCiv];
							_marker = [str _homePos, _homePos, "ICON", [.35, .35], "ColorRed", _markerName, "mil_circle", "Solid", 0, .5] call ALIVE_fnc_createMarkerGlobal;
							_marker spawn {sleep 30;deleteMarker _this};
						};
					};
				};
			} else {
				if (floor random 100 > _hostility) then {
	  			_response1 = format ["Ouvi de um %1 em %2.", name _hostileCiv, _activePlan];
		  		_response2 = format ["Alguém me disse que era um %1 em %2.", name _hostileCiv, _activePlan];
	  			_response3 = format ["Vi que era %1 em %2.", name _hostileCiv, _activePlan];
		  		_response4 = format ["Acho que  %1 em %2.", name _hostileCiv, _activePlan];
	  			_response5 = format ["Fui informado de %1 em %2.", name _hostileCiv, _activePlan];
		  		_response6 = format ["Me disseram de um %1 em %2.", name _hostileCiv, _activePlan];
					_response = [_response1, _response2, _response3, _response4, _response5, _response6] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "StrangeBehavior";_answerGiven = true;
				} else {
					_response1 = "Eu não posso falar sobre isso";
					_response2 = "Eles não iria querer me falando com você";
					_response3 = "Eu não posso ajudar-te";
					_response4 = "Não, eu não tenho";
					_response5 = "Eu não vi nada ultimamente";
					_response6 = "Não há nenhum perigo aqui";
					_response7 = "Eu não tenho tempo para isso";
					_response = [_response1,_response2,_response3,_response4,_response5,_response6,_response7] call BIS_fnc_selectRandom;
					SCI_ResponseList ctrlSetText _response;
					_answersGiven pushBack "StrangeBehavior";_answerGiven = true;
				};
			};
		};
	};

	//-- What is your opinion of our forces
	case "Opinion": {
		private ["_response"];
		_personalHostility = _civInfo select 1;
		_townHostility = _civInfo select 2;

		if (((_townHostility / 2.5) > 45) and (floor random 100 > 25) and (_personalHostility < 50)) exitWith {
			_response1 = "Eles não gostam de mim falando com você.";
			_response2 = "Eu não posso falar sobre isso.";
			_response3 = "Por favor .. me deixe em paz.";
			_response4 = "Eu não posso ajudá-lo.";
			_response5 = "Por favor, deixe antes de vê-lo.";
			_response6 = "Você deve sair imediatamente.";
			_response7 = "Eles não devem me ver falando com você.";
			_response = [_response1, _response2, _response3, _response4, _response5, _response6,_response7] call BIS_fnc_selectRandom;
			SCI_ResponseList ctrlSetText _response;

			//-- Check if civilian is irritated
			["isIrritated", [_hostile,_asked,_civ]] call MAINCLASS;
		};

		if !(_hostile) then {
			if (floor random 100 < 70) then {

				//-- Give answer
				if (_personalHostility <= 25) then {
					_response1 = "Eu te ajudo.";
					_response2 = "Você não terá problemas comigo.";
					_response3 = "Eu apoio a sua causa.";
					_response4 = "Você não tem que se preocupar comigo.";
					_response5 = "Apoio plenamente as suas forças.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 25) and (_personalHostility <= 50)) then {
					_response1 = "Eu, principalmente, apoiá-lo.";
					_response2 = "Eu te ajudo. Não mexer-se.";
					_response3 = "Eu tenho sentimentos mistos sobre suas forças.";
					_response4 = "Você tem manter a minha confiança.";
					_response5 = "Eu lhe apoiou por algum tempo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 50) and (_personalHostility <= 75)) then {
					_response1 = "Suas forças tomaram decisões ruins ultimamente.";
					_response2 = "Estou começando a gostar de você.";
					_response3 = "Você deve recuperar a minha confiança.";
					_response4 = "É melhor você não ficar muito tempo.";
					_response5 = "Eu não apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 75) and (_personalHostility <= 100)) then {
					_response1 = "Eu oponho fortemente de sua presença aqui.";
					_response2 = "É melhor você sair.";
					_response3 = "Eu não apoiá-lo.";
					_response4 = "Eu odeio suas forças.";
					_response5 = "Você precisa sair imediatamente.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if (_personalHostility > 100) then {
					_response1 = "Estou extremamente contrário de você.";
					_response2 = "Você não fazer aqui.";
					_response3 = "Você precisa sair agora.";
					_response4 = "Saia daqui!";
					_response5 = "Quem iria apoiar pessoas como você?";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((isNil "_response") or (isNil "_personalHostility")) then {_response = "I don't want to talk right now"};
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "Opinion";_answerGiven = true;
			} else {
				//-- Decline to answer
				_response1 = "Eu não quero falar agora.";
				_response2 = "Eu não acho que eu deveria estar falando com você.";
				_response3 = "Eu não deveria estar falando com você.";
				_response4 = "Você deve seguir em frente.";
				_response5 = "Eu não posso responder a isso.";
				_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		} else {
			if (floor random 100 > _personalHostility) then {
				//-- Give answer
				if (_personalHostility <= 25) then {
					_response1 = "Eu te ajudo.";
					_response2 = "Você não terá problemas comigo.";
					_response3 = "Eu apoio a sua causa.";
					_response4 = "Você não tem que se preocupar comigo.";
					_response5 = "Apoio plenamente as suas forças.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 25) and (_personalHostility <= 50)) then {
					_response1 = "Eu, principalmente, apoiá-lo.";
					_response2 = "Eu te ajudo. Não mexer-se.";
					_response3 = "Eu tenho sentimentos mistos sobre suas forças.";
					_response4 = "Você deve manter a minha confiança.";
					_response5 = "Eu lhe apoiou por algum tempo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 50) and (_personalHostility <= 75)) then {
					_response1 = "Suas forças tomaram decisões ruins ultimamente.";
					_response2 = "Estou começando a gostar de você.";
					_response3 = "Você deve recuperar a minha confiança.";
					_response4 = "É melhor você não ficar muito tempo.";
					_response5 = "Eu não apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_personalHostility > 75) and (_personalHostility <= 100)) then {
					_response1 = "Eu me oponho fortemente de sua presença aqui.";
					_response2 = "É melhor você sair.";
					_response3 = "Eu não apoiá-lo.";
					_response4 = "Eu odeio suas forças.";
					_response5 = "Você precisa sair imediatamente.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if (_personalHostility > 100) then {
					_response1 = "Estou extremamente contrário de você.";
					_response2 = "Você não fazer aqui.";
					_response3 = "Você precisa sair agora.";
					_response4 = "Saia daqui!";
					_response5 = "Quem iria apoiar pessoas como você?";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((isNil "_response") or (isNil "_personalHostility")) then {_response = "I don't want to talk right now"};
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "Opinion";_answerGiven = true;
			} else {
				//-- Decline to answer
				_response1 = "Eu não quero falar agora.";
				_response2 = "Eu não acho que eu deveria estar falando com você.";
				_response3 = "Eu não deveria estar falando com você.";
				_response4 = "Você deve seguir em frente.";
				_response5 = "Eu não posso responder a isso.";
				_response6 = "Saia daqui!";
				_response = [_response1, _response2, _response3, _response4, _response5,_response6] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		};
	};

	//-- What is the general opinion of our forces in your town
	case "TownOpinion": {
		private ["_response"];
		_personalHostility = _civInfo select 1;
		_townHostility = _civInfo select 2;

		if (((_townHostility / 2.5) > 45) and (floor random 100 > 25) and (_personalHostility < 50)) exitWith {
			_response1 = "Eles não gostam de mim falando com você.";
			_response2 = "Eu não posso falar sobre isso.";
			_response3 = "Você deve deixar este lugar imediatamente.";
			_response4 = "Você está em perigo grave aqui.";
			_response5 = "Por favor, deixe antes de vê-lo.";
			_response6 = "Você deve sair imediatamente.";
			_response7 = "Eles não devem me ver falando com você.";
			_response = [_response1, _response2, _response3, _response4, _response5, _response6,_response7] call BIS_fnc_selectRandom;
			SCI_ResponseList ctrlSetText _response;

			//-- Check if civilian is irritated
			["isIrritated", [_hostile,_asked,_civ]] call MAINCLASS;
		};

		//-- This really needs to be a switch, couldn't get it to work properly the first time
		if !(_hostile) then {
			if (floor random 100 < 70) then {

				//-- Give answer
				if (_townHostility <= 25) then {
					_response1 = "Você está bem respeitado por aqui.";
					_response2 = "Eu não acho que você precisa se preocupar com a nossa hostilidade aqui.";
					_response3 = "Apoiamos vocês";
					_response4 = "Vamos ajudá-lo se pudermos.";
					_response5 = "Você está apoiada aqui.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 25) and (_townHostility <= 50)) then {
					_response1 = "As tensões têm aumentado recentemente.";
					_response2 = "As pessoas ao redor aqui estão indecisos.";
					_response3 = "Há sentimentos mistos sobre você.";
					_response4 = "Você pode querer experimentar e menor hostilidade por aqui.";
					_response5 = "A maioria de nós apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 50) and (_townHostility <= 75)) then {
					_response1 = "As tensões têm aumentado muito.";
					_response2 = "As pessoas ao redor aqui não gostam de você.";
					_response3 = "Você não está gostado por aqui.";
					_response4 = "Você não deve ficar muito tempo.";
					_response5 = "A maioria das pessoas não apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 75) and (_townHostility <= 100)) then {
					_response1 = "As tensões estão muito elevados.";
					_response2 = "Tenha muito cuidado com as pessoas por aqui.";
					_response3 = "Você se opõem fortemente aqui.";
					_response4 = "Você não deve ficar muito tempo.";
					_response5 = "Muito poucos de nós apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if (_townHostility > 100) then {
					_response1 = "As tensões são extremamente elevados.";
					_response2 = "Você pode ser seguido se você ficar por aqui.";
					_response3 = "Você está odiado por aqui.";
					_response4 = "Você deve sair agora.";
					_response5 = "Quase ninguém aqui apoia-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((isNil "_response") or (isNil "_townHostility")) then {_response = "I don't want to talk right now"};
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "TownOpinion";_answerGiven = true;
			} else {
				//-- Decline to answer
				_response1 = "Eu não quero falar agora.";
				_response2 = "Eu não acho que eu deveria estar falando com você.";
				_response3 = "Eu não deveria estar falando com você.";
				_response4 = "Você deve seguir em frente.";
				_response5 = "Eu não posso responder a isso.";
				_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		} else {
			if (floor random 100 > _personalHostility) then {
				//-- Give answer
				if (_townHostility <= 25) then {
					_response1 = "Você está bem respeitado por aqui.";
					_response2 = "Eu não acho que você precisa se preocupar com a nossa hostilidade aqui.";
					_response3 = "Nós os apoiamos";
					_response4 = "Vamos ajudá-lo se pudermos.";
					_response5 = "Você está apoiado aqui.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 25) and (_townHostility <= 50)) then {
					_response1 = "As tensões têm aumentado recentemente.";
					_response2 = "As pessoas ao redor aqui estão indecisos.";
					_response3 = "Há sentimentos mistos sobre você.";
					_response4 = "Você pode querer experimentar e menor hostilidade por aqui.";
					_response5 = "A maioria de nós apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 50) and (_townHostility <= 75)) then {
					_response1 = "As tensões têm aumentado muito.";
					_response2 = "As pessoas ao redor aqui não gostam de você.";
					_response3 = "Você não está gostado por aqui.";
					_response4 = "Você não deve ficar muito tempo.";
					_response5 = "A maioria das pessoas não apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((_townHostility > 75) and (_townHostility <= 100)) then {
					_response1 = "As tensões são muito elevados.";
					_response2 = "Tenha muito cuidado com as pessoas por aqui.";
					_response3 = "Você se opõem fortemente aqui.";
					_response4 = "Você não deve ficar muito tempo.";
					_response5 = "Muito poucos de nós apoiá-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if (_townHostility > 100) then {
					_response1 = "As tensões são extremamente elevados.";
					_response2 = "Você pode ser seguido se você ficar por aqui.";
					_response3 = "Você é odiado por aqui.";
					_response4 = "Você deve sair agora.";
					_response5 = "Quase ninguém aqui apoia-lo.";
					_response = [_response1, _response2, _response3, _response4, _response5] call BIS_fnc_selectRandom;
				};

				if ((isNil "_response") or (isNil "_townHostility")) then {_response = "I don't want to talk right now"};
				SCI_ResponseList ctrlSetText _response;
				_answersGiven pushBack "TownOpinion";_answerGiven = true;
			} else {
				//-- Decline to answer
				_response1 = "Eu não quero falar agora.";
				_response2 = "Eu não acho que eu deveria estar falando com você.";
				_response3 = "Eu não deveria estar falando com você.";
				_response4 = "Você deve seguir em frente.";
				_response5 = "Eu não posso responder a isso.";
				_response6 = "Saia daqui!";
				_response = [_response1, _response2, _response3, _response4, _response5,_response6] call BIS_fnc_selectRandom;
				SCI_ResponseList ctrlSetText _response;
			};
		};
	};

};

//-- Check if civilian is irritated
["isIrritated", [_hostile,_asked,_civ]] call MAINCLASS;

if (_answerGiven) then {
	[_civData, "AnswersGiven", _answersGiven] call ALiVE_fnc_hashSet;
	_civ setVariable ["AnswersGiven",_answersGiven];
	_civ setVariable ["AnswersGiven",_answersGiven, false]; //-- Broadcasting could bring server perf loss with high use (set false to true at risk)
};


/*
Threat outline

ADD THREATS THAT CAN LOWER OR RAISE HOSTILITY DEPENDING ON THE CIVILIANS CURRENT
HOSTILITY AND THE AMOUNT OF QUESTIONS ASKED ALREADY
THREATS TOWARDS LOW HOSTILITY CIVS COULD HAVE A HIGHER CHANCE OF RAISING HOSTILITY
WHILE THREATS TOWARDS HIGH HOSTILITY CIVS COULD HAVE A HIGHER CHANCE (MAKE IT BALANCED)

if (floor random 100 > _hostility) then {
	_hostility = ceil (_hostility / 3);
	_civInfo = [_civInfo select 0, _hostility, _civInfo select 2];
	[SCI_Logic, "CivInfo", _civInfo] call ALiVE_fnc_hashSet;
} else {
	if (floor random 100 > 20) then {
		_hostility = ceil (_hostility / 3);
		_civInfo = [_civInfo select 0, _hostility, _civInfo select 2];
		[SCI_Logic, "CivInfo", _civInfo] call ALiVE_fnc_hashSet;
	};
};
*/
