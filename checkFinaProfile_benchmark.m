function [] = checkFinaProfile_benchmark(varargin);


handles = guidata(gcf);

if handles.belowAgeProfile_benchmark == 1;
    set(handles.belowAgeProfile_benchmark, 'Value', 1);
end;
set(handles.salRulesProfile_benchmark, 'Value', 0);
handles.selectAgeRulesProfile_benchmark = 1;

valEC = get(handles.SelectAgeProfile_benchmark, 'Value');
if valEC > length(handles.SelectAgeRankingList2_benchmark);
    valEC = valEC - 1;
end;
set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList2_benchmark, 'Value', valEC);

guidata(handles.hf_w1_welcome, handles);
