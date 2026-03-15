function [] = clearCustom_benchmark(varargin);


handles = guidata(gcf);

%reset custom rankings
set(handles.LoadComparisonCustomRanking_benchmark, 'Value', 1);
handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(2:end);
set(handles.AthleteName_list_benchmark, 'String', handles.AthleteNamelistDisp_benchmark, 'Value', 1);
set(handles.Search_athletename_benchmark, 'String', '');
handles.AthleteRacelist_benchmark = '';
handles.AthleteRacelistDisp_benchmark = '';
set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
set(handles.Search_racename_benchmark, 'String', '');
handles.addPerfRanking = [];
handles.addPerfProfile = [];
handles.existRankings = 0;
handles.filelistAddedCustom_benchmark = [];
handles.databaseCurrent = [];
handles.databaseCurrentSort = [];
handles.RaceDistListCustom_benchmark = [];
handles.StrokeListCustom_benchmark = [];
handles.GenderListCustom_benchmark = [];
handles.CourseListCustom_benchmark = [];

%reset rankings
set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
set(handles.MainRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);
set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'xtick', [], 'xticklabel', [], 'ytick', [], 'yticklabel', []);

set(handles.MainRanking_benchmark, 'Visible', 'off');
set(handles.SecondaryRanking_benchmark, 'Visible', 'off');
set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');


guidata(handles.hf_w1_welcome, handles);