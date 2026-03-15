function [] = profilepanel_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 2;
    set(handles.profile_toggle_benchmark, 'Value', 1);
    return;
end;

%Hide elements
if handles.currentBenchmarkToggle == 1;
    set(handles.ranking_toggle_benchmark, 'Value', 0);
    set(handles.trend_toggle_benchmark, 'Value', 0);

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
    
    set(handles.typeRankingTop10_benchmark, 'Visible', 'off');
    set(handles.typeRankingCustom_benchmark, 'Visible', 'off');
    set(handles.SelectRaceRanking_benchmark, 'Visible', 'off');
    set(handles.SelectDataRanking_benchmark, 'Visible', 'off');
    set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'off');

elseif handles.currentBenchmarkToggle == 3;
    
end;

%Show Profile elements
set(handles.ClearSearchProfile_benchmark, 'Visible', 'on');
% set(allchild(handles.ClearSearchProfile_benchmark), 'Visible', 'on');
% set(handles.ClearSearchProfile_benchmark, 'XTick', [], 'YTick', []);    
set(handles.ValidateSearchProfile_benchmark, 'Visible', 'on');
% set(allchild(handles.ValidateSearchProfile_benchmark), 'Visible', 'on');
% set(handles.ValidateSearchProfile_benchmark, 'XTick', [], 'YTick', []);
% set(allchild(handles.MainProfile_benchmark), 'Visible', 'on');
% set(handles.MainProfile_benchmark, 'XTick', [], 'YTick', []);

set(handles.SelectSwimmerProfile_benchmark, 'Visible', 'on');
set(handles.SelectRaceProfile_benchmark, 'Visible', 'on');
set(handles.SelectPopulationProfile_benchmark, 'Visible', 'on');

set(handles.SelectAthleteProfile_benchmark, 'Value', 1);
set(handles.SearchAthleteProfile_benchmark, 'String', '');
set(handles.SelectDistanceProfile_benchmark, 'Value', 1);
set(handles.SelectStrokeProfile_benchmark, 'Value', 1);
set(handles.SelectPoolProfile_benchmark, 'Value', 1);
handles.SelectPerfProfileList_benchmark = {'Race';'PB';'SB'};
set(handles.SelectPerfProfile_benchmark, 'Value', 1, 'String', handles.SelectPerfProfileList_benchmark);
set(handles.SelectCountryProfile_benchmark, 'Value', 1);
set(handles.SelectSeasonProfile_benchmark, 'Value', 1);
set(handles.SelectSimilarityProfile_benchmark, 'Value', 1);
set(handles.SelectAgeProfile_benchmark, 'Value', 1);

set(handles.salRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
set(handles.finaRulesProfile_benchmark, 'Value', 0, 'enable', 'off');
set(handles.strictAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
set(handles.belowAgeProfile_benchmark, 'Value', 0, 'enable', 'off');
handles.selectAgeLimProfile_benchmark = 0;
handles.selectAgeRulesProfile_benchmark = 0;
handles.existProfile = 0;
handles.addPerfProfile = [];

handles.AthleteNamesListDispProfile = handles.AthleteNamesList;
set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
set(handles.SelectAgeProfile_benchmark, 'String', handles.SelectAgeProfileList_benchmark, 'Value', 1);

handles.currentBenchmarkToggle = 2;

guidata(handles.hf_w1_welcome, handles);
