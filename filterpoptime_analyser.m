function [] = filterpoptime_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);
    
val = get(handles2.filterpop_time_analyser, 'value');
if val == handles2.SearchPB;
    return;
end;

if val == 1;
    handles2.SearchPB = [];
else;
    handles2.SearchPB = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);