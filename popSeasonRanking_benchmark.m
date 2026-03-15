function [] = popSeasonRanking_benchmark(varargin);


handles = guidata(gcf);

valSeason = get(handles.SelectSeasonRanking_benchmark, 'Value');
listSeason = get(handles.SelectSeasonRanking_benchmark, 'String');

SeasonEC = listSeason{valSeason};
index = strfind(lower(SeasonEC), '----');
index = find(index == 1);
if isempty(index) == 0;
    set(handles.SelectSeasonRanking_benchmark, 'Value', valSeason+1);
    SeasonEC = listSeason(valSeason+1);
end;
set(handles.SelectSeasonRanking_benchmark, 'tooltip', SeasonEC);

valPB = get(handles.SelectPBRanking_benchmark, 'value');
if length(SeasonEC) == 9;
    %specific season selected
    handles.SelectPBRankingList_benchmark = {'Performance';'SBs Only';'All'};
    set(handles.SelectPBRanking_benchmark, 'value', valPB, 'String', handles.SelectPBRankingList_benchmark);
    
else;
    %No season
    index = strfind(SeasonEC, 'cycle');
    if isempty(index) == 1;
        %no season selected
        handles.SelectPBRankingList_benchmark = {'Performance';'PBs Only';'All'};
        set(handles.SelectPBRanking_benchmark, 'value', valPB, 'String', handles.SelectPBRankingList_benchmark);
        
    else;
        %Cycle selected
        handles.SelectPBRankingList_benchmark = {'Performance';'CBs Only';'All'};
        set(handles.SelectPBRanking_benchmark, 'value', valPB, 'String', handles.SelectPBRankingList_benchmark);
    
    end;
end;
set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];

guidata(handles.hf_w1_welcome, handles);
