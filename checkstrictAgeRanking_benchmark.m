function [] = checkstrictAgeRanking_benchmark(varargin);


handles = guidata(gcf);

if handles.selectAgeLimRanking_benchmark == 2;
    set(handles.strictAgeRanking_benchmark, 'Value', 1);
end;
set(handles.belowAgeRanking_benchmark, 'Value', 0);
handles.selectAgeLimRanking_benchmark = 1;
guidata(handles.hf_w1_welcome, handles);
