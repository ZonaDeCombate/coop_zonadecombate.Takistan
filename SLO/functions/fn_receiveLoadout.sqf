#define SLO_TEXTBOX 7185

params ["_sender","_loadout"];

//if !(isNull findDisplay 718) exitWith {}; //-- Possibly breaking function
hint "Você recebeu uma loadout";

//-- Exit if player is not in loadout organizer interface
if (isNull findDisplay 721) exitWith {
	_message = format ["Você recebeu um loadout de %1, você deve ter a interface aberta Loadout Organizer quando receber uma loadout, a fim de salvá-lo", _sender];
	hint _message;
};

SLO_TransferLoadout = _loadout;

//-- Create dialog
CreateDialog "SLO_ReceiveLoadout";
_message = format ["Você recebeu uma loadout de %1, você gostaria de aceitar a transferência e carregar a classe?", _sender];

(findDisplay 718 displayCtrl 7185) ctrlSetText _message;