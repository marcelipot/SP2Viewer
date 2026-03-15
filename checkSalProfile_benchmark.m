function [] = checkSalProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeRulesProfile_benchmark == 2;
    set(handles.salRulesProfile_benchmark, 'Value', 1);
end;
set(handles.finaRulesProfile_benchmark, 'Value', 0);
handles.selectAgeRulesProfile_benchmark = 2;

valEC = get(handles.SelectAgeProfile_benchmark, 'Value');
if valEC > length(handles.SelectAgeProfileList_benchmark);
    valEC = valEC - 1;
end;
set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList_benchmark, 'Value', valEC);

guidata(handles.hf_w1_welcome, handles);
