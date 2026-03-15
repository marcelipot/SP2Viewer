function [] = popSeasonProfile_benchmark(varargin);


handles = guidata(gcf);

valSeason = get(handles.SelectSeasonProfile_benchmark, 'Value');
listSeason = get(handles.SelectSeasonProfile_benchmark, 'String');

SeasonEC = listSeason{valSeason};
index = strfind(lower(SeasonEC), '----');
index = find(index == 1);
if isempty(index) == 0;
    set(handles.SelectSeasonProfile_benchmark, 'Value', valSeason+1);
    SeasonEC = listSeason(valSeason+1);
end;
set(handles.SelectSeasonProfile_benchmark, 'tooltip', SeasonEC);

valPB = get(handles.SelectPBProfile_benchmark, 'value');
listRaces = [];

if length(SeasonEC) == 9;
    %specific season selected
    handles.SelectPBProfileList_benchmark = {'Performance';'SBs Only';'All'};
    set(handles.SelectPBProfile_benchmark, 'value', valPB, 'String', handles.SelectPBProfileList_benchmark);
    
    val = get(handles.SelectPerfProfile_benchmark, 'value');
    raceSelect = handles.SelectPerfProfileList_benchmark{val};
    
    index = strfind(SeasonEC, '-');
    dateini = SeasonEC(1:index-1);
    dateend = dateini;
    
    source = 'Season';
    try;
        databaseCurrent = handles.databaseCurrent;
    catch;
        databaseCurrent = handles.FullDB(2:end,:);
    end;
    filter_listRace;

else;
    %No season
    index = strfind(SeasonEC, 'cycle');
    if isempty(index) == 1;
        %no season selected
        handles.SelectPBProfileList_benchmark = {'Performance';'PBs Only';'All'};
        set(handles.SelectPBProfile_benchmark, 'value', valPB, 'String', handles.SelectPBProfileList_benchmark);
        
        val = get(handles.SelectPerfProfile_benchmark, 'value');
        raceSelect = handles.SelectPerfProfileList_benchmark{val};
        
        source = 'popSwimmer';
        try;
            databaseCurrent = handles.databaseCurrent;
        catch;
            databaseCurrent = handles.FullDB(2:end,:);
        end;
        filter_listRace;
    else;
        %Cycle selected
        handles.SelectPBProfileList_benchmark = {'Performance';'CBs Only';'All'};
        set(handles.SelectPBProfile_benchmark, 'value', valPB, 'String', handles.SelectPBProfileList_benchmark);
    
        val = get(handles.SelectPerfProfile_benchmark, 'value');
        raceSelect = handles.SelectPerfProfileList_benchmark{val};
    
        OGyears = [2016 2021 2024 2028 2032 2036];
        index = strfind(SeasonEC, ' ');
        dateini = SeasonEC(index(1)+1:index(2)-1);
        diffyear = abs(OGyears - (str2num(dateini)-4));
        
        [minval, minloc] = min(diffyear);
        dateini = num2str(OGyears(minloc));
        dateend = num2str(str2num(SeasonEC(index(1)+1:index(2)-1))-1);
        
        source = 'Season';
        try;
            databaseCurrent = handles.databaseCurrent;
        catch;
            databaseCurrent = handles.FullDB(2:end,:);
        end;
        filter_listRace;

    end;
end;
lisearch = strfind(lower(listRaces), lower(raceSelect));
if isempty(lisearch) == 1;
    set(handles.SelectPerfProfile_benchmark, 'value', 1);
else;
    likeepName = find(~cellfun('isempty', lisearch));
    if isempty(likeepName) == 0;
        set(handles.SelectPerfProfile_benchmark, 'value', likeepName);
    end;
end;
        
guidata(handles.hf_w1_welcome, handles);
