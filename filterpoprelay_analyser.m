function [] = filterpoprelay_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);

val = get(handles2.filterpop_relay_analyser, 'value');
if val == handles2.SearchRaceType;
    return;
end;

if val == 1;
    handles2.SearchRaceType = [];
else;
    handles2.SearchRaceType = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);
