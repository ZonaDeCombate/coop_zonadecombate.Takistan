_asymmOpcoms = [];
{
	_moduleType = _x getVariable "moduleType";
	if (!isNil "_moduleType") then {
		if (_moduleType == "ALIVE_OPCOM") then {
			_controlType = _x getVariable "controltype";
			if (_controlType == "asymmetric") then {
				_opcom = _x getVariable "handler";
				_asymmOpcoms pushBack _opcom;
			};
		};
	};
} forEach (entities "Module_F");

_asymmOpcoms