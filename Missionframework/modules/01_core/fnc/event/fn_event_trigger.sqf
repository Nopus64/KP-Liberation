/*
    KPLIB_fnc_event_trigger

    File: fn_event_trigger.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-05-18
    Last Update: 2018-05-23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Triggers Liberation scripted event handler

    Parameter(s):
        0: STRING - Name of event
        1: ARRAY - Array of arguments passed to triggered event
        2: ANY - OPTIONAL - Where event should be triggered (remoteExec target). Local by default.

    Returns:
    BOOLEAN
*/

params [
    ["_name", nil, [""]],
    ["_arguments", [], [[]]],
    "_targets"
];

private _namespace = KPLIB_eventNamespace;
private _handlers = _namespace getVariable [_name, []];
private _local = isNil "_targets";

// Call every handler for event
{
	if (_x isEqualType {}) then {
        if(_local) then {
		    _arguments call _x;
        }  else {
            [_arguments, _x] remoteExecCall ["call", _targets];
        };
	}
} forEach _handlers;

true
