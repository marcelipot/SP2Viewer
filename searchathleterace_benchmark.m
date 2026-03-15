function [] = searchathleterace_benchmark(varargin);


handles = guidata(gcf);

val = get(handles.Search_racename_benchmark, 'String');

if length(val) < 2;
    set(handles.Search_racename_benchmark, 'String', '');
    set(handles.AthleteRace_list_benchmark, 'string', handles.AthleteRacelist_benchmark, 'value', 1);
    
    handles.AthleteRacelistDisp_benchmark = handles.AthleteRacelist_benchmark;
    guidata(handles.hf_w1_welcome, handles);
    return;
end;
lisearch = strfind(lower(handles.AthleteRacelist_benchmark), 'pb');
lifindPB = find(~cellfun('isempty', lisearch));

SearchName = val;
lisearch = strfind(lower(handles.AthleteRacelist_benchmark(lifindPB(end)+1:end)), lower(SearchName));
likeepName = find(~cellfun('isempty', lisearch));
likeepName = likeepName + lifindPB(end);

lisearch = strfind(lower(handles.AthleteRacelist_benchmark(lifindPB(end)+1:end)), '--');
likeepTitle = find(~cellfun('isempty', lisearch));
likeepTitle = likeepTitle + lifindPB(end);

likeep = sort([likeepName; likeepTitle]);

if isempty(likeepName) == 1;
    handles.AthleteRacelistDisp_benchmark = '';
else;
    handles.AthleteRacelistDisp_benchmark = handles.AthleteRacelist_benchmark(1:lifindPB(end),1);
    li = length(handles.AthleteRacelistDisp_benchmark);
    addExtra = handles.AthleteRacelist_benchmark(likeep,1);
    handles.AthleteRacelistDisp_benchmark(li+1:li+length(addExtra)) = addExtra;
end;
set(handles.AthleteRace_list_benchmark, 'String', handles.AthleteRacelistDisp_benchmark, 'value', 1);

guidata(handles.hf_w1_welcome, handles);
