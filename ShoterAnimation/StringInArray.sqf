private ["_array", "_value", "_return"];
_value = _this select 0;
_array = _this select 1;
_count = [_this, 2, count _array, [0]] call Bis_fnc_param;

_return = false;
for "_i" from 0 to (_count-1) /* step +1 */ do
{
	_x = _array select _i;
	if(typeName _x isEqualTo "STRING") then
	{
		if ( (tolower _x) isEqualTo (tolower _value) ) exitwith {
			_return = true}
	};
};
_return