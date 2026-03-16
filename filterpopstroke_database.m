function [] = filterpopstroke_database(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_stroke_database, 'value');
if val == handles.SearchStrokeType;
    return;
end;

if val == 1;
    handles.SearchStrokeType = [];
else;
    handles.SearchStrokeType = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
