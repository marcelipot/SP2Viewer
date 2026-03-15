function [] = listAthleteNameCustom_benchmark(varargin);


handles = guidata(gcf);

%change tooltipstring
strAthlete = get(handles.AthleteName_list_benchmark, 'String');
valAthlete = get(handles.AthleteName_list_benchmark, 'Value');
tooltip = strAthlete{valAthlete};
set(handles.AthleteName_list_benchmark, 'tooltipstring', tooltip);

filter_listRace_benchmark;

guidata(handles.hf_w1_welcome, handles);
