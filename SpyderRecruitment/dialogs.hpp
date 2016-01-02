//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////				Recruitment Menu							/////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "Base_Classes.hpp"

class Spyder_RecruitmentMenu
{
	idd = 570;
	movingEnable = 1;
   	 onLoad = ""; 
	class controls 
	{
		class SpyderRecruitment_Background: SRRscText
		{
			idc = 571;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 4 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 20 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.55};
			colorActive[] = {0,0,0,0.55};
		};
		class SpyderRecruitment_Header: SRRscText
		{
			idc = 572;
			text = "Zona de Combate Menu de Recrutamento";
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 3 * GUI_GRID_H + GUI_GRID_Y;
			w = 24 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = .8 * GUI_GRID_H;
		};
		class SpyderRecruitment_AvailableUnitsTitle: SRRscText
		{
			idc = 573;
			text = "Unidades disponíveis";
			x = 9.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class SpyderRecruitment_AvailableUnitsList: SRRscListBox
		{
			idc = 574;
			x = 8 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 16 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.2};
			colorActive[] = {0.722,0.694,0.62,0.2};
		};
		class SpyderRecruitment_UnitGearTitle: SRRscText
		{
			idc = 575;
			text = "Gear da Unidade";
			x = 22 * GUI_GRID_W + GUI_GRID_X;
			y = 5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class SpyderRecruitment_UnitGearList: SRRscListBox
		{
			idc = 576;
			x = 18.3 * GUI_GRID_W + GUI_GRID_X;
			y = 7 * GUI_GRID_H + GUI_GRID_Y;
			w = 11 * GUI_GRID_W;
			h = 16 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			sizeEx = .7 * GUI_GRID_H;
		};
		class SpyderRecruitment_Close: SRRscButton
		{
			idc = 577;
			action = "closeDialog 0";
			text = "Fechar";
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
		class SpyderRecruitment_Recruit: SRRscButton
		{
			idc = 578;
			action = "['client'] execVM 'SpyderRecruitment\recruitUnit.sqf'";
			text = "Recrutar";
			x = 11.3 * GUI_GRID_W + GUI_GRID_X;
			y = 24.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 4 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
};
};