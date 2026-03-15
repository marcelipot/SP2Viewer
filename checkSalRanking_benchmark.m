function [] = checkSalRanking_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeRulesRanking_benchmark == 2;
    set(handles.salRulesRanking_benchmark, 'Value', 1);
end;
set(handles.finaRulesRanking_benchmark, 'Value', 0);
handles.selectAgeRulesRanking_benchmark = 2;

valEC = get(handles.SelectAgeRanking_benchmark, 'Value');
if valEC > length(handles.SelectAgeRankingList_benchmark);
    valEC = valEC - 1;
end;
set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', valEC);

guidata(handles.hf_w1_welcome, handles);
