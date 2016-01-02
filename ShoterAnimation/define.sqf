//#define ADDON_VERSION 1
#define WAIT_FOR_INIT waituntil {!isnil "ShoterAnimation_InitCompleted"}


#define PATH "ShoterAnimation\"
#define ANIM_PATH PATH + "animations\"
#define COMPILE_FILE(file) compile preprocessFileLineNumbers (PATH + file)
#define LOAD_ANIMATION(file) [_object, _parameters] call compile preprocessFileLineNumbers (ANIM_PATH + file + ".sqf")
#define INIT_FNC(fnc_name, file) fnc_name = compile preprocessFileLineNumbers(PATH + file)
#define RED(text) "<t color=""#FF0000"">" + text + "</t>"
#define GREEN(text) "<t color=""#00FF00"">" + text + "</t>"
#define BLUE(text) "<t color=""#0000FF"">" + text + "</t>"
#define YELLOW(text) "<t color=""#FFFF00"">" + text + "</t>"
#define ORANGE(text) "<t color=""#FF6600"">" + text + "</t>"
#define LOG(what) [__FILE__, __LINE__, what] call bis_fnc_log
#define PRINT(what) player globalchat what;
#define DEBUG ShoterAnimation_Debug



#define CURRENT_MOVE (_animations select _animationPhase)
#define END_MOVE (_animations select (_phases+1) )
#define DEAD_MOVE (_animations select (_phases) )
#define NEXT_MOVE _animationPhase = _animationPhase + 1; \
if(_animationPhase >= _phases) then \
	{\
		_animationPhase = 0; \
}