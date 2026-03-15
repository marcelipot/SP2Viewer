function [] = filterpopgender_analyser(varargin);


fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
handles2 = guidata(gcf);
    
val = get(handles2.filterpop_gender_analyser, 'value');
if val == handles2.SearchGender;
    return;
end;

if val == 1;
    handles2.SearchGender = [];
else;
    handles2.SearchGender = val;
end;

handles2.sortbyExceptionSelection = 1;

fh = findobj(0, 'type', 'figure');
set(0, 'CurrentFigure', fh(1).Number);
guidata(gcf, handles2);


% jCBModel.uncheckIndex(1);
% jCBModel.uncheckIndex(3);