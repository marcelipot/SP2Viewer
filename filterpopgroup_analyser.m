function [] = filterpoppool_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);

val = get(handles2.filterpop_category_analyser, 'value');
if val == handles2.SearchCategory;
    return;
end;

if val == 1;
    handles2.SearchCategory = [];
else;
    handles2.SearchCategory = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);
