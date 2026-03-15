function [] = listRaceName_benchmark(varargin);


handles = guidata(gcf);

valPerf = get(handles.AthleteRace_list_benchmark, 'Value');
listPerf = get(handles.AthleteRace_list_benchmark, 'String');

PerfEC = listPerf{valPerf};
index = strfind(lower(PerfEC), '----');
index = find(index == 1);

if isempty(index) == 0;
    set(handles.AthleteRace_list_benchmark, 'Value', valPerf+1);
    PerfEC = listPerf{valPerf+1};
    index = strfind(lower(PerfEC), ' -- ');
    index = find(index == 2);
    if isempty(index) == 0;
        PerfEC = listPerf(valPerf+2);
        set(handles.AthleteRace_list_benchmark, 'Value', valPerf+2);
    end;
else;
    index = strfind(lower(PerfEC), ' -- ');
    index = find(index == 2);
    if isempty(index) == 0;
        PerfEC = listPerf{valPerf+1};
        set(handles.AthleteRace_list_benchmark, 'Value', valPerf+1);
    end;
end;
set(handles.AthleteRace_list_benchmark, 'tooltipstring', PerfEC);
guidata(gcf, handles);
