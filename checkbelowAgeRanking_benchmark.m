function [] = checkbelowAgeRanking_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeLimRanking_benchmark == 1;
    set(handles.belowAgeRanking_benchmark, 'Value', 1);
end;
set(handles.strictAgeRanking_benchmark, 'Value', 0);
handles.selectAgeLimRanking_benchmark = 2;
guidata(handles.hf_w1_welcome, handles);
