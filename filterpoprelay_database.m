function [] = filterpoprelay_database(varargin);


handles = guidata(gcf);
val = get(handles.filterpop_relay_database, 'value');
if val == handles.SearchRaceType;
    return;
end;

if val == 1;
    handles.SearchRaceType = [];
else;
    handles.SearchRaceType = val;
end;

handles.sortbyExceptionSelection = 1;
guidata(handles.hf_w1_welcome, handles);
