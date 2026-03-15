function [] = checkTypeRankingTop10_benchmark(varargin);


handles = guidata(gcf);

valEC = get(handles.typeRankingTop10_benchmark, 'Value');

if valEC == 1;
    if get(handles.SelectRaceRanking_benchmark, 'Visible') == 1;
        %Top 10 already visible
        %Don't do anything
        return;
    else;
        set(handles.typeRankingCustom_benchmark, 'Value', 0);
        %Hide custom
        set(handles.SelectPerformanceCustom_benchmark, 'Visible', 'off');
        set(handles.AddFile_button_benchmark, 'Visible', 'off');
        set(handles.ClearCustom_button_benchmark, 'Visible', 'off');
        set(handles.saveComparison_button_benchmark, 'Visible', 'off');

        %display top 10
        set(handles.SelectGenderRanking_benchmark, 'value', 1);
        set(handles.SelectStrokeRanking_benchmark, 'value', 1);
        set(handles.SelectDistanceRanking_benchmark, 'value', 1);
        set(handles.SelectPoolRanking_benchmark, 'value', 1);
        set(handles.SelectCategoryRanking_benchmark, 'value', 1);
        set(handles.SelectAgeRanking_benchmark, 'value', 1);
        set(handles.SelectDatasetRanking_benchmark, 'value', 1);
        set(handles.SelectPBRanking_benchmark, 'value', 1, 'enable', 'on');
        set(handles.SelectMeetRanking_benchmark, 'value', 1);
        set(handles.SelectTypeRanking_benchmark, 'value', 1);
        set(handles.SelectSeasonRanking_benchmark, 'value', 1);
        set(handles.SelectCountryRanking_benchmark, 'value', 1);
        set(handles.SelectSpartaRanking_benchmark, 'value', 1);
        set(handles.SelectRoundRanking_benchmark, 'value', 1);
        set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
        set(handles.SearchAthleteRanking_benchmark, 'String', '');
        set(handles.SearchAddAthleteRanking_benchmark, 'String', '');

        set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
        set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
        handles.selectAgeLimRanking_benchmark = 0;
        handles.selectAgeRulesRanking_benchmark = 0;
        handles.addPerfRanking = [];
        handles.addPerfProfile = [];
        handles.filelistAddedCustom_benchmark = [];
        handles.databaseCurrent = [];
        handles.existRankings = 0;
        handles.RaceDistListCustom_benchmark = [];
        handles.StrokeListCustom_benchmark = [];
        handles.GenderListCustom_benchmark = [];
        handles.CourseListCustom_benchmark = [];
        
        handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
        AthleteNamesListMod = handles.AthleteNamesList;
        AthleteNamesListMod{1,1} = 'All Swimmers';
        handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
        set(handles.SelectAthleteRanking_benchmark, 'String', AthleteNamesListMod, 'value', 1);
        set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
        set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);

        set(handles.SelectRaceRanking_benchmark, 'Visible', 'on');
        set(handles.SelectDataRanking_benchmark, 'Visible', 'on');
        set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'on');
        set(handles.ClearSearchRanking_benchmark, 'Visible', 'on');
        set(handles.ValidateSearchRanking_benchmark, 'Visible', 'on');


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
    end;
else;
    if get(handles.SelectRaceRanking_benchmark, 'Visible') == 0;
        %Top 10 already visible
        %Don't do anything
        return;
    else;
        set(handles.typeRankingCustom_benchmark, 'Value', 1);
        %Hide top 10
        set(handles.SelectRaceRanking_benchmark, 'Visible', 'off');
        set(handles.SelectDataRanking_benchmark, 'Visible', 'off');
        set(handles.SelectSwimmerRanking_benchmark, 'Visible', 'off');
        set(handles.ClearSearchRanking_benchmark, 'Visible', 'off');
        set(handles.ValidateSearchRanking_benchmark, 'Visible', 'off');

        %display Custom
        set(handles.LoadComparisonCustomRanking_benchmark, 'Value', 1);
        handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(2:end);
        set(handles.AthleteName_list_benchmark, 'String', handles.AthleteNamelistDisp_benchmark, 'Value', 1);
        set(handles.Search_athletename_benchmark, 'String', '');
        handles.AthleteRacelist_benchmark = '';
        handles.AthleteRacelistDisp_benchmark = '';
        set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
        set(handles.Search_racename_benchmark, 'String', '');

        set(handles.SelectPerformanceCustom_benchmark, 'Visible', 'on');
        set(handles.AddFile_button_benchmark, 'Visible', 'on');
        set(handles.ClearCustom_button_benchmark, 'Visible', 'on');
        set(handles.saveComparison_button_benchmark, 'Visible', 'on');

        handles.addPerfRanking = [];
        handles.addPerfProfile = [];
        handles.filelistAddedCustom_benchmark = [];
        handles.databaseCurrent = [];
        handles.existRankings = 0;
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
    end;
end;

guidata(handles.hf_w1_welcome, handles);
