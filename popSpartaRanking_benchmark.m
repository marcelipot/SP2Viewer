function [] = popSpartaRanking_benchmark(varargin);


handles = guidata(gcf);

set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];

guidata(handles.hf_w1_welcome, handles);
