function [] = popMeetRanking_benchmark(varargin);


handles = guidata(gcf);

valMeet = get(handles.SelectMeetRanking_benchmark, 'Value');
meetEC = handles.SelectMeetRankingList_benchmark{valMeet,1};

if strcmpi(meetEC, '  ');
    valMeet = valMeet + 2;
    set(handles.SelectMeetRanking_benchmark, 'Value', valMeet);
else;
    if isempty(strfind(meetEC, '--')) == 0;
        valMeet = valMeet + 1;
        set(handles.SelectMeetRanking_benchmark, 'Value', valMeet);
    end;
end;

set(handles.SearchAddAthleteRanking_benchmark, 'String', []);
set(handles.SelectAddAthleteRanking_benchmark, 'String', handles.AthleteNamesList, 'value', 1);
handles.AthleteNamesAddListDispRanking = handles.AthleteNamesList;
handles.addPerfRanking = [];


if valMeet > 2;
    set(handles.SelectSeasonRanking_benchmark, 'enable', 'off');
else;
    set(handles.SelectSeasonRanking_benchmark, 'enable', 'on');
end;

guidata(handles.hf_w1_welcome, handles);