function [] = filterpopagegroup_database(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_group_database, 'value');
if val == handles.SearchAgeGroup;
    return;
end;

if val == 1;
    handles.SearchAgeGroup = [];
else;
    handles.SearchAgeGroup = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
