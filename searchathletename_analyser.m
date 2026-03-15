function [] = searchathletename_analyser(varargin);


handles = guidata(gcf);

val = get(handles.Search_athletename_analyser, 'String');
if length(val) < 3;
    set(handles.Search_athletename_analyser, 'String', '');
    handles.AthleteNamelistDisp_analyser = handles.AthleteNamelist_analyser(2:end);
    set(handles.AthleteName_list_analyser, 'string', handles.AthleteNamelistDisp_analyser, 'value', 1);
    
    handles.AthleteRacelistDisp_analyser = '';
    set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);
    set(handles.Search_racename_analyser, 'String', '')
    
    guidata(handles.hf_w1_welcome, handles);
    return;
end;

SearchName = val;
lisearch = strfind(lower(handles.AthleteNamelist_analyser), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));
if isempty(likeepName) == 1;
    handles.AthleteNamelistDisp_analyser = 'None';
    handles.AthleteRacelistDisp_analyser = '';
    set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);
else;
    handles.AthleteNamelistDisp_analyser = handles.AthleteNamelist_analyser(likeepName,1);
end;
set(handles.AthleteName_list_analyser, 'String', handles.AthleteNamelistDisp_analyser, 'value', 1);

if length(handles.AthleteNamelistDisp_analyser) == 1;
    filter_listRace_analyser;
else;
    handles.AthleteRacelistDisp_analyser = '';
    set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);
end;

guidata(handles.hf_w1_welcome, handles);
