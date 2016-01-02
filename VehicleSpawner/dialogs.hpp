//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////				 Vehicle Menu							/////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "Base_Classes.hpp"

class Spyder_VehicleMenu
{
	idd= 720;
	movingEnable = 1;
	onLoad = "";
	onUnload = "VH_Logic = nil";
	class controls 
	{
		class Spyder_VH_Background: VHRscText
		{
			idc = 7201;

			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 8 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 18 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.55};
			colorActive[] = {0,0,0,0.55};
		};
		class Spyder_VH_Header: VHRscText
		{
			idc = 7202;

			text = "SpyderBlack723 Vehicle Spawner";
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 23 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			colorBackground[] = {0.788,0.443,0.157,0.65};
			colorActive[] = {0.788,0.443,0.157,0.65};
			sizeEx = 1 * GUI_GRID_H;
		};
		class Spyder_VH_VehicleLister: VHRscListBox
		{
			idc = 7203;

			x = 1 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 9 * GUI_GRID_W;
			h = 13.5 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.2};
			colorActive[] = {0.722,0.694,0.62,0.2};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Spyder_VH_VehiclesTitle: VHRscText
		{
			idc = 7204;

			text = "Vehicles";
			x = 2 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			sizeEx = 1.5 * GUI_GRID_H;
		};
		class Spyder_VH_Close: VHRscButton
		{
			idc = 7205;
			action = "closeDialog 0";

			text = "Close";
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 26.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 4.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Spyder_VH_SpawnVehicle: VHRscButton
		{
			idc = 7206;
			action = "[lbData [7203, lbCurSel 7203]] call VH_fnc_spawnVehicle";

			text = "Spawn Vehicle";
			x = 5 * GUI_GRID_W + GUI_GRID_X;
			y = 26.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Spyder_VH_VehiclePicture: VHRscPicture
		{
			idc = 7207;
			text = "";
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 5 * GUI_GRID_H;
		};
		class Spyder_VH_VehicleInfo: VHRscListbox
		{
			idc = 7208;
			x = 11.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17 * GUI_GRID_H + GUI_GRID_Y;
			w = 10 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;
			colorBackground[] = {0.722,0.694,0.62,0.2};
			colorActive[] = {0.722,0.694,0.62,0.2};
			sizeEx = .8 * GUI_GRID_H;
		};
		class Spyder_VH_VehicleInfoHeader: VHRscText
		{
			idc = 7209;

			text = "Vehicle Info";
			x = 12 * GUI_GRID_W + GUI_GRID_X;
			y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 8.5 * GUI_GRID_W;
			h = 1.5 * GUI_GRID_H;
			sizeEx = 1.5 * GUI_GRID_H;
		};
	
};
};