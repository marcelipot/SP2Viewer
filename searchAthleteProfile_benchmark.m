function [] = searchAthleteProfile_benchmark(varargin);


handles = guidata(gcf);

val = get(handles.SearchAthleteProfile_benchmark, 'String');

if length(val) < 3;
    set(handles.SearchAthleteProfile_benchmark, 'String', '');
    set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
    
    handles.SelectPerfProfileList_benchmark = {'Performance';'PB';'SB'};
    set(handles.SelectPerfProfile_benchmark, 'String', handles.SelectPerfProfileList_benchmark, 'value', 1);
    
    handles.AthleteNamesListDispProfile = handles.AthleteNamesList;
    guidata(handles.hf_w1_welcome, handles);
    return;
end;
SearchName = val;

lisearch = strfind(lower(handles.AthleteNamesList), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));

if isempty(likeepName) == 1;
    handles.AthleteNamesListDispProfile = 'None';
else;
    handles.AthleteNamesListDispProfile = handles.AthleteNamesList(likeepName,1);
end;
set(handles.SelectAthleteProfile_benchmark, 'String', handles.AthleteNamesListDispProfile, 'value', 1);

source = 'popSwimmer';
filter_listRace;

guidata(handles.hf_w1_welcome, handles);
