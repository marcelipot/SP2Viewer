function [] = searchathletenameCustom_benchmark(varargin);


handles = guidata(gcf);

val = get(handles.Search_athletename_benchmark, 'String');
if length(val) < 3;
    handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(2:end);
    set(handles.AthleteName_list_benchmark, 'string', handles.AthleteNamelistDisp_benchmark, 'value', 1);
    set(handles.Search_athletename_benchmark, 'String', '');

    handles.AthleteRacelist_benchmark = '';
    handles.AthleteRacelistDisp_benchmark = '';
    set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
    set(handles.Search_racename_benchmark, 'String', '');
    
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

SearchName = val;
lisearch = strfind(lower(handles.AthleteNamelist_analyser), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));
if isempty(likeepName) == 1;
    handles.AthleteNamelistDisp_benchmark = 'None';
    handles.AthleteRacelist_benchmark = '';
    handles.AthleteRacelistDisp_benchmark = '';
    set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
else;
    handles.AthleteNamelistDisp_benchmark = handles.AthleteNamelist_analyser(likeepName,1);
end;

set(handles.AthleteName_list_benchmark, 'String', handles.AthleteNamelistDisp_benchmark, 'value', 1);

if length(handles.AthleteNamelistDisp_benchmark) == 1;
    filter_listRace_benchmark;
else;
    handles.AthleteRacelist_benchmark = '';
    handles.AthleteRacelistDisp_benchmark = '';
    set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);
end;

guidata(handles.hf_w1_welcome, handles);
