#include "define.sqf"
private ["_message", "_messageType"];

_message = [_this, 0, "", [""]] call Bis_fnc_param;
_messageType = [_this, 1, "", [""]] call Bis_fnc_param;

_messageType = toLower _messageType;

if(!(_message isEqualTo "")) then
{
	switch (_messageType) do {
	    case "";
	    case "normal":
	    {
	    	PRINT(_message);
		};

		case "error":
		{
			PRINT("![" + _message + "]");
		};

		case "warning":
		{
			if(ShoterAnimation_EnableWarnings) then
			{
				PRINT("[" + _message + "]");
			};
		};

		case "debug":
		{
			if(ShoterAnimation_EnableErrorMessages) then
			{
				PRINT("!" + _message + "!");
			};
		};
	};
};
;