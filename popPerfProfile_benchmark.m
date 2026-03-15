function [] = popPerfProfile_benchmark(varargin);


handles = guidata(gcf);

valPerf = get(handles.SelectPerfProfile_benchmark, 'Value');
listPerf = get(handles.SelectPerfProfile_benchmark, 'String');

PerfEC = listPerf{valPerf};
index = strfind(lower(PerfEC), '----');
index = find(index == 1);
if isempty(index) == 0;
    set(handles.SelectPerfProfile_benchmark, 'Value', valPerf+1);
    PerfEC = listPerf(valPerf+1);
end;
set(handles.SelectPerfProfile_benchmark, 'tooltip', PerfEC);

guidata(handles.hf_w1_welcome, handles);
