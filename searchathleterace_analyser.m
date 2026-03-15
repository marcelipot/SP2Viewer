function [] = searchathleterace_analyser(varargin);


handles = guidata(gcf);

val = get(handles.Search_racename_analyser, 'String');

if length(val) < 2;
    set(handles.Search_racename_analyser, 'String', '');
    set(handles.AthleteRace_list_analyser, 'string', handles.AthleteRacelist_analyser, 'value', 1);
    
    handles.AthleteRacelistDisp_analyser = handles.AthleteRacelist_analyser;
    guidata(handles.hf_w1_welcome, handles);
    return;
end;
lisearch = strfind(lower(handles.AthleteRacelist_analyser), 'pb');
lifindPB = find(~cellfun('isempty', lisearch));

SearchName = val;
lisearch = strfind(lower(handles.AthleteRacelist_analyser(lifindPB(end)+1:end)), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));
likeepName = likeepName + lifindPB(end);

lisearch = strfind(lower(handles.AthleteRacelist_analyser(lifindPB(end)+1:end)), '--');
likeepTitle = find(~cellfun('isempty', lisearch));
likeepTitle = likeepTitle + lifindPB(end);

likeep = sort([likeepName; likeepTitle]);

if isempty(likeepName) == 1;
    handles.AthleteRacelistDisp_analyser = '';
else;
    handles.AthleteRacelistDisp_analyser = handles.AthleteRacelist_analyser(1:lifindPB(end),1);
    li = length(handles.AthleteRacelistDisp_analyser);
    addExtra = handles.AthleteRacelist_analyser(likeep,1);
    handles.AthleteRacelistDisp_analyser(li+1:li+length(addExtra)) = addExtra;
end;
set(handles.AthleteRace_list_analyser, 'String', handles.AthleteRacelistDisp_analyser, 'value', 1);

guidata(handles.hf_w1_welcome, handles);
