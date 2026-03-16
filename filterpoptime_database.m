function [] = filterpoptime_database(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_time_database, 'value');
if val == handles.SearchPB;
    return;
end;

if val == 1;
    handles.SearchPB = [];
else;
    handles.SearchPB = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
