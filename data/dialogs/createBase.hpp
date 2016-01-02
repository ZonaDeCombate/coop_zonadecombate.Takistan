#include "common.hpp"

class Spyder_CreateBase
{
	idd = 823;
	movingEnable = 1;
	class controls 
	{
		class Spyder_CreateBase_Background: SCB_RscText
		{
			idc = 823;

			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 4.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.7};
			colorActive[] = {0,0,0,0.7};
		};
		class Spyder_CreateBase_CreateBaseTitle: SCB_RscText
		{
			idc = 824;

			text = "Criar Base";
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 14 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.7};
			colorActive[] = {0.788,0.443,0.157,0.7};
		};
		class Spyder_CreateBase_BaseNameTitle: SCB_RscText
		{
			idc = 825;

			action = "closeDialog 0";
			text = "Nome da Base";
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Spyder_CreateBase_Close: SCB_RscButton
		{
			idc = 826;

			action = "closeDialog 0";
			text = "Fechar";
			x = 11 * GUI_GRID_W + GUI_GRID_X;
			y = 14.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Spyder_CreateBase_Create: SCB_RscButton
		{
			idc = 827;

			action = "['create'] spawn Spyder_fnc_baseManagement";
			text = "Criar";
			x = 15.75 * GUI_GRID_W + GUI_GRID_X;
			y = 14.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class Spyder_CreateBase_BaseNameBox: SCB_RscEdit
		{
			idc = 828;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.2};
			colorActive[] = {0.722,0.694,0.62,0.2};
		};
		class Spyder_CreateBase_Delete: SCB_RscButton
		{
			idc = 829;

			action = "['delete'] spawn Spyder_fnc_baseManagement";
			text = "Deletar";
			x = 20.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.3 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};