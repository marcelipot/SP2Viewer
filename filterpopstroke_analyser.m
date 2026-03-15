function [] = filterpopstroke_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);
    
val = get(handles2.filterpop_stroke_analyser, 'value');
if val == handles2.SearchStrokeType;
    return;
end;

if val == 1;
    handles2.SearchStrokeType = [];
else;
    handles2.SearchStrokeType = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);