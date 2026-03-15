function [] = popGenderRanking_benchmark(varargin);


handles = guidata(gcf);

set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;

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
AthleteGendersListCurrent2{1,1} = 'All swimmers';
for nameEC = 1:length(AthleteGendersListCurrent);
    AthleteGendersListCurrent2{nameEC+1,1} = AthleteGendersListCurrent{nameEC,1};
end;
set(handles.SelectAthleteRanking_benchmark, 'String', AthleteGendersListCurrent2, 'value', 1);



handles.addPerfRanking = [];

guidata(handles.hf_w1_welcome, handles);
