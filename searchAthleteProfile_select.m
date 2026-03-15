function [] = searchAthleteProfile_select(varargin);


handles2 = guidata(gcf);


val = get(handles2.SearchAthleteProfile_select, 'String');

if length(val) < 3;
    set(handles2.SearchAthleteProfile_select, 'String', '');
    set(handles2.SelectAthleteProfile_select, 'String', handles2.AthleteNamesList, 'value', 1);
    
    handles2.SelectPerfProfileList_select = {'Performance';'PB';'SB'};
    set(handles2.SelectPerfProfile_select, 'String', handles2.SelectPerfProfileList_select, 'value', 1);
    
    handles2.AthleteNamesListDispProfile = handles2.AthleteNamesList;
    guidata(handles2.hf_w1_welcome, handles);
    return;
end;

SearchName = val;
lisearch = strfind(lower(handles2.AthleteNamesList), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));

if isempty(likeepName) == 1;
    handles2.AthleteNamesListDispProfile = 'None';
else;
    handles2.AthleteNamesListDispProfile = handles2.AthleteNamesList(likeepName,1);
end;
set(handles2.SelectAthleteProfile_select, 'String', handles2.AthleteNamesListDispProfile, 'value', 1);

SeasonEC = handles2.SeasonEC;
BenchmarkEvents = handles2.BenchmarkEvents;
source = 'Season';
filter_listRace_select;

handles2.SearchAthlete = SearchName;

guidata(gcf, handles2);
