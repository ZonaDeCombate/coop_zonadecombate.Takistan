//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////				 Save/Load Loudout							/////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "Base_Classes.hpp"

class SLO_SaveLoad
{
	idd = 721;
	movingEnable = 1;
   	 onLoad = "_this spawn SLO_fnc_loadGUI"; 
	class controls 
	{

		class Spyder_SaveLoad_Background: SLO_RscText
		{
			idc = 7211;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 25 * GUI_GRID_W;
			h = 15.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.55};
			colorActive[] = {0,0,0,0.55};
		};
		class SLO_SaveLoad_Header: SLO_RscText
		{
			idc = 7212;

			text = "Zona de Combate Organizador de equipamentos";
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 25 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_LoadoutHeader: SLO_RscText
		{
			idc = 7214;

			text = "Equipamentos";
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
			sizeEx = .9 * GUI_GRID_H;
		};
		class SLO_SaveLoad_ClassLister: SLO_RscListBox
		{
			idc = 7217;

			x = 0.65 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.95 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .75 * GUI_GRID_H;
		};
		class SLO_GearList: SLO_ListNBox
		{
			idc = 72124;
			x = 12.7 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.2 * GUI_GRID_W;
			h = 11.5 * GUI_GRID_H;
			sizeEx = .55 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class SLO_SaveLoad_TypeBox: SLO_RscEdit
		{
			idc = 7215;

			x = 0.54 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .75 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Rename: SLO_RscButton
		{
			idc = 7219;
			action = "[] call SLO_fnc_renameClass";

			text = "Renomear";
			x = 13 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.4};
			colorActive[] = {0,0,0,0.4};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Arsenal: SLO_RscButton
		{
			idc = 72120;
			action = "[] spawn SLO_fnc_openArsenal";

			text = "Arsenal";
			x = 18.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.4};
			colorActive[] = {0,0,0,0.4};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Delete: SLO_RscButton
		{
			idc = 72125;
			action = "[] spawn SLO_fnc_deleteClass";

			text = "Deletar";
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.55};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Save: SLO_RscButton
		{
			idc = 7216;
			action = "[] call SLO_fnc_saveClass";

			text = "Salvar";
			x = 3.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Load: SLO_RscButton
		{
			idc = 7218;
			action = "[] call SLO_fnc_loadClass";

			text = "Carregar";
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_Transfer: SLO_RscButton
		{
			idc = 72122;
			action = "[] spawn SLO_fnc_openTransferMenu";

			text = "Transferir";
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 5.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_LoadOnRespawn: SLO_RscButton
		{
			idc = 72121;
			action = "[] call SLO_fnc_loadOnRespawn";

			text = "Carregar no respawn";
			x = 16.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_SaveLoad_Close: SLO_RscButton
		{
			idc = 7213;
			action = "closeDialog 0";

			text = "Fechar";
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 22.6 * GUI_GRID_H + GUI_GRID_Y;
			w = 3 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.55};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_GearTitle: SLO_RscText
		{
			idc = 72123;
			text = "Gear";
			x = 17 * GUI_GRID_W + GUI_GRID_X;
			y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 2 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_Border1: SLO_RscText
		{
			idc = -1;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.15 * GUI_GRID_W;
			h = 11.66 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_Border2: SLO_RscText
		{
			idc = -1;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.15 * GUI_GRID_W;
			h = 0.15 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_Border3: SLO_RscText
		{
			idc = -1;

			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.25 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.15 * GUI_GRID_W;
			h = 0.15 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_Border4: SLO_RscText
		{
			idc = -1;

			x = 12.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.15 * GUI_GRID_W;
			h = 11.66 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};

};
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////				 Transfer Loadout							/////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class SLO_TransferLoadout
{
	idd = 719;
	movingEnable = 1;
   	onLoad = "";
	onUnload = "SLO_TransferLoadout = nil";
	class controls 
	{

		class SLO_TransferLoadout_Background: SLO_RscText
		{
			idc = 7191;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 13 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.55};
			colorActive[] = {0,0,0,0.55};
		};
		class SLO_TransferLoadout_TransferLoadoutTitle: SLO_RscText
		{
			idc = 7192;

			text = "Transfer Loadout";
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_TransferLoadout_CancelButton: SLO_RscButton
		{
			idc = 7193;
			action = "closeDialog 0";

			text = "Cancelar";
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_TransferLoadout_TransferButton: SLO_RscButton
		{
			idc = 7194;
			action = "[] call SLO_fnc_sendLoadout";

			text = "Transferir";
			x = 13.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_TransferLoadout_UnitsTitle: SLO_RscText
		{
			idc = 7195;
			text = "Unidades";
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 2.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			sizeEx = .9 * GUI_GRID_H;
		};
		class SLO_TransferLoadout_UnitLister: SLO_RscListbox
		{
			idc = 7199;
			x = 8.6 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.2 * GUI_GRID_W;
			h = 9.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .75 * GUI_GRID_H;
		};
		class SLO_TransferLoadout_BorderLeft: SLO_RscText
		{
			idc = 7196;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9.63 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.15 * GUI_GRID_W;
			h = 9.86 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_TransferLoadout_BorderRight: SLO_RscText
		{
			idc = 7197;
			x = 17 * GUI_GRID_W + GUI_GRID_X;
			y = 9.63 * GUI_GRID_H + GUI_GRID_Y;
			w = 0.15 * GUI_GRID_W;
			h = 9.86 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_TransferLoadout_BorderBottom: SLO_RscText
		{
			idc = 7198;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 19.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.65 * GUI_GRID_W;
			h = 0.15 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};
		class SLO_TransferLoadout_BorderTop: SLO_RscText
		{
			idc = 71910;
			x = 8.5 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.65 * GUI_GRID_W;
			h = 0.15 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.4};
			colorActive[] = {0.722,0.694,0.62,0.4};
		};

	};
};

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////				 Receive Loadout							/////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class SLO_ReceiveLoadout
{
	idd = 718;
	movingEnable = 1;
   	onLoad = "";
	onUnload = "SLO_TransferLoadout = nil";
	class controls 
	{

		class SLO_ReceiveLoadout_Background: SLO_RscText
		{
			idc = 7181;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
		};
		class SLO_ReceiveLoadout_Header: SLO_RscText
		{
			idc = 7182;

			text = "Loadout recebido";
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 15 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_ReceiveLoadout_Decline: SLO_RscButton
		{
			idc = 7183;
			action = "closeDialog 0";

			text = "Rejeitar";
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 14.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.4};
			colorActive[] = {0,0,0,0.4};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_ReceiveLoadout_Accept: SLO_RscButton
		{
			idc = 7184;
			action = "[player, SLO_TransferLoadout] call SLO_fnc_loadClass; closeDialog 0";

			text = "Aceitar";
			x = 10.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1.2 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.4};
			colorActive[] = {0,0,0,0.4};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SLO_ReceiveLoadout_TextBox: SLO_RscStructuredText
		{
			idc = 7185;
			text = "";
			x = 2.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .35 * GUI_GRID_H;
		};

	};
};