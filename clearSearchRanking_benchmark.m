function [] = clearSearchRanking_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 1;
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

    set(handles.salRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.finaRulesRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.strictAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    set(handles.belowAgeRanking_benchmark, 'Value', 0, 'enable', 'off');
    handles.selectAgeLimRanking_benchmark = 0;
    handles.selectAgeRulesRanking_benchmark = 0;
    handles.addPerfRanking = [];
    handles.addPerfProfile = [];
    handles.existRankings = 0;

    handles.AthleteNamesListDispRanking = handles.AthleteNamesList;
    AthleteNamesListMod = handles.AthleteNamesList;
    AthleteNamesListMod{1,1} = 'All Swimmers';
    handles.databaseCurrent = [];
    handles.databaseCurrentSort = [];
    handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
    set(handles.SelectAthleteRanking_benchmark, 'String', AthleteNamesListMod, 'value', 1);
    set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    set(handles.SelectAgeRanking_benchmark, 'String', handles.SelectAgeRankingList_benchmark, 'Value', 1);
end;

guidata(handles.hf_w1_welcome, handles);