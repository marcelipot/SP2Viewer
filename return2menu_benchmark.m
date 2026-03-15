function [] = return2menu_benchmark(varargin);


handles = guidata(gcf);

%     set(allchild(handles.Question_button_benchmark), 'Visible', 'off');
%     set(allchild(handles.Save_button_benchmark), 'Visible', 'off');
%     set(allchild(handles.Reportpdf_button_benchmark), 'Visible', 'off');
%     set(allchild(handles.Arrowback_button_benchmark), 'Visible', 'off');
%     set(allchild(handles.ClearSearchRanking_benchmark), 'Visible', 'off');
%     set(allchild(handles.ValidateSearchRanking_benchmark), 'Visible', 'off');
set(allchild(handles.MainRanking_benchmark), 'Visible', 'off');
set(allchild(handles.SecondaryRanking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');

set(handles.Question_button_benchmark, 'Visible', 'off');
set(handles.Save_button_benchmark, 'Visible', 'off');
set(handles.Reportpdf_button_benchmark, 'Visible', 'off');
set(handles.Download_button_benchmark, 'Visible', 'off');
set(handles.Refreshcloud_button_benchmark, 'Visible', 'off');
set(handles.Arrowback_button_benchmark, 'Visible', 'off');


set(handles.ClearSearchRanking_benchmark, 'Visible', 'off');
set(handles.ValidateSearchRanking_benchmark, 'Visible', 'off');
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

%Clear custom
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
handles.RaceDistListCustom_benchmark = [];
handles.StrokeListCustom_benchmark = [];
handles.GenderListCustom_benchmark = [];
handles.CourseListCustom_benchmark = [];

set(handles.typeRankingTop10_benchmark, 'Value', 1);
set(handles.typeRankingCustom_benchmark, 'Value', 0);
set(handles.SelectPerformanceCustom_benchmark, 'Visible', 'off');
set(handles.AddFile_button_benchmark, 'Visible', 'off');
set(handles.ClearCustom_button_benchmark, 'Visible', 'off');
set(handles.saveComparison_button_benchmark, 'Visible', 'off');




try;
    [li, co] = size(handles.txtMainRanking);
    for i = 1:li;
        for j = 1:co;
            delete(handles.txtMainRanking{i,j});
        end;
    end;
    handles.txtMainRanking = {};
end;
try;
    [li, co] = size(handles.txtSecondaryRanking);
    for i = 1:li;
        for j = 1:co;
            delete(handles.txtSecondaryRanking{i,j});
        end;
    end;
    handles.txtSecondaryRanking = {};
end;
%     set(allchild(handles.ClearSearchProfile_benchmark), 'Visible', 'off');
%     set(allchild(handles.ValidateSearchProfile_benchmark), 'Visible', 'off');

set(handles.ClearSearchProfile_benchmark, 'Visible', 'off');
set(handles.ValidateSearchProfile_benchmark, 'Visible', 'off');

try;
    [li, co] = size(handles.txtMainProfile);
    for i = 1:li;
        for j = 1:co;
            delete(handles.txtMainProfile{i,j});
        end;
    end;
    handles.txtMainProfile = {};
end;
set(allchild(handles.MainProfile_benchmark), 'Visible', 'off');

set(handles.ranking_toggle_benchmark, 'Visible', 'off');
set(handles.profile_toggle_benchmark, 'Visible', 'off');
set(handles.trend_toggle_benchmark, 'Visible', 'off');
set(handles.typeRankingTop10_benchmark, 'Visible', 'off');
set(handles.typeRankingCustom_benchmark, 'Visible', 'off');
set(handles.SelectRaceRanking_benchmark, 'Visible', 'off');
set(handles.SelectDataRanking_benchmark, 'Visible', 'off');
set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'off');
set(handles.SelectSwimmerProfile_benchmark, 'Visible', 'off');
set(handles.SelectRaceProfile_benchmark, 'Visible', 'off');
set(handles.SelectPopulationProfile_benchmark, 'Visible', 'off');

%---Show axes welcome
set(handles.logo_sparta_main, 'Visible', 'on');
set(allchild(handles.logo_sparta_main), 'Visible', 'on');
set(handles.logo_sparta_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_analyser_main, 'Visible', 'on');
set(allchild(handles.logo_analyser_main), 'Visible', 'on');
set(handles.logo_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_database_main, 'Visible', 'on');
set(allchild(handles.logo_database_main), 'Visible', 'on');
set(handles.logo_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.logo_benchmark_main, 'Visible', 'on');
set(allchild(handles.logo_benchmark_main), 'Visible', 'on');
set(handles.logo_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_analyser_main, 'Visible', 'on');
%     set(allchild(handles.start_analyser_main), 'Visible', 'on');
%     set(handles.start_analyser_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_database_main, 'Visible', 'on');
%     set(allchild(handles.start_database_main), 'Visible', 'on');
%     set(handles.start_database_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
set(handles.start_benchmark_main, 'Visible', 'on');
%     set(allchild(handles.start_benchmark_main), 'Visible', 'on');
%     set(handles.start_benchmark_main, 'XColor', [0 0 0], 'YColor', [0 0 0], 'XTick', [], 'YTick', []);
uistack(handles.logo_sparta_main, 'top');
uistack(handles.logo_analyser_main, 'top');
uistack(handles.logo_database_main, 'top');
uistack(handles.logo_benchmark_main, 'top');
uistack(handles.start_analyser_main, 'top');
uistack(handles.start_database_main, 'top');
uistack(handles.start_benchmark_main, 'top');

%---Show uicontrols welcome
set(handles.txtlasupdate_main, 'Visible', 'on');
set(handles.txtsoftwareversion_main, 'Visible', 'on');
set(handles.txtwelcome_main, 'Visible', 'on');
set(handles.txtlogo_analyser_main, 'Visible', 'on');
set(handles.txtlogo_database_main, 'Visible', 'on');
set(handles.txtlogo_benchmark_main, 'Visible', 'on');
set(handles.tasktodo_main, 'Visible', 'on');
set(handles.txtlasupdate_main, 'String', ['Database last update: ' handles.LastUpdate]);

set(handles.txtpage, 'string', 'Welcome');

guidata(handles.hf_w1_welcome, handles);