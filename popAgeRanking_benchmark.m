function [] = popAgeRanking_benchmark(varargin);


handles = guidata(gcf);

valAge = get(handles.SelectAgeRanking_benchmark, 'Value');

if valAge > 2;
    handles.selectAgeLimRanking_benchmark = 1;
    handles.selectAgeRulesRanking_benchmark = 2;
    set(handles.strictAgeRanking_benchmark, 'Value', 1, 'enable', 'on');
    set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'on');
    set(handles.salRulesRanking_benchmark, 'enable', 'on');
    set(handles.finaRulesRanking_benchmark, 'enable', 'on');
else;
    handles.selectAgeLimRanking_benchmark = 0;
    handles.selectAgeRulesRanking_benchmark = 0;
    set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.salRulesRanking_benchmark,  'enable', 'off');
    set(handles.finaRulesRanking_benchmark, 'enable', 'off');
end;
set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];

guidata(handles.hf_w1_welcome, handles);
