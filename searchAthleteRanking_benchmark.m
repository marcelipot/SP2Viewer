function [] = searchAthleteRanking_benchmark(varargin);


handles = guidata(gcf);

val = get(handles.SearchAthleteRanking_benchmark, 'String');
AthleteGendersListCurrent = get(handles.SelectAthleteRanking_benchmark, 'String');

if length(val) < 3;
    AthleteNamesListMod = handles.AthleteNamesList;
    AthleteNamesListMod{1,1} = 'All Swimmers';
    set(handles.SelectAthleteRanking_benchmark, 'String', AthleteNamesListMod, 'value', 1);
    handles.AthleteNamesListDispRanking = AthleteNamesListMod;
    set(handles.SelectPBRanking_benchmark, 'Value', 1, 'enable', 'on');
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

SearchName = val;



likeepGender = [];
classifier = handles.AthleteGendersList;
if get(handles.SelectGenderRanking_benchmark, 'Value') == 2;
    SearchGender = 'MALE';
    filterGender = 1;
elseif get(handles.SelectGenderRanking_benchmark, 'Value') == 3;
    SearchGender = 'FEMALE';
    filterGender = 1;
else;
    filterGender = 0;
end;

if filterGender == 0;
    AthleteGendersListCurrent = handles.AthleteNamesList;
else;
    lisearch = strcmpi(lower(classifier), lower(SearchGender));
    likeepGender = find(lisearch == 1);
    if isempty(likeepGender) == 1;
        AthleteGendersListCurrent = [];
    else;
        AthleteGendersListCurrent = handles.AthleteNamesList(likeepGender,:);
    end;
end;

lisearch = strfind(lower(AthleteGendersListCurrent), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));

if isempty(likeepName) == 1;
    handles.AthleteNamesListDispRanking = 'None';
else;
    handles.AthleteNamesListDispRanking = AthleteGendersListCurrent(likeepName,1);
end;
set(handles.SelectAthleteRanking_benchmark, 'String', handles.AthleteNamesListDispRanking, 'value', 1);
set(handles.SelectPBRanking_benchmark, 'Value', 3, 'enable', 'off');

guidata(handles.hf_w1_welcome, handles);
