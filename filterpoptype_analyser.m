function [] = filterpoptype_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);
    
val = get(handles2.filterpop_type_analyser, 'value');
if val == handles2.SearchSwimType;
    return;
end;

if val == 1;
    handles2.SearchSwimType = [];
else;
    handles2.SearchSwimType = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);