function [] = validateSearch_benchmark(varargin);


handles = guidata(gcf);
if handles.currentBenchmarkToggle == 1;
    set(allchild(handles.ClearRace1Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace1Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace2Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace2Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace3Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace3Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace4Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace4Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace5Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace5Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace6Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace6Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace7Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace7Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace8Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace8Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace9Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace9Ranking_benchmark, 'Visible', 'off');
    set(allchild(handles.ClearRace10Ranking_benchmark), 'Visible', 'off');
    set(handles.ClearRace10Ranking_benchmark, 'Visible', 'off');
    drawnow;

    listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');
    valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
    SeasonEC = listSeason{valSeason};

    sourceRankings = 'new';
    sourceRankingsCustom = '';
    filter_ranking_benchmark;
    sort_ranking_benchmark;

    handles.databaseCurrent = databaseCurrent;
    handles.databaseCurrentName = databaseCurrentName;
    handles.databaseCurrentSort = databaseCurrentSort;

    handles.existRankings = 1;
end;

guidata(handles.hf_w1_welcome, handles);