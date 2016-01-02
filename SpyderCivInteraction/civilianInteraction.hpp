#include "common.hpp"

class Spyder_CivilianInteraction
{
	idd = 923;
	movingEnable = 1;
	onUnload = "['closeMenu'] call SCI_fnc_civilianInteraction";
	class controls
	{

		class Civilianinteraction_Background: SCI_RscText
		{
			idc = 9231;

			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 30.5 * GUI_GRID_W;
			h = 21 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.65};
			colorActive[] = {0,0,0,0.65};
		};
		class Civilianinteraction_Header: SCI_RscText
		{
			idc = 9232;

			text = "Interação civil"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 30.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .85 * GUI_GRID_H;
		};
		class Civilianinteraction_QuestionsTitle: SCI_RscText
		{
			idc = 9233;

			text = "Questões"; //--- ToDo: Localize;
			x = 15.5 * GUI_GRID_W + GUI_GRID_X;
			y = 6 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
		};
		class Civilianinteraction_QuestionList: SCI_RscListBox
		{
			idc = 9234;

			x = 2.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 7 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .67 * GUI_GRID_H;
		};
		class Civilianinteraction_CivName: SCI_RscText
		{
			idc = 9236;

			x = 14.2 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 2 * GUI_GRID_H;
			sizeEx = 1 * GUI_GRID_H;
		};
		class Civilianinteraction_Credits: SCI_RscText
		{
			idc = 9235;

			text = "Zona de Combate"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 23.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 0.5 * GUI_GRID_H;
			sizeEx = .535 * GUI_GRID_H;
		};
		class Civilianinteraction_ResponseTitle: SCI_RscText
		{
			idc = 9238;

			text = "Resposta"; //--- ToDo: Localize;
			x = 15.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorActive[] = {0,0,0,0};
		};
		class Civilianinteraction_ResponseList: SCI_RscStructuredText
		{
			idc = 9239;

			x = 3 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 29 * GUI_GRID_W;
			h = 7.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class Civilianinteraction_Detain: SCI_RscButton
		{
			idc = 92311;
			action = "['Detain'] call SCI_fnc_commandHandler";

			text = "Deter"; //--- ToDo: Localize;
			x = 13.75 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Civilianinteraction_GetDown: SCI_RscButton
		{
			idc = 92312;
			action = "['getDown'] call SCI_fnc_commandHandler";

			text = "Abaixe-se"; //--- ToDo: Localize;
			x = 18.5 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Civilianinteraction_GoAway: SCI_RscButton
		{
			idc = 92313;
			action = "['goAway'] call SCI_fnc_commandHandler";

			text = "Vá embora"; //--- ToDo: Localize;
			x = 23.25 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Civilianinteraction_Close: SCI_RscButton
		{
			idc = 9237;
			action = "closeDialog 0";

			text = "Fechar"; //--- ToDo: Localize;
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Civilianinteractioninventory_Background: SCI_RscText
		{
			idc = 9240;

			x = 33 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 21 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.65};
			colorActive[] = {0,0,0,0.65};
		};
		class Civilianinteractioninventory_Header: SCI_RscText
		{
			idc = 9241;

			text = "Inventário"; //--- ToDo: Localize;
			x = 33 * GUI_GRID_W + GUI_GRID_X;
			y = 2 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .85 * GUI_GRID_H;
		};
		class Civilianinteraction_Search: SCI_RscButton
		{
			idc = 9242;
			action = "['toggleSearchMenu'] call SCI_fnc_civilianInteraction";

			text = "Procurar"; //--- ToDo: Localize;
			x = 28 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.55 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Civilianinteractioninventory_Close: SCI_RscButton
		{
			idc = 9243;
			action = "['toggleSearchMenu'] call SCI_fnc_civilianInteraction";

			text = "Fechar"; //--- ToDo: Localize;
			x = 33 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
			class Attributes {
				font = "PuristaMedium";
				color = "#C0C0C0";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
			};
		};
		class Civilianinteractioninventory_GearList: SCI_RscListNBox
		{
			idc = 9244;
			x = 33.5 * GUI_GRID_W + GUI_GRID_X;
			y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 11.5 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;
			colorBackground[] = {0.173,0.173,0.173,0.8};
			colorActive[] = {0.173,0.173,0.173,0.8};
		};
		class Civilianinteractioninventory_Confiscate: SCI_RscButton
		{
			idc = 9245;
			action = "['confiscate'] call SCI_fnc_civilianInteraction";

			text = "Confiscar";
			x = 33 * GUI_GRID_W + GUI_GRID_X;
			y = 25.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
			sizeEx = .8 * GUI_GRID_H;
		};

	};
};
