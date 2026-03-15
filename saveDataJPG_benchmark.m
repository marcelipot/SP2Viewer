function [] = saveDataJPG_benchmark(varargin);


handles = guidata(gcf);

if handles.currentBenchmarkToggle == 1;
    saveDisplayRankings_benchmark;
elseif handles.currentBenchmarkToggle == 2;
    saveDisplayProfile_benchmark;
else;
    return;
end;

guidata(handles.hf_w1_welcome, handles);