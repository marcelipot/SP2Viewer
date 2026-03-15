function [] = checkFinaRanking_benchmark(varargin);


handles = guidata(gcf);

if handles.belowAgeRanking_benchmark == 1;
    set(handles.belowAgeRanking_benchmark, 'Value', 1);
end;
set(handles.salRulesRanking_benchmark, 'Value', 0);
handles.selectAgeRulesRanking_benchmark = 1;

valEC = get(handles.SelectAgeRanking_benchmark, 'Value');
if valEC > length(handles.SelectAgeRankingList2_benchmark);
    valEC = valEC - 1;
end;
set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList2_benchmark, 'Value', valEC);

guidata(handles.hf_w1_welcome, handles);
