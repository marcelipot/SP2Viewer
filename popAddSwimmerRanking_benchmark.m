function [] = popAddSwimmerRanking_benchmark(varargin);


handles = guidata(gcf);

valAthlete = get(handles.SelectAddAthleteRanking_benchmark, 'value');
SearchName = handles.AthleteNamesAddListDispRanking(valAthlete);

if strcmpi(SearchName, 'Athlete Name') == 1 | strcmpi(SearchName, 'None') == 1;
    return;
end;
        
lisearch = strfind(lower(handles.AthleteNamesList), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));

if isempty(likeepName) == 1;
    handles.AthleteNamesListDispRanking = 'None';
else;
    handles.AthleteNamesListDispRanking = handles.AthleteNamesList(likeepName,1);
end;
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesListDispRanking, 'value', 1);


valDistance = get(handles.SelectDistanceRanking_benchmark, 'Value');
SearchDistanceSelect = handles.SelectDistanceRankingList_benchmark{valDistance};
SearchDistanceSelect = SearchDistanceSelect(1:end-1);

valStroke = get(handles.SelectStrokeRanking_benchmark, 'Value');
SearchStrokeSelect = handles.SelectStrokeRankingList_benchmark{valStroke};

valPool = get(handles.SelectPoolRanking_benchmark, 'Value');
SearchPoolSelect = handles.SelectPoolRankingList_benchmark{valPool};

valSparta = get(handles.SelectSpartaRanking_benchmark, 'Value');
SearchSparta = valSparta;

listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');
valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
SeasonEC = listSeason{valSeason};

if strcmpi(SearchPoolSelect, 'SCM');
    SearchPoolSelect = '25';
else;
    SearchPoolSelect = '50';
end;

handles.addPerfRanking = [];

if length(handles.AthleteNamesListDispRanking(:,1)) == 1;
    BenchmarkEvents = handles.BenchmarkEvents;
    AgeGroup = handles.AgeGroup;

    if iscell(handles.AthleteNamesListDispRanking) == 1;    
        source = {'Ranking'; handles.AthleteNamesListDispRanking{1,1}};
    else;
        source = {'Ranking'; handles.AthleteNamesListDispRanking};
    end;
    handles2 = create_selecttool_profile(handles.FullDB, handles.icones, SearchStrokeSelect, SearchDistanceSelect, ...
        SearchPoolSelect, SearchSparta, SeasonEC, BenchmarkEvents, AgeGroup, source);
    
    valStop = 0;
    if isempty(handles2) == 0;
        if isfield(handles2, 'SearchPerf') == 1 & isfield(handles2, 'SearchAthlete');
            if isempty(handles2.SearchPerf) == 0;
                handles.SearchPerfSelectRanking = handles2.SearchPerf;
                handles.SearchNameSelectRanking = source{2,1};
                handles.addPerfRanking = 'Perf';

                if isfield(handles2, 'validate') == 1;
                    if strcmpi(handles2.sourceResume, 'validate');
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
                end;
            else;
                valStop = 1;
            end;
        else;
            valStop = 1;
        end;
    else;
        valStop = 1;
    end;
end;
if valStop == 1;
    set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
    set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
    handles.addPerfRanking = [];
end;
    
guidata(handles.hf_w1_welcome, handles);
